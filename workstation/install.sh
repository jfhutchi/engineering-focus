#!/usr/bin/env bash
set -euo pipefail

DESTINATION="${1:-$HOME/.engineering-focus}"
FORCE="${ENGINEERING_FOCUS_FORCE:-0}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

required=(
  "skills/engineering-focus/SKILL.md"
  "core/policy.yaml"
  "core/modes.yaml"
  "core/handoff-schema.json"
  "core/telemetry-schema.json"
)

for relative in "${required[@]}"; do
  if [[ ! -f "$REPO_ROOT/$relative" ]]; then
    echo "Required Engineering Focus file is missing: $REPO_ROOT/$relative" >&2
    exit 1
  fi
done

if [[ -e "$DESTINATION" ]]; then
  if [[ "$FORCE" != "1" ]]; then
    echo "Destination already exists: $DESTINATION" >&2
    echo "Set ENGINEERING_FOCUS_FORCE=1 to replace it." >&2
    exit 1
  fi
  rm -rf -- "$DESTINATION"
fi

mkdir -p -- "$DESTINATION"

for directory in skills core agents integrations; do
  if [[ -d "$REPO_ROOT/$directory" ]]; then
    cp -R -- "$REPO_ROOT/$directory" "$DESTINATION/"
  fi
done

for file in VERSION LICENSE THIRD_PARTY_NOTICES.md AGENTS.md CLAUDE.md; do
  if [[ -f "$REPO_ROOT/$file" ]]; then
    cp -- "$REPO_ROOT/$file" "$DESTINATION/"
  fi
done

echo "Engineering Focus installed to: $DESTINATION"
echo "Canonical skill: $DESTINATION/skills/engineering-focus/SKILL.md"
echo "This installer does not modify provider-specific configuration automatically."
echo "See $DESTINATION/integrations for provider guidance."
