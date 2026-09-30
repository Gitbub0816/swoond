#!/usr/bin/env node
// Builds the app's bundled content pack: content/courses/<id>/ from docs/courses/<id>/.
//
//   node tools/content/build-pack.mjs           write content/courses (generated; never hand-edit)
//   node tools/content/build-pack.mjs --check   exit 1 if content/courses is stale vs docs/courses (CI)
//
// A course is included only if it has manifest.json AND curriculum/course.json and
// `validate.mjs --course <id> --partial` passes (0 schema errors, 0 lint errors; unwritten units are allowed).
// Copied: manifest.json, curriculum/course.json, curriculum/units/*.json (layout BundledContentRepository reads).
// Partial courses: the pack's course.json has `unitOrder` trimmed to units that exist, so the app never sees a
// unitOrder entry without a file (SplitCurriculum would otherwise throw). docs/ is not modified.
// Output is deterministic (sorted, 2-space JSON); INDEX.json's generatedAt is ignored by --check.

import { readFileSync, readdirSync, existsSync, statSync, mkdirSync, writeFileSync, rmSync } from 'node:fs';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..');
const SRC = join(ROOT, 'docs', 'courses');
const OUT = join(ROOT, 'content', 'courses');
const check = process.argv.includes('--check');

const readJson = (p) => JSON.parse(readFileSync(p, 'utf8'));
const fmt = (o) => JSON.stringify(o, null, 2) + '\n';

/** Returns Map<relative path, string> for everything the pack should contain (except INDEX.json). */
function build() {
  const files = new Map();
  const courses = [];
  const skipped = [];
  for (const id of readdirSync(SRC).sort()) {
    const dir = join(SRC, id);
    if (!statSync(dir).isDirectory()) continue;
    const manifestPath = join(dir, 'manifest.json');
    const rootPath = join(dir, 'curriculum', 'course.json');
    if (!existsSync(manifestPath) || !existsSync(rootPath)) continue;
    const r = spawnSync(process.execPath, [join(ROOT, 'tools', 'validate', 'validate.mjs'), '--course', id, '--partial', '--quiet'], { encoding: 'utf8' });
    if (r.status !== 0) { skipped.push(id); continue; }

    const root = readJson(rootPath);
    const unitsDir = join(dir, 'curriculum', 'units');
    const unitFiles = existsSync(unitsDir) ? readdirSync(unitsDir).filter((f) => f.endsWith('.json')).sort() : [];
    const units = unitFiles.map((f) => ({ f, data: readJson(join(unitsDir, f)) }));
    const existing = new Set(units.map((u) => u.data.unit.id));
    const unitOrder = root.unitOrder.filter((u) => existing.has(u));

    files.set(`${id}/manifest.json`, fmt(readJson(manifestPath)));
    files.set(`${id}/curriculum/course.json`, fmt({ ...root, unitOrder }));
    for (const u of units) files.set(`${id}/curriculum/units/${u.f}`, fmt(u.data));
    courses.push({ courseId: id, units: unitOrder.length, plannedUnits: root.unitOrder.length, complete: unitOrder.length === root.unitOrder.length });
  }
  return { files, courses, skipped };
}

const listOut = (dir, base = dir) => (existsSync(dir) ? readdirSync(dir).flatMap((n) => {
  const p = join(dir, n);
  return statSync(p).isDirectory() ? listOut(p, base) : [p.slice(base.length + 1)];
}) : []);

const { files, courses, skipped } = build();
const indexOf = (generatedAt) => fmt({ generatedAt, courses });

if (check) {
  const stale = [];
  const have = new Set(listOut(OUT));
  for (const [rel, text] of files) {
    if (!have.delete(rel)) stale.push(`missing ${rel}`);
    else if (readFileSync(join(OUT, rel), 'utf8') !== text) stale.push(`differs ${rel}`);
  }
  if (!have.delete('INDEX.json')) stale.push('missing INDEX.json');
  else {
    const cur = readJson(join(OUT, 'INDEX.json'));
    if (JSON.stringify(cur.courses) !== JSON.stringify(courses)) stale.push('differs INDEX.json');
  }
  for (const extra of have) stale.push(`extra ${extra}`);
  if (stale.length) {
    console.error(`content/courses is stale (${stale.length}); run: node tools/content/build-pack.mjs`);
    for (const s of stale.slice(0, 40)) console.error(`  ${s}`);
    process.exit(1);
  }
  console.log(`content/courses up to date (${courses.length} course(s)).`);
} else {
  rmSync(OUT, { recursive: true, force: true });
  for (const [rel, text] of files) {
    mkdirSync(dirname(join(OUT, rel)), { recursive: true });
    writeFileSync(join(OUT, rel), text);
  }
  writeFileSync(join(OUT, 'INDEX.json'), indexOf(new Date().toISOString()));
  console.log(`wrote ${courses.length} course(s) to content/courses` + (skipped.length ? `; skipped (validation failed): ${skipped.join(', ')}` : ''));
}
