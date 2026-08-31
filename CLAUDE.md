# Engineering Focus for Claude

Use `skills/engineering-focus/SKILL.md` as the canonical behavior contract when working in this repository.

Default to `BALANCED` mode.

For implementation and verification tasks, prefer `STRICT`: keep scope bounded, inspect existing work, use deterministic checks, bound retries, and stop when acceptance criteria are satisfied.

For architecture alternatives, hypothesis generation, or adversarial ideation, `EXPLORATORY` may be used deliberately. Exploratory output must be passed through focused validation before being treated as a verified result.

Repository constraints:

- The core specification must remain vendor-neutral.
- Provider-specific behavior belongs in adapters/integration documentation.
- Do not claim unsupported provider capabilities.
- Preserve license and third-party notices.
- Do not add confidential organization-specific material.
