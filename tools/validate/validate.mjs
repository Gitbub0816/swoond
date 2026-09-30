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
let lintErrors = 0;
let lintWarnings = 0;
function lintStage(dir, manifestData, curricula) {
  if (!curricula.length) return;
  const { perFile, info } = lintCourse(dir, manifestData, curricula);
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
  for (const f of walk(join(cdir, 'curriculum')).filter((x) => x.endsWith('.json'))) {
    const data = readJson(f);
    if (validateCurriculum(f, data)) ok(f);
    // Lint even when schema checks failed, as long as the file has the basic shape.
    if (Array.isArray(data?.units)) curricula.push({ path: f, data });
  }
  if (doLint) lintStage(dir, manifestData, curricula);
}
if (onlyCourse && !existsSync(join(COURSES, onlyCourse))) fail(join(COURSES, onlyCourse), ['unknown course']);

// 2. Contract examples. Folder decides the schema; bridge examples are chosen by file-name suffix.
const EXAMPLE_RULES = [
  { dir: 'unity-bridge', pick: (n) => (n.endsWith('-launch.json') ? 'launch' : n.endsWith('-result.json') ? 'result' : 'message') },
  { dir: 'course-manifest', pick: () => 'manifest' },
  { dir: 'curriculum', pick: () => 'curriculum' },
  { dir: 'sim-definition', pick: () => 'simDef' },
];
for (const f of noExamples ? [] : walk(CONTRACTS).filter((x) => x.endsWith('.json') && x.includes(`${'/'}examples${'/'}`))) {
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
