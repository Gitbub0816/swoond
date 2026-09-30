import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { cpSync, existsSync, mkdirSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { extractConfigSchema } from './specs.mjs';
import { tmpdir } from 'node:os';

const here = dirname(fileURLToPath(import.meta.url));
const run = (...args) => spawnSync('node', [join(here, 'validate.mjs'), ...args], { encoding: 'utf8' });
const fixture = (k, ...extra) => run('--courses-dir', join(here, 'test-fixtures', k), '--no-examples', ...extra);

test('good fixture passes schema + lint', () => {
  const r = fixture('good');
  assert.equal(r.status, 0, r.stdout + r.stderr);
  assert.match(r.stdout, /lint ok/);
});

test('bad fixture fails lint, schema still passes', () => {
  const r = fixture('bad');
  assert.equal(r.status, 1, r.stdout);
  for (const rule of ['placeholder', 'duplicate-payload', 'repeated-prompt', 'thin-explanation', 'no-sims']) assert.match(r.stdout, new RegExp(`\\[${rule}\\]`), rule);
  assert.doesNotMatch(r.stderr, /FAIL/);
});

test('bad fixture passes with --no-lint (schema-only)', () => {
  const r = fixture('bad', '--no-lint');
  assert.equal(r.status, 0, r.stdout + r.stderr);
});

test('every real course manifest is valid, its spec files exist and their config schemas compile', () => {
  // Manifests only: curricula of courses still being authored are not part of this check.
  // A course counts as "authored" once its authoring package is complete, marked by live-data.md
  // (the last file of the CDS -> manifest -> sim specs -> exercises -> live-data package). Courses still
  // mid-authoring by another agent (manifest written, sim specs not yet) are skipped so this test is
  // not flaky; `node validate.mjs --partial` still checks every course in the repo.
  const tmp = mkdtempSync(join(tmpdir(), 'swoond-manifests-'));
  try {
    for (const c of readdirSync(join(here, '..', '..', 'docs', 'courses'), { withFileTypes: true })) {
      const m = join(here, '..', '..', 'docs', 'courses', c.name, 'manifest.json');
      if (c.isDirectory() && existsSync(m) && existsSync(join(here, '..', '..', 'docs', 'courses', c.name, 'live-data.md'))) { mkdirSync(join(tmp, c.name)); cpSync(m, join(tmp, c.name, 'manifest.json')); }
    }
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 0, r.stdout + r.stderr);
    assert.match(r.stdout, /sim spec\(s\) checked/);
    assert.doesNotMatch(r.stdout, /^\s*0 sim spec/m);
  } finally { rmSync(tmp, { recursive: true }); }
});

// ---- split layout (contract 1.1) ----
const splitCopy = () => {
  const tmp = mkdtempSync(join(tmpdir(), 'swoond-split-'));
  cpSync(join(here, 'test-fixtures', 'split-good'), tmp, { recursive: true });
  return { tmp, cur: join(tmp, 'american-football', 'curriculum') };
};
const edit = (p, fn) => { const j = JSON.parse(readFileSync(p, 'utf8')); fn(j); writeFileSync(p, JSON.stringify(j, null, 2)); };

test('split-layout fixture merges and passes schema + lint', () => {
  const r = run('--courses-dir', join(here, 'test-fixtures', 'split-good'), '--no-examples');
  assert.equal(r.status, 0, r.stdout + r.stderr);
  assert.match(r.stdout, /\(split\)/);
  assert.match(r.stdout, /8 activities/);
});

test('split: unitOrder missing a unit file is an error on the offending file', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'course.json'), (j) => { j.unitOrder = ['the-basics']; });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /FAIL .*units\/02-defense-basics\.json/);
    assert.match(r.stderr, /not listed in unitOrder/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('split: unitOrder entry without a file is an error on course.json', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'course.json'), (j) => { j.unitOrder.push('ghost-unit'); });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /FAIL .*curriculum\/course\.json/);
    assert.match(r.stderr, /no unit file for it/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('split: duplicate concept id across files is an error', () => {
  const { tmp, cur } = splitCopy();
  try {
    const root = JSON.parse(readFileSync(join(cur, 'course.json'), 'utf8'));
    edit(join(cur, 'units', '02-defense-basics.json'), (j) => { j.concepts = [{ ...root.concepts[0] }]; });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /FAIL .*units\/02-defense-basics\.json/);
    assert.match(r.stderr, /duplicate concept id/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('split: lint runs on the merged course and reports the unit file', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'units', '01-the-basics.json'), (j) => {
      const a = j.unit.lessons[0].activities.find((x) => x.type === 'multiple-choice');
      a.payload.explanation = 'Correct.';
    });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[placeholder\] .*units\/01-the-basics\.json#\/unit\/lessons\/0/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('generator scripts in curriculum/ are a lint error', () => {
  const { tmp, cur } = splitCopy();
  try {
    writeFileSync(join(cur, 'generate.sh'), '#!/bin/sh\necho hi\n');
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[generated-content\] .*generate\.sh/);
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('contract examples still validate', () => {
  const r = run('--no-lint', '--quiet');
  assert.doesNotMatch(r.stderr, /FAIL docs\/contracts/);
});

// ---- lint: thin-lesson ----
test('thin-lesson: a lesson with fewer than 4 activities is an error (unity-sim counts)', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'units', '01-the-basics.json'), (j) => { j.unit.lessons[0].activities = j.unit.lessons[0].activities.slice(0, 3); });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[thin-lesson\] .*units\/01-the-basics\.json#\/unit\/lessons\/0 \(downs-01\): 3 activities/);
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('thin-lesson: exactly 4 activities passes; the unity-sim activity counts toward the 4', () => {
  const r = run('--courses-dir', join(here, 'test-fixtures', 'split-good'), '--no-examples');
  assert.equal(r.status, 0, r.stdout);
  assert.doesNotMatch(r.stdout, /thin-lesson/);
});

// ---- --partial ----
test('partial: unitOrder entries without files are errors normally, tolerated with --course --partial', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'course.json'), (j) => { j.unitOrder.push('later-unit'); });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--course', 'american-football').status, 1);
    const r = run('--courses-dir', tmp, '--no-examples', '--course', 'american-football', '--partial');
    assert.equal(r.status, 0, r.stdout + r.stderr);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('partial: a prerequisite pointing at a not-yet-authored unit in unitOrder is tolerated, an unknown one is not', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'course.json'), (j) => { j.unitOrder.push('later-unit'); });
    edit(join(cur, 'units', '02-defense-basics.json'), (j) => { j.unit.prerequisiteUnitIds = ['later-unit']; });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--course', 'american-football', '--partial').status, 0);
    edit(join(cur, 'units', '02-defense-basics.json'), (j) => { j.unit.prerequisiteUnitIds = ['nowhere']; });
    const r = run('--courses-dir', tmp, '--no-examples', '--course', 'american-football', '--partial');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /unknown prerequisite nowhere/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('partial: no-sims is suppressed, but every other lint rule still errors', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'units', '02-defense-basics.json'), (j) => {
      const acts = j.unit.lessons[0].activities;
      const i = acts.findIndex((a) => a.type === 'unity-sim');
      acts[i] = { ...JSON.parse(JSON.stringify(acts.find((a) => a.id === 'coverage-04-mc'))), id: 'coverage-04-mc2' };
      acts[i].payload.prompt = 'What does Cover 3 leave open near the sideline?';
    });
    const args = ['--courses-dir', tmp, '--no-examples', '--course', 'american-football'];
    const strict = run(...args);
    assert.equal(strict.status, 1);
    assert.match(strict.stdout, /\[no-sims\]/);
    const p = run(...args, '--partial');
    assert.equal(p.status, 0, p.stdout + p.stderr);
    assert.doesNotMatch(p.stdout, /no-sims/);
    // still errors on a real lint problem and on schema problems
    edit(join(cur, 'units', '01-the-basics.json'), (j) => { j.unit.lessons[0].activities[0].payload.explanation.correct = 'Correct.'; });
    assert.equal(run(...args, '--partial').status, 1);
  } finally { rmSync(tmp, { recursive: true }); }
});

// ---- sim spec checks ----
const manifestCopy = () => {
  const tmp = mkdtempSync(join(tmpdir(), 'swoond-spec-'));
  cpSync(join(here, 'test-fixtures', 'split-good'), tmp, { recursive: true });
  return { tmp, manifest: join(tmp, 'american-football', 'manifest.json') };
};
const realSpec = join(here, '..', '..', 'docs', 'courses', 'american-football', 'sims', 'football.coverage.read.v1.md');

test('spec check: missing specPath is an error', () => {
  const { tmp, manifest } = manifestCopy();
  try {
    edit(manifest, (j) => { j.unitySimulations[0].specPath = 'docs/courses/american-football/sims/does-not-exist.md'; });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /spec file not found/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('spec check: configuration schema that does not compile is an error', () => {
  const { tmp, manifest } = manifestCopy();
  try {
    const bad = join(tmp, 'bad-spec.md');
    writeFileSync(bad, '# spec\n\n## 10. Configuration schema\n\n```json\n{ "$schema": "https://json-schema.org/draft/2020-12/schema", "title": "x configuration", "type": "objekt" }\n```\n');
    edit(manifest, (j) => { j.unitySimulations[0].specPath = bad; });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /does not compile/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('spec check: spec without a configuration schema block is an error', () => {
  const { tmp, manifest } = manifestCopy();
  try {
    const none = join(tmp, 'none.md');
    writeFileSync(none, '# spec\n\nNo schema here.\n');
    edit(manifest, (j) => { j.unitySimulations[0].specPath = none; });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /no configuration JSON Schema block found/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('spec extraction: heading section 10 or "<id> configuration" title; ignores non-schema json fences', () => {
  const md = '## 9. Example\n```json\n{"a":1}\n```\n## 10. Configuration schema\n```json\n{"$schema":"https://json-schema.org/draft/2020-12/schema","title":"a.b.c.v1 configuration","type":"object"}\n```\n';
  const r = extractConfigSchema(md, 'a.b.c.v1');
  assert.equal(r.schema.title, 'a.b.c.v1 configuration');
  assert.ok(extractConfigSchema('```json\n{"a":1}\n```', 'a.b.c.v1').error);
  const real = extractConfigSchema(readFileSync(realSpec, 'utf8'), 'football.coverage.read.v1');
  assert.ok(real.schema, real.error);
});

// ---- curriculum 1.2 / manifest 1.1 ----
test('curriculum 1.2 example (branch layer, branches[], lesson live, activity branchId) validates', () => {
  const r = run('--no-lint');
  assert.match(r.stdout, /basketball-branches-1\.2\.json/);
  assert.doesNotMatch(r.stderr, /FAIL docs\/contracts/);
});

test('1.2: layer "branch" needs a unit branchId; activity branchId must not contradict the unit; unknown manifest branch', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u2 = join(cur, 'units', '02-defense-basics.json');
    edit(join(cur, '..', 'manifest.json'), (j) => { j.branches = [{ id: 'nfl', displayName: 'NFL', personalizationDimension: 'league' }, { id: 'college-football', displayName: 'College', personalizationDimension: 'league' }]; });
    edit(join(cur, 'course.json'), (j) => { j.contractVersion = '1.2.0'; j.branches = [{ id: 'nfl', facts: {} }, { id: 'college-football', facts: {} }]; });
    edit(u2, (j) => { j.unit.layer = 'branch'; });
    let r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /branch-layer-mismatch/);
    edit(u2, (j) => { j.unit.branchId = 'nfl'; j.unit.lessons[0].activities[0].branchId = 'college-football'; });
    r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /contradicts unit defense-basics branchId nfl/);
    edit(u2, (j) => { j.unit.lessons[0].activities[0].branchId = 'xfl'; });
    r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.match(r.stderr, /unknown-branch/);
    edit(u2, (j) => { j.unit.lessons[0].activities[0].branchId = 'nfl'; });
    r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 0, r.stdout + r.stderr);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('1.2: unknown-branch: unit with unknown branchId is an error', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u2 = join(cur, 'units', '02-defense-basics.json');
    edit(join(cur, '..', 'manifest.json'), (j) => { j.branches = [{ id: 'nfl', displayName: 'NFL', personalizationDimension: 'league' }]; });
    edit(join(cur, 'course.json'), (j) => { j.contractVersion = '1.2.0'; j.branches = [{ id: 'nfl', facts: {} }]; });
    edit(u2, (j) => { j.unit.branchId = 'xfl'; });
    const r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /unknown-branch.*unknown branchId xfl/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('1.2: branch-layer-mismatch: unit with layer "branch" but no branchId is an error', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u2 = join(cur, 'units', '02-defense-basics.json');
    edit(join(cur, '..', 'manifest.json'), (j) => { j.branches = [{ id: 'nfl', displayName: 'NFL', personalizationDimension: 'league' }]; });
    edit(join(cur, 'course.json'), (j) => { j.contractVersion = '1.2.0'; j.branches = [{ id: 'nfl', facts: {} }]; });
    edit(u2, (j) => { j.unit.layer = 'branch'; });
    const r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /branch-layer-mismatch/);
    assert.match(r.stderr, /layer "branch" requires a unit branchId/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('1.2: contract-version-too-low: 1.2 features under contractVersion 1.1.0 are an error (branch layer, branchId, lesson live, branches[])', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u1 = join(cur, 'units', '01-the-basics.json');
    const u2 = join(cur, 'units', '02-defense-basics.json');
    const root = join(cur, 'course.json');
    edit(join(cur, '..', 'manifest.json'), (j) => { j.branches = [{ id: 'nfl', displayName: 'NFL', personalizationDimension: 'league' }]; });
    edit(root, (j) => { j.contractVersion = '1.1.0'; });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
    const cases = [
      [() => edit(root, (j) => { j.branches = [{ id: 'nfl', facts: {} }]; }), () => edit(root, (j) => { delete j.branches; })],
      [() => edit(u1, (j) => { j.unit.lessons[0].live = { dataKind: 'standings' }; }), () => edit(u1, (j) => { delete j.unit.lessons[0].live; })],
      [() => { edit(root, (j) => { j.branches = [{ id: 'nfl', facts: {} }]; j.contractVersion = '1.1.0'; }); edit(u2, (j) => { j.unit.branchId = 'nfl'; }); }, () => edit(u2, (j) => { delete j.unit.branchId; })],
    ];
    for (const [apply, undo] of cases) {
      apply();
      const r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
      assert.equal(r.status, 1);
      assert.match(r.stderr, /contract-version-too-low/);
      edit(root, (j) => { j.contractVersion = '1.2.0'; });
      assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
      undo();
      edit(root, (j) => { j.contractVersion = '1.1.0'; delete j.branches; });
    }
  } finally { rmSync(tmp, { recursive: true }); }
});

test('1.2: unknown-branch: a branchId with no root branches[] declared is unknown even if the manifest lists it', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u2 = join(cur, 'units', '02-defense-basics.json');
    edit(join(cur, '..', 'manifest.json'), (j) => { j.branches = [{ id: 'nfl', displayName: 'NFL', personalizationDimension: 'league' }]; });
    edit(join(cur, 'course.json'), (j) => { j.contractVersion = '1.2.0'; });
    edit(u2, (j) => { j.unit.lessons[0].activities[0].branchId = 'nfl'; });
    const r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.equal(r.status, 1);
    assert.match(r.stderr, /unknown-branch.*unknown branchId nfl/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('1.2: root branches[] ids must be unique and exist in the manifest; lesson live and root branches pass the schema', () => {
  const { tmp, cur } = splitCopy();
  try {
    edit(join(cur, 'course.json'), (j) => {
      j.contractVersion = '1.2.0';
      j.branches = [{ id: 'nfl', facts: { conference: 'NFC' }, lastVerified: '2026-09-30' }];
    });
    edit(join(cur, 'units', '01-the-basics.json'), (j) => { j.unit.lessons[0].live = { dataKind: 'standings', adapterKey: 'live.standings' }; });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
    edit(join(cur, 'course.json'), (j) => { j.branches.push({ id: 'nfl', facts: {} }); });
    let r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.match(r.stderr, /duplicate branch id nfl/);
    edit(join(cur, 'course.json'), (j) => { j.branches = [{ id: 'not-a-branch', facts: {} }]; });
    r = run('--courses-dir', tmp, '--no-examples', '--no-lint');
    assert.match(r.stderr, /not a branch in the course manifest/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('manifest 1.1: dynamicData kinds injuries, transactions, regulations are valid; unknown kinds are not', () => {
  const { tmp, manifest } = manifestCopy();
  try {
    edit(manifest, (j) => { j.contractVersion = '1.1.0'; for (const k of ['injuries', 'transactions', 'regulations']) j.dynamicData.push({ kind: k, providerCandidates: ['x'], refreshFrequency: 'daily' }); });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 0);
    edit(manifest, (j) => { j.dynamicData.push({ kind: 'gossip', providerCandidates: ['x'], refreshFrequency: 'daily' }); });
    assert.equal(run('--courses-dir', tmp, '--no-examples', '--no-lint').status, 1);
  } finally { rmSync(tmp, { recursive: true }); }
});

// ---- type-monoculture ----
test('type-monoculture: passes when unit has <12 activities', () => {
  const r = run('--courses-dir', join(here, 'test-fixtures', 'split-good'), '--no-examples');
  assert.equal(r.status, 0, r.stdout + r.stderr);
  assert.doesNotMatch(r.stdout, /\[type-monoculture\]/);
});

test('type-monoculture: warns when activity type >40% of a ≥12-activity unit', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u1 = join(cur, 'units', '01-the-basics.json');
    edit(u1, (j) => {
      // Original 4 + add 5 mc + 3 ftg + 2 est + 1 tm = 15 total (6/15 = 40% is not > 40%, need 14 for 6/14=42%)
      // So: 4 + 5 mc + 2 ftg + 2 est + 1 tm = 14 total (6/14 = 42.86% > 40% and < 50%)
      const mc = j.unit.lessons[0].activities.find((a) => a.type === 'multiple-choice');
      const ftg = j.unit.lessons[0].activities.find((a) => a.type === 'fill-the-gap');
      const est = j.unit.lessons[0].activities.find((a) => a.type === 'estimate-slider');
      const tm = j.unit.lessons[0].activities.find((a) => a.type === 'term-match');
      for (let i = 0; i < 5; i++) {
        const clone = JSON.parse(JSON.stringify(mc));
        clone.id = `mc-extra-${i}`;
        clone.payload.prompt = `What is the meaning of this question number ${i}?`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 2; i++) {
        const clone = JSON.parse(JSON.stringify(ftg));
        clone.id = `ftg-extra-${i}`;
        clone.payload.text = `Gap text number ${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 2; i++) {
        const clone = JSON.parse(JSON.stringify(est));
        clone.id = `est-extra-${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 1; i++) {
        const clone = JSON.parse(JSON.stringify(tm));
        clone.id = `tm-extra-${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
    });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[type-monoculture\].*units\/01-the-basics\.json.*exceeds 40%/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('type-monoculture: errors when activity type >50% of a ≥12-activity unit', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u1 = join(cur, 'units', '01-the-basics.json');
    edit(u1, (j) => {
      // Add 16 multiple-choice + 4 other types = 20 activities total (16/20 = 80% > 50%)
      const mc = j.unit.lessons[0].activities.find((a) => a.type === 'multiple-choice');
      const ftg = j.unit.lessons[0].activities.find((a) => a.type === 'fill-the-gap');
      const est = j.unit.lessons[0].activities.find((a) => a.type === 'estimate-slider');
      const tm = j.unit.lessons[0].activities.find((a) => a.type === 'term-match');
      for (let i = 0; i < 14; i++) {
        const clone = JSON.parse(JSON.stringify(mc));
        clone.id = `mc-extra-${i}`;
        clone.payload.prompt = `What is the meaning of this question number ${i}?`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 1; i++) {
        const clone = JSON.parse(JSON.stringify(ftg));
        clone.id = `ftg-extra-${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 1; i++) {
        const clone = JSON.parse(JSON.stringify(est));
        clone.id = `est-extra-${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
      for (let i = 0; i < 1; i++) {
        const clone = JSON.parse(JSON.stringify(tm));
        clone.id = `tm-extra-${i}`;
        j.unit.lessons[0].activities.push(clone);
      }
    });
    const r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[type-monoculture\].*units\/01-the-basics\.json.*exceeds 50%/);
  } finally { rmSync(tmp, { recursive: true }); }
});

// ---- repeated-prompt: say-this has a stock question by design ----
test('repeated-prompt: say-this repetition is judged on the quoted line, not the stock question', () => {
  const { tmp, cur } = splitCopy();
  try {
    const u2 = join(cur, 'units', '02-defense-basics.json');
    const clones = (lines) => (j) => {
      const base = j.unit.lessons[0].activities.find((a) => a.type === 'say-this');
      lines.forEach((text, i) => {
        const c = JSON.parse(JSON.stringify(base));
        c.id = `coverage-04-say-${i}`;
        c.payload.statement.text = text;
        c.payload.translation = `${c.payload.translation} (variant ${i})`;
        j.unit.lessons[0].activities.push(c);
      });
    };
    // Same stock question on 4 activities (base + 3 clones) but four different lines: fine.
    edit(u2, clones(['Their nickel package gets torched on third down.', 'The safeties keep biting on every play fake.', 'We cannot cover the seam route at all.']));
    let r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 0, r.stdout + r.stderr);
    assert.doesNotMatch(r.stdout, /repeated-prompt/);
    // The same quoted line on 3 activities is a real repeat.
    edit(u2, (j) => { j.unit.lessons[0].activities = j.unit.lessons[0].activities.filter((a) => !a.id.startsWith('coverage-04-say-')); });
    edit(u2, clones(['Same line again.', 'Same line again.']));
    edit(u2, (j) => { j.unit.lessons[0].activities.find((a) => a.type === 'say-this').payload.statement.text = 'Same line again.'; });
    r = run('--courses-dir', tmp, '--no-examples');
    assert.equal(r.status, 1);
    assert.match(r.stdout, /\[repeated-prompt\] .*used by 3 activities/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('manifest 1.2: new personalizationDimensions values validate, unknown ones still fail', () => {
  const { tmp, cur } = splitCopy();
  try {
    const m = join(cur, '..', 'manifest.json');
    edit(m, (j) => { j.contractVersion = '1.2.0'; j.personalizationDimensions = ['era', 'designer', 'actor', 'studio', 'format', 'festival', 'venue', 'series']; });
    let r = run('--courses-dir', tmp, '--no-examples');
    assert.doesNotMatch(r.stdout + r.stderr, /FAIL .*manifest/, r.stdout + r.stderr);
    edit(m, (j) => { j.personalizationDimensions = ['era', 'not-a-dimension']; });
    r = run('--courses-dir', tmp, '--no-examples');
    assert.notEqual(r.status, 0, r.stdout);
    assert.match(r.stdout + r.stderr, /personalizationDimensions/);
  } finally { rmSync(tmp, { recursive: true }); }
});

test('manifest 1.3: origin, skin-type, concern and member validate, unknown ones still fail', () => {
  const { tmp, cur } = splitCopy();
  try {
    const m = join(cur, '..', 'manifest.json');
    edit(m, (j) => { j.contractVersion = '1.3.0'; j.personalizationDimensions = ['origin', 'skin-type', 'concern', 'member', 'region']; });
    let r = run('--courses-dir', tmp, '--no-examples');
    assert.doesNotMatch(r.stdout + r.stderr, /FAIL .*manifest/, r.stdout + r.stderr);
    edit(m, (j) => { j.personalizationDimensions = ['origin', 'grape-variety']; });
    r = run('--courses-dir', tmp, '--no-examples');
    assert.notEqual(r.status, 0, r.stdout);
    assert.match(r.stdout + r.stderr, /personalizationDimensions/);
  } finally { rmSync(tmp, { recursive: true }); }
});
