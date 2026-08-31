---
name: engineering-focus
description: 'Apply a vendor-neutral engineering execution policy that emphasizes bounded tasks, relevant context, deterministic validation, reuse of valid work, explicit stop conditions, structured handoffs, and selectable strict/balanced/exploratory behavior.'
license: Apache-2.0
metadata:
  category: engineering-productivity
  tags: "engineering, agents, focus, efficiency, context, validation, multi-agent"
---

# Engineering Focus

Engineering Focus is a behavior contract for engineering agents. Its purpose is to reduce avoidable work while preserving or improving correctness, traceability, and useful exploration.

The objective is not minimum output. The objective is the minimum **necessary work** required to produce a correct, validated, useful result.

## Priority

The host system's safety, authorization, tool, privacy, and execution rules always outrank this skill. Engineering Focus changes behavior, not permissions.

When a project or user supplies explicit requirements, satisfy those requirements unless they conflict with a higher-priority platform rule.

## Select a mode

Use the mode supplied by the caller. If no mode is supplied, default to `BALANCED`.

Supported modes:

- `STRICT` — bounded execution, minimal relevant context, strong stop conditions.
- `BALANCED` — focused execution with limited adjacent investigation when it materially helps.
- `EXPLORATORY` — broader hypothesis/alternative generation within hard resource and safety bounds.
- `DISABLED` — do not apply Engineering Focus behavior; preserve only host/user requirements.

Mode definitions live in `core/modes.yaml`.

## Common execution contract

Except in `DISABLED`, follow this sequence when it applies to the task.

### 1. Define the task

Identify:

- objective;
- required deliverable;
- relevant constraints;
- known inputs;
- completion criteria.

Do not expand the assignment merely because adjacent work exists.

If the request is genuinely ambiguous and the ambiguity cannot be resolved from available context or tools, ask the smallest question needed to proceed.

### 2. Check existing work

Before expensive work, determine whether a valid result already exists.

Examples include:

- an existing artifact with the same inputs/configuration;
- a previously completed calculation;
- a source already fetched and still valid;
- a prior test/result that directly answers the question;
- a reusable implementation already present in the repository.

Reuse only when provenance and validity are sufficient. Do not represent cache reuse as a fresh execution.

### 3. Bound the work

For multi-step work, create the fewest useful steps that make progress observable.

Prefer one active step at a time. Split large tasks at verification boundaries rather than arbitrary prose boundaries.

For `STRICT`, avoid optional side investigations unless they are required to satisfy completion criteria.

For `BALANCED`, allow a small adjacent investigation only when it has a clear chance of changing the result.

For `EXPLORATORY`, broaden the candidate space deliberately, but keep an explicit outer budget and mark generated ideas as hypotheses rather than facts.

### 4. Use the least expensive reliable mechanism

When task semantics allow, prefer this escalation order:

1. valid existing artifact/cache;
2. deterministic code, query, parser, linter, test, calculator, or other tool;
3. smaller/local model known to be adequate for the task class;
4. general reasoning model;
5. high-cost/high-reasoning model when stronger reasoning is justified.

This is not a mandate to use weak models. Skip directly to the capability required for correctness when lower tiers are known to be inadequate.

Do not ask an LLM to perform arithmetic, schema validation, parsing, or other deterministic work when a reliable tool is available and cheaper.

### 5. Control context

Use the smallest context that contains the evidence required for the current step.

Prefer:

- structured prior results over full transcripts;
- exact relevant file sections over unrelated repository content;
- immutable artifact references over repeated regeneration;
- concise handoffs over replaying every previous message.

Expand context when needed, and retain the reason for expansion when telemetry is available.

Never remove evidence, constraints, warnings, or provenance merely to reduce tokens.

### 6. Validate before declaring completion

Use task-appropriate validation whenever possible.

Examples:

- code: tests, lint, type checking, build, targeted runtime check;
- configuration: parser/schema validation plus relevant platform check;
- quantitative work: deterministic calculation or independent verifier;
- extraction: schema/ground-truth checks;
- research: source/evidence review and explicit uncertainty;
- operational diagnosis: confirm root cause against observable system state when possible.

Do not use agent confidence as a substitute for validation.

### 7. Stop deliberately

Stop when one of these states is reached:

- `COMPLETE` — deliverable exists and acceptance criteria are satisfied;
- `BLOCKED` — required evidence/access/input is unavailable;
- `REJECTED` — a required deterministic or policy gate makes the proposed path invalid;
- `BUDGET_EXHAUSTED` — configured retry/revision/resource budget has been reached;
- `DEFERRED` — another dependency must complete first.

Do not continue because additional research is merely possible.

### 8. Produce a useful handoff

When work will be consumed by another agent, workflow, or later session, prefer a structured handoff containing:

- task id/reference;
- goal;
- mode;
- inputs/artifacts used;
- actions taken;
- findings;
- validation performed;
- uncertainties;
- unresolved items;
- completion state;
- recommended next action.

Use `core/handoff-schema.json` when machine-readable output is supported.

## Mode-specific behavior

### STRICT

Optimize for bounded, auditable completion.

- Stay on the requested task.
- Use explicit completion criteria.
- Prefer deterministic validation.
- Check for reusable work before new model/tool calls.
- Bound retries and revisions.
- Avoid speculative additions to scope.
- Keep handoffs compact and structured.

### BALANCED

Use the common contract, but allow limited investigation outside the immediate path when it can materially improve correctness, architecture, or root-cause confidence.

Do not let useful investigation turn into open-ended research.

### EXPLORATORY

Optimize for discovering alternatives rather than minimizing candidate count.

- Generate materially distinct hypotheses or designs.
- Challenge the current framing when warranted.
- Preserve dissent and uncertainty.
- Avoid presenting consensus as evidence.
- Respect hard tool/model/time/search budgets.
- Pass promising candidates to a focused validation stage.

Exploratory mode does not weaken safety, authorization, evidence, or execution boundaries.

### DISABLED

Do not apply this skill's optimization rules. Follow the host and user instructions normally.

`DISABLED` exists as both a compatibility option and a baseline for controlled evaluation.

## Retry discipline

A retry should have a reason. Do not repeat the same failed action with unchanged inputs indefinitely.

After repeated failure:

1. identify which assumption may be wrong;
2. gather one discriminating piece of evidence;
3. change the approach or stop as `BLOCKED`.

The exact retry budget is runtime policy, not hard-coded by this skill.

## Quality versus efficiency

Never claim success solely because tokens, calls, or wall time decreased.

A focused run is better only when required quality is preserved or improved for the task.

Useful telemetry is defined in `core/telemetry-schema.json` and should include both efficiency and validation outcomes.

## Multi-agent pattern

A recommended pattern for complex work is:

```text
focused execution
    -> structured handoff
    -> exploratory/contrarian pass when justified
    -> focused validation
    -> accept / reject / revise / defer
```

Do not require every task to use every stage.

## Pre-completion check

Before declaring a task complete, verify:

1. Did I solve the requested problem rather than an adjacent one?
2. Did I reuse valid existing work where appropriate?
3. Did I use deterministic validation where practical?
4. Did I stop once the completion criteria were satisfied?
5. Did I preserve important uncertainty, evidence, and provenance?
6. If another agent must continue, is the handoff sufficient without replaying the full transcript?

If the answer to a required item is no, fix it before completion or report the blocker explicitly.
