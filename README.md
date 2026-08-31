# Engineering Focus

> A vendor-neutral agent behavior framework for focused, efficient AI-assisted engineering.

Engineering Focus is an open framework for improving how AI coding and engineering agents plan work, manage context, use tools, communicate results, and decide when a task is complete.

The project is designed to reduce unnecessary agent work without reducing engineering quality or suppressing useful exploration.

Instead of forcing every agent to behave the same way, Engineering Focus defines multiple operating modes that can be selected based on the type of work being performed.

---

## Why Engineering Focus?

AI engineering agents are extremely capable, but they can also waste significant time and compute by:

- repeatedly analyzing information already available;
- carrying unnecessary context between tasks;
- invoking expensive models for deterministic work;
- retrying failed approaches without a clear stop condition;
- generating long explanations when a structured handoff would be sufficient;
- duplicating work performed by another agent;
- continuing research after the requested task is already complete;
- losing track of the actual objective during long multi-step workflows.

Engineering Focus provides a reusable behavioral layer intended to address those problems.

The goal is not simply to make agents shorter or cheaper.

The goal is:

> **Use the minimum work necessary to produce a correct, validated, useful result.**

---

## Core Principles

Engineering Focus is built around several principles.

### 1. Task clarity

Agents should identify:

- the current objective;
- relevant constraints;
- required outputs;
- dependencies;
- completion criteria.

Large tasks should be decomposed into bounded, observable units of work.

### 2. Context discipline

Agents should prefer the smallest context that contains the information necessary to complete the current task.

Additional context can be loaded when necessary, but context expansion should be intentional rather than automatic.

### 3. Existing-work awareness

Before performing expensive work, agents should determine whether a valid result, artifact, calculation, or previous answer already exists.

Reuse should preserve provenance and validity.

### 4. Deterministic work first

When software can reliably calculate or verify something, the agent should generally prefer deterministic execution over asking an LLM to reason about it.

For example:

```text
cached result
    ↓
deterministic code/tool
    ↓
small/local model
    ↓
general reasoning model
    ↓
high-cost reasoning model
```

This is an escalation model, not a rigid rule. Correctness remains more important than minimizing model use.

### 5. Explicit stop conditions

Agents should know when they are finished.

A task should stop when:

- its acceptance criteria are satisfied;
- a deterministic gate rejects the proposed path;
- required evidence is unavailable;
- an explicit retry/revision limit is reached;
- additional work is unlikely to materially improve the result.

### 6. Structured handoffs

Agents should pass concise structured results between one another instead of requiring downstream agents to repeatedly reconstruct context from full transcripts.

### 7. Exploration remains valuable

Efficiency should not eliminate creativity.

Some tasks benefit from deliberately broader reasoning, contrarian analysis, alternative hypotheses, or unconventional approaches.

Engineering Focus therefore supports multiple behavior modes rather than imposing one universal style.

---

## Operating Modes

Engineering Focus defines four primary modes.

### `STRICT`

Designed for bounded engineering execution where correctness, predictability, and efficiency are the priorities.

Typical uses:

- coding tasks;
- infrastructure changes;
- incident analysis;
- validation;
- deployment automation;
- test generation;
- configuration changes;
- deterministic analysis;
- security or reliability reviews.

Expected behavior includes:

- explicit objective;
- bounded task decomposition;
- minimal relevant context;
- existing-artifact checks;
- bounded retries;
- deterministic verification where possible;
- clear completion conditions;
- structured handoff.

---

### `BALANCED`

The recommended general-purpose default.

Balanced mode preserves the focus controls of Strict mode while allowing limited adjacent investigation when it is likely to improve the result.

Typical uses:

- architecture work;
- design reviews;
- debugging;
- technical research;
- implementation planning;
- complex code changes.

---

### `EXPLORATORY`

Designed for work where novelty and alternative thinking are important.

Typical uses:

- brainstorming;
- hypothesis generation;
- architecture exploration;
- red-team analysis;
- contrarian review;
- root-cause hypothesis generation;
- alternative solution discovery.

Exploratory agents may investigate more possibilities, but they still operate inside defined resource and safety boundaries.

Exploration generates possibilities.

It does not automatically establish correctness.

A common pattern is:

```text
Focused execution
        ↓
Structured result
        ↓
Exploratory / contrarian review
        ↓
New hypotheses or alternatives
        ↓
Focused validation
        ↓
Accept / Reject / Revise
```

---

### `DISABLED`

Runs without Engineering Focus behavior.

This mode exists for:

- compatibility;
- testing;
- benchmarking;
- controlled comparisons;
- workloads where Engineering Focus is not appropriate.

It also provides an important baseline for determining whether Engineering Focus actually improves a workload.

---

## Example Handoff

A focused agent may produce a handoff similar to:

```yaml
task_id: ENG-142
goal: Correct failing deployment validation

mode: strict

inputs_used:
  - deployment workflow
  - failing test output

artifacts_checked:
  - existing workflow configuration
  - previous validation results

actions_taken:
  - identified incorrect environment mapping
  - corrected mapping
  - ran validation

findings:
  - deployment failure was caused by environment normalization

validation:
  tests_passed: true

uncertainties: []

completion_state: complete

recommended_next_action:
  - merge after normal review
```

This allows another agent to understand the result without replaying the entire reasoning history.

---

## Intended Integrations

Engineering Focus is designed to remain vendor-neutral.

Planned or supported integration targets may include:

- OpenAI
- Codex
- GitHub Copilot
- Microsoft Copilot
- Anthropic Claude
- OpenAI-compatible APIs
- local model runtimes
- multi-agent orchestration frameworks
- custom engineering agents

Provider-specific implementations should remain adapters around a common Engineering Focus specification.

The core behavioral contract should not depend on one model vendor.

---

## Developer Workstations

Engineering Focus is intended to support both individual developer use and agent-runtime use.

A developer can apply Engineering Focus as the default behavior for compatible coding or engineering agents on their workstation.

An orchestration system can dynamically assign behavior modes to individual tasks.

For example:

```yaml
engineering_focus:
  mode: balanced
```

Or:

```yaml
agents:
  orchestrator:
    engineering_focus: strict

  developer:
    engineering_focus: strict

  researcher:
    engineering_focus: balanced

  contrarian:
    engineering_focus: exploratory

  validator:
    engineering_focus: strict
```

---

## Multi-Agent Systems

Engineering Focus is particularly useful in multi-agent systems.

Instead of embedding large behavioral instructions into every agent prompt, agents can inherit a common behavioral contract:

```text
Engineering Focus Policy
          +
Agent Role
          +
Task
          +
Relevant Context
          =
Agent Execution
```

This enables specialized agents to behave consistently while still retaining their individual responsibilities.

---

## Cost-Aware Agent Execution

One of the project's research goals is determining whether disciplined agent behavior can reduce unnecessary compute.

Potential measurements include:

- input tokens;
- output tokens;
- context size;
- model calls;
- tool calls;
- duplicate tool calls;
- retries;
- cache reuse;
- execution time;
- model escalation;
- estimated monetary cost;
- task completion rate;
- validation success;
- human correction rate.

Engineering Focus does **not** assume that fewer tokens automatically mean better performance.

Efficiency must be measured alongside quality.

A cheaper agent that produces worse engineering results is not an improvement.

---

## Benchmarking

Engineering Focus is intended to support controlled comparisons between behavior modes.

For example:

```text
A = Engineering Focus STRICT
B = Engineering Focus BALANCED
C = Engineering Focus EXPLORATORY
D = Engineering Focus DISABLED
```

Comparable tasks can then be evaluated for:

```text
quality
correctness
completion rate
token usage
model calls
tool calls
retries
execution time
cost
novelty
```

The long-term objective is to identify which behavioral patterns work best for different engineering task classes rather than assuming one configuration is universally optimal.

---

## Project Structure

The planned repository structure is:

```text
engineering-focus/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── SECURITY.md
├── CONTRIBUTING.md
├── THIRD_PARTY_NOTICES.md
│
├── core/
│   ├── engineering-focus.md
│   ├── policy.yaml
│   ├── modes.yaml
│   ├── handoff-schema.json
│   └── telemetry-schema.json
│
├── integrations/
│   ├── openai/
│   ├── codex/
│   ├── github-copilot/
│   ├── microsoft-copilot/
│   └── claude/
│
├── agents/
│   ├── strict.md
│   ├── balanced.md
│   ├── exploratory.md
│   └── disabled.md
│
├── workstation/
│   ├── install.ps1
│   ├── install.sh
│   ├── uninstall.ps1
│   └── uninstall.sh
│
├── examples/
│   ├── coding-agent/
│   ├── sre-agent/
│   ├── research-agent/
│   └── multi-agent/
│
└── tests/
    ├── policy/
    ├── conformance/
    └── benchmarks/
```

This structure may evolve as integrations are implemented.

---

## Project Status

Engineering Focus is currently under active development.

The initial work is focused on:

1. defining the vendor-neutral behavior specification;
2. defining the four behavior modes;
3. creating structured handoff and telemetry schemas;
4. implementing provider integrations;
5. supporting developer workstation installation;
6. building conformance tests;
7. benchmarking focused and non-focused agent behavior.

Interfaces and schemas may change before the first stable release.

---

## Design Philosophy

Engineering Focus should remain:

- vendor-neutral;
- composable;
- measurable;
- auditable;
- configurable;
- easy to disable;
- useful for both individual and multi-agent workflows.

It should **not** become:

- another proprietary agent runtime;
- a replacement for model-specific safety controls;
- a mechanism for hiding agent reasoning failures;
- an excuse to use weaker models when stronger reasoning is required;
- a universal claim that every task benefits from strict focus.

The correct behavior depends on the task.

Engineering Focus exists to make that behavior explicit and measurable.

---

## Inspiration and Attribution

Engineering Focus was inspired in part by the open-source [`i-have-adhd`](https://github.com/ayghri/i-have-adhd) project.

The original project demonstrated useful behavioral patterns for keeping AI-assisted work focused and manageable.

Engineering Focus expands the concept into a vendor-neutral engineering-agent framework with additional concepts including:

- configurable execution modes;
- multi-agent behavior policies;
- context budgeting;
- structured handoffs;
- cost-aware model/tool escalation;
- deduplication;
- measurable stop conditions;
- conformance testing;
- runtime telemetry;
- controlled behavior benchmarking.

Any portions derived from MIT-licensed upstream material retain the applicable copyright and license notices.

See [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md) for attribution information.

---

## License

Engineering Focus is licensed under the **Apache License 2.0**.

See [`LICENSE`](LICENSE) for details.

Third-party material incorporated or adapted from other projects remains subject to its original license and attribution requirements.

---

## Contributing

Contributions are welcome as the project matures.

Useful areas include:

- agent behavior design;
- provider integrations;
- SRE and infrastructure workflows;
- coding-agent workflows;
- context management;
- model routing;
- telemetry;
- benchmarking;
- conformance testing;
- multi-agent orchestration.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) once contribution guidelines are available.

---

## Engineering Focus

**Focused when focus matters. Exploratory when exploration matters. Measured either way.**