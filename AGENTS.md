# Engineering Focus Agent Instructions

Use `skills/engineering-focus/SKILL.md` as the canonical behavior contract for engineering work in this repository.

Default to `BALANCED` mode unless the task or user explicitly selects another mode.

## Repository-specific rules

- Keep the core specification vendor-neutral.
- Put provider/runtime-specific behavior under `integrations/` or the provider's adapter files.
- Do not claim an integration works unless its format/behavior has been verified.
- Preserve Apache-2.0 licensing and third-party attribution.
- Do not copy organization-confidential material into this public repository.
- Changes to modes, schemas, or the canonical skill require matching tests/documentation.
- Prefer complete files over partial snippets when implementing repository changes.

## Validation

Before declaring a change complete, run the relevant schema/conformance tests. If execution is unavailable, state exactly what remains unverified.
