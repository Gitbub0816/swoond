#!/usr/bin/env node
// Validates Swoon'd content and contract examples against the JSON Schemas in docs/contracts.
//
//   node validate.mjs            validate everything
//   node validate.mjs --quiet    only print failures + summary
//
// What is validated:
//   docs/courses/*/manifest.json                  -> course-manifest/v1
//   docs/courses/*/curriculum/*.json              -> curriculum/v1  (+ each activity payload against its native-exercise schema)
//   docs/contracts/**/examples/*.json             -> schema chosen by folder/file name (see EXAMPLE_RULES)
// Cross-checks: activity conceptIds must exist in the curriculum concepts[]; ids must be unique.

import { readFileSync, readdirSync, statSync, existsSync } from 'node:fs';
import { join, dirname, resolve, relative, basename } from 'node:path';
import { fileURLToPath } from 'node:url';
import Ajv2020 from 'ajv/dist/2020.js';
import addFormats from 'ajv-formats';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..');
const CONTRACTS = join(ROOT, 'docs', 'contracts');
const COURSES = join(ROOT, 'docs', 'courses');
const quiet = process.argv.includes('--quiet');

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

function validateCurriculum(file, data) {
  let good = validateWith(validators.curriculum, file, data);
  if (!good) return false;
  const problems = [];
  const conceptIds = new Set();
  for (const c of data.concepts) {
    if (conceptIds.has(c.id)) problems.push(`duplicate concept id ${c.id}`);
    conceptIds.add(c.id);
  }
  const seen = new Set();
  const dup = (kind, id) => {
    const k = `${kind}:${id}`;
    if (seen.has(k)) problems.push(`duplicate ${kind} id ${id}`);
    seen.add(k);
  };
  const checkConcepts = (where, ids) => {
    for (const id of ids) if (!conceptIds.has(id)) problems.push(`${where}: unknown conceptId ${id}`);
  };
  const checkPayload = (where, type, payload) => {
    if (type === 'unity-sim') {
      if (!payload.simulationId) problems.push(`${where}: unity-sim payload needs simulationId`);
      return;
    }
    const v = exerciseValidators.get(type);
    if (!v) return problems.push(`${where}: no schema for activity type ${type}`);
    if (!v(payload)) for (const e of errs(v)) problems.push(`${where}: payload ${e}`);
  };
  const unitIds = new Set(data.units.map((u) => u.id));
  for (const u of data.units) {
    dup('unit', u.id);
    for (const pre of u.prerequisiteUnitIds ?? []) if (!unitIds.has(pre)) problems.push(`unit ${u.id}: unknown prerequisite ${pre}`);
    for (const l of u.lessons) {
      dup('lesson', l.id);
      checkConcepts(`lesson ${l.id}`, l.conceptIds);
      for (const a of l.activities) {
        dup('activity', a.id);
        checkConcepts(`activity ${a.id}`, a.conceptIds);
        checkPayload(`activity ${a.id}`, a.type, a.payload);
      }
    }
  }
  for (const t of data.talkTracks ?? []) {
    dup('talkTrack', t.id);
    checkConcepts(`talkTrack ${t.id}`, t.conceptIds);
    checkPayload(`talkTrack ${t.id}`, 'talk-track', t.payload);
  }
  if (problems.length) {
    fail(file, problems);
    return false;
  }
  return true;
}

// 1. Course content
for (const dir of existsSync(COURSES) ? readdirSync(COURSES) : []) {
  const cdir = join(COURSES, dir);
  if (!statSync(cdir).isDirectory()) continue;
  const manifest = join(cdir, 'manifest.json');
  if (existsSync(manifest)) {
    const data = readJson(manifest);
    if (validateWith(validators.manifest, manifest, data)) {
      if (data.courseId !== dir) fail(manifest, [`courseId "${data.courseId}" must equal folder name "${dir}"`]);
      else ok(manifest);
    }
  }
  for (const f of walk(join(cdir, 'curriculum')).filter((x) => x.endsWith('.json'))) {
    const data = readJson(f);
    if (validateCurriculum(f, data)) ok(f);
  }
}

// 2. Contract examples. Folder decides the schema; bridge examples are chosen by file-name suffix.
const EXAMPLE_RULES = [
  { dir: 'unity-bridge', pick: (n) => (n.endsWith('-launch.json') ? 'launch' : n.endsWith('-result.json') ? 'result' : 'message') },
  { dir: 'course-manifest', pick: () => 'manifest' },
  { dir: 'curriculum', pick: () => 'curriculum' },
  { dir: 'sim-definition', pick: () => 'simDef' },
];
for (const f of walk(CONTRACTS).filter((x) => x.endsWith('.json') && x.includes(`${'/'}examples${'/'}`))) {
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
for (const type of exerciseValidators.keys()) {
  const ex = join(CONTRACTS, 'native-exercises', 'v1', 'examples', `${type}.example.json`);
  if (!existsSync(ex)) fail(ex, ['missing example for exercise type']);
}

console.log(`\n${checked} file(s) valid, ${failures} failure(s).`);
process.exit(failures ? 1 : 0);
