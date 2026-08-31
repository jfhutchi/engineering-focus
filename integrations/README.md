# Integrations

Engineering Focus keeps one canonical behavior contract in `skills/engineering-focus/SKILL.md`. Provider/runtime integrations should adapt that contract to the host's supported instruction mechanism without redefining the core policy.

## Initial status

| Integration | Repository artifact | Status |
|---|---|---|
| OpenAI skill-style interface | `skills/engineering-focus/agents/openai.yaml` | Initial metadata; validation required against target runtime |
| Codex | `.codex-plugin/plugin.json`, `AGENTS.md` | Initial adapter/manifest; end-to-end install validation pending |
| GitHub Copilot | `.github/copilot-instructions.md` | Repository instruction adapter |
| Claude | `CLAUDE.md` | Repository instruction adapter |
| Microsoft Copilot | `integrations/microsoft-copilot/README.md` | Manual policy guidance; product-specific packaging pending |
| Generic/local agents | `AGENTS.md` + canonical `SKILL.md` | Portable instruction path |

## Rule for claims

An adapter must not be marked fully supported until its target runtime has loaded the instructions and a conformance test demonstrates the expected mode behavior.

## Default behavior

Provider adapters should default to `BALANCED` unless the user/runtime selects another mode.

## Conformance target

Regardless of provider, a compliant adapter should be able to preserve:

- explicit mode selection;
- bounded task/completion state;
- artifact reuse awareness;
- deterministic-tool preference when appropriate;
- context discipline;
- bounded retry behavior;
- validation before completion;
- structured handoff capability;
- safety/authorization precedence;
- telemetry identity for the policy/mode where runtime instrumentation exists.
