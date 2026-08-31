# Codex Integration

Engineering Focus provides two initial Codex-oriented surfaces:

- repository instructions through `../../AGENTS.md`;
- plugin metadata through `../../.codex-plugin/plugin.json` with the canonical skill under `../../skills/engineering-focus/`.

Default mode should be `BALANCED` unless explicitly overridden.

## Conformance expectations

A Codex installation should preserve mode selection, artifact-reuse checks, deterministic validation, bounded retry/stop behavior, and structured handoffs without granting additional permissions.

The plugin manifest is currently development-stage. Validate installation/loading against the target Codex environment before marking this adapter stable.
