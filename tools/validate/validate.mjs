#!/usr/bin/env node
// Validates Swoon'd content and contract examples against the JSON Schemas in docs/contracts.
//
//   node validate.mjs            validate everything
//   node validate.mjs --quiet    only print failures + summary
//   node validate.mjs --no-lint  schema/cross-checks only (skip content lint)
//   node validate.mjs --course <id>   restrict to one course (skips contract examples)
//   node validate.mjs --courses-dir <dir> --no-examples   validate an alternate courses tree (used by tests)
//   node validate.mjs --lint-max <n>  max lint issues printed per file (default 25; 0 = all)
//
// What is validated:
//   docs/courses/*/manifest.json                  -> course-manifest/v1
//   docs/courses/*/curriculum/*.json              -> curriculum/v1  (+ each activity payload against its native-exercise schema)
//   docs/courses/*/curriculum/course.json + units/*.json  -> split layout (contract 1.1): root + unit schemas, merged, then the
//                                                 same schema + reference checks + lint on the merged curriculum
//   docs/contracts/**/examples/*.json             -> schema chosen by folder/file name (see EXAMPLE_RULES)
// Cross-checks: activity conceptIds must exist in the curriculum concepts[]; ids must be unique.

import { readFileSync, readdirSync, statSync, existsSync } from 'node:fs';
import { join, dirname, resolve, relative, basename } from 'node:path';
import { fileURLToPath } from 'node:url';
import Ajv2020 from 'ajv/dist/2020.js';
import addFormats from 'ajv-formats';
import { lintCourse } from './lint.mjs';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..');
const CONTRACTS = join(ROOT, 'docs', 'contracts');
const argv = process.argv.slice(2);
const flagVal = (n) => (argv.includes(n) ? argv[argv.indexOf(n) + 1] : undefined);
const COURSES = flagVal('--courses-dir') ? resolve(flagVal('--courses-dir')) : join(ROOT, 'docs', 'courses');
const quiet = argv.includes('--quiet');
const doLint = !argv.includes('--no-lint');
const onlyCourse = flagVal('--course');
const noExamples = argv.includes('--no-examples') || !!onlyCourse;
const lintMax = flagVal('--lint-max') !== undefined ? Number(flagVal('--lint-max')) : 25;

const readJson = (p) => JSON.parse(readFileSync(p, 'utf8'));
const walk = (dir) => {
  if (!existsSync(dir)) return [];
  return readdirSync(dir).flatMap((n) => {
    const p = join(dir, n);
    return statSync(p).isDirectory() ? walk(p) : [p];
  });
};

const ajv = new Ajv2020({ strict: true, allowUnionTypes: true, strictRequired: false, strictTypes: false, allErrors: true });
addFormats(ajv);

// Load every *.schema.json under docs/contracts, keyed by file path and $id.
const schemaByPath = new Map();
for (const p of walk(CONTRACTS).filter((f) => f.endsWith('.schema.json'))) {
  const s = readJson(p);
  ajv.addSchema(s);
  schemaByPath.set(p, s);
}
const byRel = (rel) => {
  const s = schemaByPath.get(join(CONTRACTS, rel));
  if (!s) throw new Error(`schema not found: ${rel}`);
  return ajv.getSchema(s.$id);
};

const validators = {
  manifest: byRel('course-manifest/v1/course-manifest.schema.json'),
  curriculum: byRel('curriculum/v1/curriculum.schema.json'),
  curriculumRoot: byRel('curriculum/v1/curriculum-root.schema.json'),
  curriculumUnit: byRel('curriculum/v1/curriculum-unit.schema.json'),
  launch: byRel('unity-bridge/v1/launch-request.schema.json'),
  result: byRel('unity-bridge/v1/simulation-result.schema.json'),
  message: byRel('unity-bridge/v1/bridge-event.schema.json'),
  simDef: byRel('sim-definition/v1/sim-definition.schema.json'),
};

let failures = 0;
let checked = 0;
const fail = (file, msgs) => {
  failures++;
  console.error(`FAIL ${relative(ROOT, file)}`);
  for (const m of msgs) console.error(`     ${m}`);
};
const ok = (file, note = '') => {
  checked++;
  if (!quiet) console.log(`ok   ${relative(ROOT, file)}${note ? '  ' + note : ''}`);
};
const errs = (v) => (v.errors ?? []).map((e) => `${e.instancePath || '/'} ${e.message} ${JSON.stringify(e.params)}`);

function validateWith(v, file, data) {
  if (v(data)) return true;
  fail(file, errs(v));
  return false;
}

// Native exercise schemas, keyed by exercise type (file name minus .schema.json).
const exerciseValidators = new Map();
for (const [p, s] of schemaByPath) {
  if (p.includes(`${join('native-exercises', 'v1')}`)) {
    exerciseValidators.set(basename(p, '.schema.json'), ajv.getSchema(s.$id));
  }
}

// origin (split layout only): { root, unitFiles: file per merged unit index, conceptFiles: file per merged concept index }.
// Problems are attributed to the originating file; without origin everything belongs to `file`.
function validateCurriculum(file, data, origin = null) {
  const bag = new Map();
  const add = (f, m) => (bag.get(f) ?? bag.set(f, []).get(f)).push(m);
  const unitFile = (i) => origin?.unitFiles[i] ?? file;
  const fileForPath = (p) => {
    const m = /^\/(units|concepts)\/(\d+)/.exec(p);
    if (!m || !origin) return file;
    return (m[1] === 'units' ? origin.unitFiles : origin.conceptFiles)[Number(m[2])] ?? file;
  };
  const flush = () => {
    for (const [f, msgs] of bag) fail(f, msgs);
    return bag.size === 0;
  };
  if (!validators.curriculum(data)) {
    for (const e of validators.curriculum.errors ?? []) add(fileForPath(e.instancePath), `${e.instancePath || '/'} ${e.message} ${JSON.stringify(e.params)}`);
    return flush();
  }
  const conceptIds = new Map();
  data.concepts.forEach((c, i) => {
    const f = origin?.conceptFiles[i] ?? file;
    if (conceptIds.has(c.id)) {
      const first = conceptIds.get(c.id);
      add(f, `duplicate concept id ${c.id}` + (first !== f ? ` (also defined in ${relative(ROOT, first)})` : ''));
    } else conceptIds.set(c.id, f);
  });
  const seen = new Set();
  const dup = (f, kind, id) => {
    const k = `${kind}:${id}`;
    if (seen.has(k)) add(f, `duplicate ${kind} id ${id}`);
    seen.add(k);
  };
  const checkConcepts = (f, where, ids) => {
    for (const id of ids) if (!conceptIds.has(id)) add(f, `${where}: unknown conceptId ${id}`);
  };
  const checkPayload = (f, where, type, payload) => {
    if (type === 'unity-sim') {
      if (!payload.simulationId) add(f, `${where}: unity-sim payload needs simulationId`);
      return;
    }
    const v = exerciseValidators.get(type);
    if (!v) return add(f, `${where}: no schema for activity type ${type}`);
    if (!v(payload)) for (const e of errs(v)) add(f, `${where}: payload ${e}`);
  };
  const unitIds = new Set(data.units.map((u) => u.id));
  data.units.forEach((u, i) => {
    const f = unitFile(i);
    dup(f, 'unit', u.id);
    for (const pre of u.prerequisiteUnitIds ?? []) if (!unitIds.has(pre)) add(f, `unit ${u.id}: unknown prerequisite ${pre}`);
    for (const l of u.lessons) {
      dup(f, 'lesson', l.id);
      checkConcepts(f, `lesson ${l.id}`, l.conceptIds);
      for (const a of l.activities) {
        dup(f, 'activity', a.id);
        checkConcepts(f, `activity ${a.id}`, a.conceptIds);
        checkPayload(f, `activity ${a.id}`, a.type, a.payload);
      }
    }
  });
  const rootFile = origin?.root ?? file;
  for (const t of data.talkTracks ?? []) {
    dup(rootFile, 'talkTrack', t.id);
    checkConcepts(rootFile, `talkTrack ${t.id}`, t.conceptIds);
    checkPayload(rootFile, `talkTrack ${t.id}`, 'talk-track', t.payload);
  }
  return flush();
}

// Split layout (contract 1.1): curriculum/course.json + curriculum/units/<NN>-<unit-id>.json.
// Every problem is reported against its own file.
function loadSplitCurriculum(cdir, rootPath) {
  const bad = new Map();
  const add = (f, m) => (bad.get(f) ?? bad.set(f, []).get(f)).push(m);
  const schemaCheck = (v, f, data) => {
    if (!v(data)) for (const e of errs(v)) add(f, e);
  };
  const root = readJson(rootPath);
  schemaCheck(validators.curriculumRoot, rootPath, root);
  const curDir = join(cdir, 'curriculum');
  for (const f of readdirSync(curDir)) {
    const p = join(curDir, f);
    if (statSync(p).isFile() && f.endsWith('.json') && p !== rootPath) add(p, 'unexpected JSON file next to course.json in a split-layout course (unit files belong in units/)');
  }
  const unitPaths = walk(join(curDir, 'units')).filter((x) => x.endsWith('.json')).sort();
  const loaded = [];
  for (const p of unitPaths) {
    const data = readJson(p);
    schemaCheck(validators.curriculumUnit, p, data);
    if (data?.courseId !== undefined && root.courseId !== undefined && data.courseId !== root.courseId) add(p, `courseId "${data.courseId}" must equal root courseId "${root.courseId}"`);
    const m = /^(\d{2,})-(.+)\.json$/.exec(basename(p));
    if (!m) add(p, 'unit file name must be <NN>-<unit-id>.json');
    else if (data?.unit?.id && m[2] !== data.unit.id) add(p, `file name unit id "${m[2]}" must equal unit.id "${data.unit.id}"`);
    loaded.push({ path: p, data });
  }
  // unitOrder must match exactly the set of unit files.
  const fileIds = new Map();
  for (const { path, data } of loaded) {
    const id = data?.unit?.id;
    if (!id) continue;
    if (fileIds.has(id)) add(path, `unit id ${id} also defined in ${relative(ROOT, fileIds.get(id))}`);
    else fileIds.set(id, path);
  }
  const order = Array.isArray(root.unitOrder) ? root.unitOrder : [];
  for (const id of order) if (!fileIds.has(id)) add(rootPath, `unitOrder lists "${id}" but there is no unit file for it`);
  for (const [id, path] of fileIds) if (!order.includes(id)) add(path, `unit "${id}" is not listed in unitOrder of ${relative(ROOT, rootPath)}`);

  // Merge: units in unitOrder; concepts = root then unit-local (in unitOrder), keeping the originating file.
  const byId = new Map(loaded.filter((l) => l.data?.unit?.id).map((l) => [l.data.unit.id, l]));
  const ordered = order.map((id) => byId.get(id)).filter(Boolean);
  const concepts = [];
  const conceptFiles = [];
  for (const c of root.concepts ?? []) { concepts.push(c); conceptFiles.push(rootPath); }
  for (const l of ordered) for (const c of l.data.concepts ?? []) { concepts.push(c); conceptFiles.push(l.path); }
  const merged = {
    contractVersion: root.contractVersion,
    courseId: root.courseId,
    curriculumVersion: root.curriculumVersion,
    locale: root.locale ?? 'en-US',
    concepts,
    units: ordered.map((l) => l.data.unit),
    ...(root.talkTracks ? { talkTracks: root.talkTracks } : {}),
    reviewPolicy: root.reviewPolicy,
  };
  const origin = { root: rootPath, unitFiles: ordered.map((l) => l.path), conceptFiles };
  const lintFiles = [{ path: rootPath, data: { talkTracks: root.talkTracks ?? [] } }, ...ordered.map((l) => ({ path: l.path, data: { unit: l.data.unit } }))];
  return { bad, merged, origin, lintFiles, files: [rootPath, ...loaded.map((l) => l.path)] };
}

// 1. Course content
// Content must be authored, not generated by script: any *.sh / *.py / *.js under curriculum/ is a lint error.
const generatorScripts = (curDir) => walk(curDir).filter((f) => /\.(sh|py|js|mjs|cjs)$/.test(f));
let lintErrors = 0;
let lintWarnings = 0;
function lintStage(dir, manifestData, curricula, scripts = []) {
  if (!curricula.length && !scripts.length) return; // no curriculum yet: nothing to lint
  const { perFile, info } = lintCourse(dir, manifestData, curricula, scripts);
  console.log(`\nLINT ${dir}`);
  for (const l of info) console.log(`  info ${l}`);
  for (const [f, { errors, warnings }] of perFile) {
    lintErrors += errors.length;
    lintWarnings += warnings.length;
    const rules = {};
    for (const e of errors) rules[e.rule] = (rules[e.rule] ?? 0) + 1;
    const tag = errors.length ? 'LINT-FAIL' : 'lint ok  ';
    const by = Object.entries(rules).sort((a, b) => b[1] - a[1]).map(([r, n]) => `${r}=${n}`).join(' ');
    console.log(`${tag} ${relative(ROOT, f)}: ${errors.length} error(s), ${warnings.length} warning(s)${by ? '  [' + by + ']' : ''}`);
    const show = (list, label) => {
      const cap = lintMax > 0 ? lintMax : Infinity;
      for (const e of list.slice(0, cap)) console.log(`     ${label} [${e.rule}] ${relative(ROOT, f)}#${e.msg}`);
      if (list.length > cap) console.log(`     ... ${list.length - cap} more ${label.toLowerCase()}(s); use --lint-max 0 to see all`);
    };
    const rank = ['no-sims', 'duplicate-payload', 'repeated-prompt'];
    const r = (e) => (rank.includes(e.rule) ? rank.indexOf(e.rule) : rank.length);
    show([...errors].sort((a, b) => r(a) - r(b)), 'ERROR');
    show(warnings, 'WARN');
  }
}

for (const dir of existsSync(COURSES) ? readdirSync(COURSES) : []) {
  if (onlyCourse && dir !== onlyCourse) continue;
  const cdir = join(COURSES, dir);
  if (!statSync(cdir).isDirectory()) continue;
  const manifest = join(cdir, 'manifest.json');
  let manifestData = null;
  if (existsSync(manifest)) {
    const data = (manifestData = readJson(manifest));
    if (validateWith(validators.manifest, manifest, data)) {
      if (data.courseId !== dir) fail(manifest, [`courseId "${data.courseId}" must equal folder name "${dir}"`]);
      else ok(manifest);
    }
  }
  const curricula = [];
  const curDir = join(cdir, 'curriculum');
  const rootPath = join(curDir, 'course.json');
  if (existsSync(rootPath)) {
    // Split layout (contract 1.1).
    const sp = loadSplitCurriculum(cdir, rootPath);
    let good = sp.bad.size === 0;
    for (const [f, msgs] of sp.bad) fail(f, msgs);
    if (good) good = validateCurriculum(rootPath, sp.merged, sp.origin);
    if (good) for (const f of sp.files) ok(f, '(split)');
    curricula.push(...sp.lintFiles);
  } else {
    for (const f of walk(curDir).filter((x) => x.endsWith('.json'))) {
      const data = readJson(f);
      if (validateCurriculum(f, data)) ok(f);
      // Lint even when schema checks failed, as long as the file has the basic shape.
      if (Array.isArray(data?.units)) curricula.push({ path: f, data });
    }
  }
  if (doLint) lintStage(dir, manifestData, curricula, generatorScripts(curDir));
}
if (onlyCourse && !existsSync(join(COURSES, onlyCourse))) fail(join(COURSES, onlyCourse), ['unknown course']);

// 2. Contract examples. Folder decides the schema; bridge examples are chosen by file-name suffix.
const EXAMPLE_RULES = [
  { dir: 'unity-bridge', pick: (n) => (n.endsWith('-launch.json') ? 'launch' : n.endsWith('-result.json') ? 'result' : 'message') },
  { dir: 'course-manifest', pick: () => 'manifest' },
  { dir: 'curriculum', pick: () => 'curriculum' },
  { dir: 'sim-definition', pick: () => 'simDef' },
];
// Split-layout examples (examples/split/<courseId>/curriculum/{course.json,units/*.json}) are validated as courses.
for (const sdir of noExamples ? [] : walk(CONTRACTS).filter((x) => x.endsWith(`${'/'}curriculum${'/'}course.json`) && x.includes(`${'/'}examples${'/'}`)).map((x) => dirname(dirname(x)))) {
  const sp = loadSplitCurriculum(sdir, join(sdir, 'curriculum', 'course.json'));
  let good = sp.bad.size === 0;
  for (const [f, msgs] of sp.bad) fail(f, msgs);
  if (good) good = validateCurriculum(join(sdir, 'curriculum', 'course.json'), sp.merged, sp.origin);
  if (good) for (const f of sp.files) ok(f, '(split example)');
}
for (const f of noExamples ? [] : walk(CONTRACTS).filter((x) => x.endsWith('.json') && x.includes(`${'/'}examples${'/'}`) && !x.includes(`${'/'}examples${'/'}split${'/'}`))) {
  const rel = relative(CONTRACTS, f);
  const data = readJson(f);
  const rule = EXAMPLE_RULES.find((r) => rel.startsWith(r.dir + '/'));
  if (rule) {
    const kind = rule.pick(basename(f));
    const good = kind === 'curriculum' ? validateCurriculum(f, data) : validateWith(validators[kind], f, data);
    if (good) ok(f, `(${kind})`);
  } else if (rel.startsWith('native-exercises/')) {
    // example file name: <exercise-type>.example.json  (payload only)
    const type = basename(f).replace(/\.example\.json$/, '');
    const v = exerciseValidators.get(type);
    if (!v) fail(f, [`no native exercise schema for "${type}"`]);
    else if (validateWith(v, f, data)) ok(f, `(${type})`);
  }
}

// 3. Every native exercise schema must ship at least one example.
for (const type of noExamples ? [] : exerciseValidators.keys()) {
  const ex = join(CONTRACTS, 'native-exercises', 'v1', 'examples', `${type}.example.json`);
  if (!existsSync(ex)) fail(ex, ['missing example for exercise type']);
}

console.log(`\n${checked} file(s) valid, ${failures} schema failure(s)` + (doLint ? `, ${lintErrors} lint error(s), ${lintWarnings} lint warning(s).` : ' (lint skipped).'));
process.exit(failures || lintErrors ? 1 : 0);
