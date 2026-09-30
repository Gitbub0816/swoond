import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

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

test('real soccer curriculum fails lint (negative test)', () => {
  const r = run('--course', 'soccer');
  assert.equal(r.status, 1);
  assert.match(r.stdout, /LINT-FAIL/);
  assert.match(r.stdout, /no-sims/);
});

test('contract examples still validate', () => {
  const r = run('--no-lint', '--quiet');
  assert.doesNotMatch(r.stderr, /FAIL docs\/contracts/);
});
