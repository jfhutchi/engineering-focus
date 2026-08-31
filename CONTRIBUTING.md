# Contributing to Engineering Focus

Engineering Focus is intentionally vendor-neutral. Contributions should improve the common behavioral contract or add a thin provider/runtime adapter without moving provider-specific assumptions into the core specification.

## Before contributing

Please keep these design constraints in mind:

- Correctness and validated quality outrank token reduction.
- `STRICT`, `BALANCED`, `EXPLORATORY`, and `DISABLED` must remain meaningfully distinct.
- The framework must remain easy to disable and benchmark against a baseline.
- Deterministic validation should be preferred when software can verify a claim reliably.
- Context reduction must not discard required evidence, safety constraints, or provenance.
- Provider adapters should be thin. Do not fork the core behavior per vendor unless a platform constraint requires it.
- Do not add organization-confidential examples, prompts, hostnames, credentials, or internal policies.

## Contribution workflow

1. Open or reference an issue for material behavior changes.
2. Keep changes bounded to one concern where practical.
3. Add or update conformance tests for behavioral/schema changes.
4. Update documentation and `CHANGELOG.md` when user-visible behavior changes.
5. Explain any provider-specific limitation in the relevant integration directory.

## Behavior changes

For a proposed behavior rule, document:

- the problem it addresses;
- which modes it affects;
- when the rule should not apply;
- a measurable success criterion;
- how quality will be protected;
- whether it changes telemetry or handoff schemas.

Avoid rules that merely make responses shorter without demonstrating improved execution quality.

## Provider integrations

A provider integration should map the canonical Engineering Focus contract onto the provider's supported instruction/configuration mechanism. It should not redefine the contract.

When the provider lacks a required capability, document the limitation rather than inventing unsupported behavior.

## Testing

Run:

```bash
python -m pip install -r requirements-dev.txt
pytest
```

Tests should fail when the mechanism they claim to protect is removed. Avoid tautological tests that only verify copied constants.

## Licensing and attribution

By contributing, you agree that your contribution may be distributed under the repository's Apache License 2.0.

Do not copy third-party material without preserving its license and required attribution. Update `THIRD_PARTY_NOTICES.md` when necessary.
