# OpenAI Integration

Canonical skill: `../../skills/engineering-focus/SKILL.md`

Initial OpenAI-facing metadata is stored at `../../skills/engineering-focus/agents/openai.yaml`.

The integration should expose Engineering Focus as an instruction/skill layer with `BALANCED` as the default mode while allowing explicit `STRICT`, `EXPLORATORY`, and `DISABLED` selection.

Do not duplicate the complete behavior contract here. Provider-specific packaging should reference or install the canonical skill so policy updates have one source of truth.

## Validation still required

Before declaring a specific OpenAI runtime fully supported, verify:

1. the runtime discovers/loads the skill;
2. explicit mode selection reaches the agent;
3. host/system rules still outrank the skill;
4. structured outputs are preserved when requested;
5. disabling the skill provides a usable control baseline.
