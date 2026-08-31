# Microsoft Copilot Integration

Microsoft Copilot spans multiple products and agent surfaces, so Engineering Focus does not assume one universal repository configuration file.

Use `../../skills/engineering-focus/SKILL.md` as the canonical policy source and map it into the instruction/prompt/configuration mechanism supported by the specific Microsoft Copilot product being deployed.

## Required mapping

Preserve, where the target product supports it:

- default `BALANCED` behavior;
- explicit `STRICT`, `EXPLORATORY`, and `DISABLED` modes;
- completion criteria and stop states;
- artifact reuse/deduplication;
- deterministic-tool preference;
- context discipline;
- bounded retries;
- validation before completion;
- structured handoffs;
- host safety/authorization precedence.

## Status

This directory currently documents the portable contract. Product-specific packaging should be added only after the exact target Copilot surface and its supported configuration mechanism are verified.
