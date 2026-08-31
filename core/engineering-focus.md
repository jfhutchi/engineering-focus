# Engineering Focus Core

This directory contains the machine-readable core policy and schemas used by Engineering Focus.

The canonical human/agent instruction contract is:

`skills/engineering-focus/SKILL.md`

The core files are intentionally vendor-neutral:

- `policy.yaml` — common invariants, escalation order, stop states, quality and security policy.
- `modes.yaml` — behavior differences between `STRICT`, `BALANCED`, `EXPLORATORY`, and `DISABLED`.
- `handoff-schema.json` — portable structured result/handoff contract.
- `telemetry-schema.json` — portable efficiency and quality telemetry contract.

## Architecture

```text
canonical Engineering Focus contract
              |
              +-- core policy/modes/schemas
              |
              +-- provider/runtime adapters
              |       +-- OpenAI / Codex
              |       +-- GitHub Copilot
              |       +-- Microsoft Copilot
              |       +-- Claude
              |       +-- generic/local agents
              |
              +-- workstation distribution
              |
              +-- conformance + benchmark tests
```

Provider adapters may translate or package the contract, but they should not redefine it.

## Normative invariants

Every enabled mode must preserve:

1. host safety and authorization precedence;
2. correctness over cost reduction;
3. explicit mode identity;
4. honest uncertainty and provenance;
5. no new permissions from a behavior mode;
6. no claim that efficiency improved unless quality is also evaluated.

`DISABLED` intentionally does not impose the optimization behavior; it remains the control baseline.
