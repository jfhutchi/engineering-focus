# Engineering Focus — BALANCED

Apply the canonical contract in `skills/engineering-focus/SKILL.md` with mode `BALANCED`.

`BALANCED` is the default general-purpose mode.

## Priorities

1. Correctness, safety, and useful completion.
2. Focused execution with enough investigation to avoid shallow answers.
3. Reuse and deterministic validation where practical.
4. Bounded context, retries, and model/tool escalation.

## Behavior

- Keep the requested outcome central.
- Permit limited adjacent investigation when it can materially change correctness, architecture, or root-cause confidence.
- Prefer evidence that discriminates between plausible explanations rather than collecting context indiscriminately.
- Reuse valid prior work and source artifacts.
- Escalate models/tools when the lower-cost mechanism cannot satisfy the task.
- Validate the deliverable with task-appropriate checks.
- Stop once additional work is unlikely to change the result meaningfully.

## Guardrail

Balanced mode is not open-ended research. If investigation continues to branch without converging, either switch deliberately to `EXPLORATORY` or return to the highest-value unresolved question.
