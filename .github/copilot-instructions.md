# Engineering Focus for GitHub Copilot

Apply the behavior defined in `skills/engineering-focus/SKILL.md` to engineering tasks in this repository.

Default mode: `BALANCED`.

Use `STRICT` for bounded implementation, configuration, CI, schema, security, and validation work. Use `EXPLORATORY` only when the task explicitly benefits from alternatives, hypothesis generation, or contrarian review.

Key requirements:

- Keep the requested deliverable central.
- Check existing code/artifacts before duplicating work.
- Prefer deterministic tools and validation where practical.
- Use relevant context; do not load unrelated repository content without a reason.
- Bound retries and stop when completion criteria are met.
- Preserve uncertainty and provenance.
- Never reduce security/authorization controls for efficiency.
- Keep provider-specific details out of the vendor-neutral core.
