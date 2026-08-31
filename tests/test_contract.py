from __future__ import annotations

import json
from pathlib import Path

import jsonschema
import yaml


ROOT = Path(__file__).resolve().parents[1]
EXPECTED_MODES = {"STRICT", "BALANCED", "EXPLORATORY", "DISABLED"}
EXPECTED_STOP_STATES = {
    "COMPLETE",
    "BLOCKED",
    "REJECTED",
    "BUDGET_EXHAUSTED",
    "DEFERRED",
}


def load_json(relative: str) -> dict:
    return json.loads((ROOT / relative).read_text(encoding="utf-8"))


def load_yaml(relative: str) -> dict:
    return yaml.safe_load((ROOT / relative).read_text(encoding="utf-8"))


def test_canonical_skill_exists_and_names_all_modes() -> None:
    skill = (ROOT / "skills/engineering-focus/SKILL.md").read_text(encoding="utf-8")
    assert "name: engineering-focus" in skill
    for mode in EXPECTED_MODES:
        assert mode in skill
    assert "host system's safety" in skill.lower()
    assert "deterministic" in skill.lower()
    assert "structured handoff" in skill.lower()


def test_modes_are_exactly_the_supported_modes() -> None:
    config = load_yaml("core/modes.yaml")
    assert set(config["modes"]) == EXPECTED_MODES


def test_policy_defaults_to_balanced_and_preserves_security() -> None:
    policy = load_yaml("core/policy.yaml")
    assert policy["default_mode"] == "BALANCED"
    assert set(policy["stop_states"]) == EXPECTED_STOP_STATES
    assert policy["principles"]["correctness_over_cost"] is True
    assert policy["security"]["may_expand_permissions"] is False
    assert policy["security"]["may_bypass_host_approval"] is False
    assert policy["security"]["exploratory_mode_expands_permissions"] is False


def test_example_handoff_validates_against_schema() -> None:
    schema = load_json("core/handoff-schema.json")
    instance = load_json("examples/handoff.json")
    jsonschema.Draft202012Validator.check_schema(schema)
    jsonschema.validate(instance=instance, schema=schema)


def test_example_telemetry_validates_against_schema() -> None:
    schema = load_json("core/telemetry-schema.json")
    instance = load_json("examples/telemetry.json")
    jsonschema.Draft202012Validator.check_schema(schema)
    jsonschema.validate(instance=instance, schema=schema)


def test_codex_manifest_points_to_existing_skill_directory() -> None:
    manifest = load_json(".codex-plugin/plugin.json")
    skills_dir = (ROOT / manifest["skills"]).resolve()
    assert skills_dir == (ROOT / "skills").resolve()
    assert (skills_dir / "engineering-focus/SKILL.md").is_file()


def test_third_party_notice_preserves_upstream_identity() -> None:
    notice = (ROOT / "THIRD_PARTY_NOTICES.md").read_text(encoding="utf-8")
    assert "Copyright (c) 2026 Ayoub Ghriss" in notice
    assert "MIT License" in notice
    assert "https://github.com/ayghri/i-have-adhd" in notice
