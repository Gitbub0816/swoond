// Strict content cross-checks (gated behind --strict-content): fill-the-gap tokens and diagram references.
// Pure helpers; validate.mjs does the wiring and reporting.

const TOKEN = /\{\{([^{}]*)\}\}/g;

/**
 * fill-the-gap: every gaps[].id must appear as a {{gap-id}} token in the template and every gap-shaped token must have a gap.
 * Personalization tokens ({{dimension}} / {{dimension|default}}) are not gap tokens: a token with a "|" is always personalization, and a
 * bare token whose name is in the unit's personalizationSlots is personalization. Any other unmatched bare token is a mismatch.
 * Returns an array of problem strings.
 */
export function gapTokenProblems(payload, personalizationSlots = []) {
  const problems = [];
  if (typeof payload?.template !== 'string' || !Array.isArray(payload?.gaps)) return problems;
  const ids = payload.gaps.map((g) => g?.id);
  const tokens = [...payload.template.matchAll(TOKEN)].map((m) => m[1].trim()).filter((t) => !t.includes('|'));
  for (const id of ids) if (!tokens.includes(id)) problems.push(`gap "${id}" has no {{${id}}} token in the template`);
  for (const t of new Set(tokens)) {
    if (!ids.includes(t) && !personalizationSlots.includes(t)) problems.push(`template token {{${t}}} has no matching gap (and is not a unit personalizationSlot)`);
  }
  return problems;
}

/**
 * Diagram/asset reference fields in a payload (hotspot-tap diagram.asset / diagram.diagramId, visual-id image.asset, option image).
 * The contracts declare NO canonical registry of diagrams or assets (diagramId is a free string; asset is a bundle-relative path
 * in the content pack; the manifest has no assets[]), so there is nothing to check a reference against. Returns [] always.
 */
export function diagramProblems() {
  return [];
}
