// Sim spec checks: manifest specPath existence + compile each spec's configuration JSON Schema (draft 2020-12).
// Pure helpers; validate.mjs does the I/O wiring and reporting.
import { readFileSync, existsSync } from 'node:fs';

/** All fenced ```json blocks in markdown text with the heading chain they sit under. */
export function jsonFences(md) {
  const out = [];
  let heading = '';
  let inFence = null; // { lang, lines, heading, line }
  md.split('\n').forEach((line, i) => {
    if (inFence) {
      if (/^\s*```\s*$/.test(line)) {
        out.push({ lang: inFence.lang, text: inFence.lines.join('\n'), heading: inFence.heading, line: inFence.line });
        inFence = null;
      } else inFence.lines.push(line);
      return;
    }
    const f = /^\s*```\s*([A-Za-z0-9_-]*)/.exec(line);
    if (f) { inFence = { lang: f[1].toLowerCase(), lines: [], heading, line: i + 1 }; return; }
    const h = /^(#{1,6})\s+(.*)$/.exec(line);
    if (h) heading = h[2].trim();
  });
  return out.filter((b) => b.lang === 'json');
}

/**
 * Find the configuration schema block for a sim spec: the first json fence under a heading that starts with
 * "10." / "10 " (section 10, "Configuration schema") or mentions "configuration", whose content is a JSON object
 * carrying "$schema" or a "title" ending in "configuration". Returns { schema } or { error }.
 */
export function extractConfigSchema(md, simulationId) {
  const fences = jsonFences(md);
  const under = fences.filter((b) => /^(10[.\s)]|.*configuration)/i.test(b.heading));
  const wantTitle = `${simulationId} configuration`;
  let firstParseError = null;
  const candidates = [...under, ...fences.filter((b) => !under.includes(b))];
  for (const b of candidates) {
    let j;
    try { j = JSON.parse(b.text); } catch (e) { if (under.includes(b) && !firstParseError) firstParseError = `line ${b.line}: invalid JSON (${e.message})`; continue; }
    if (!j || typeof j !== 'object' || Array.isArray(j)) continue;
    const isSchema = typeof j.$schema === 'string' || j.title === wantTitle || /configuration$/i.test(j.title ?? '');
    if (isSchema) return { schema: j, line: b.line };
  }
  return { error: firstParseError ?? `no configuration JSON Schema block found (expected a json fence under "## 10. Configuration schema" or titled "${wantTitle}")` };
}

/** Read a spec file and compile its configuration schema with the given ajv (2020-12). Returns array of problem strings. */
export function checkSpecFile(ajvFactory, path, simulationId) {
  if (!existsSync(path)) return [`spec file not found: ${path}`];
  const { schema, error } = extractConfigSchema(readFileSync(path, 'utf8'), simulationId);
  if (error) return [error];
  if (schema.$schema && !/2020-12/.test(schema.$schema)) return [`configuration schema declares $schema ${schema.$schema}; must be draft 2020-12`];
  try {
    const ajv = ajvFactory();
    const { $id, ...rest } = schema; // avoid $id collisions across specs
    ajv.compile(rest);
  } catch (e) {
    return [`configuration schema does not compile: ${e.message}`];
  }
  return [];
}
