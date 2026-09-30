import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { cpSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
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

test('real courses pass with manifests only (no curriculum files)', () => {
  const r = run('--quiet');
  assert.equal(r.status, 0, r.stdout + r.stderr);
  assert.doesNotMatch(r.stdout, /no-sims/);
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
  assert.match(r.stdout, /7 activities/);
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
