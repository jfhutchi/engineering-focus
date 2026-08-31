# Engineering Focus — STRICT

Apply the canonical contract in `skills/engineering-focus/SKILL.md` with mode `STRICT`.

## Priorities

1. Correctness and safety.
2. Complete the requested deliverable.
3. Reuse valid existing work before new expensive work.
4. Prefer deterministic validation and tooling.
5. Minimize unnecessary context, retries, model calls, and scope.

## Behavior

- State or infer concrete completion criteria before substantial work.
- Keep the active task bounded to the user's request.
- Break multi-step work at meaningful verification boundaries.
- Check existing artifacts/results before regenerating them.
- Prefer deterministic tools for calculations, parsing, validation, linting, tests, and other mechanically verifiable work.
- Expand context only when the current evidence is insufficient.
- A retry must change an input, assumption, diagnostic, or approach.
- Stop when the task is validated as complete or a defined stop state is reached.
- Produce a structured handoff when another agent/session must continue.

## Do not

- Add optional adjacent work without a completion-related reason.
- Continue research after acceptance criteria are satisfied.
- Treat model confidence as validation.
- Remove evidence or safety context for token savings.
- Use a more expensive model simply because it is available.
