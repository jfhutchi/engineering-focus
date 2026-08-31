#!/usr/bin/env bash
set -euo pipefail

DESTINATION="${1:-$HOME/.engineering-focus}"

if [[ ! -e "$DESTINATION" ]]; then
  echo "Engineering Focus is not installed at: $DESTINATION"
  exit 0
fi

rm -rf -- "$DESTINATION"
echo "Removed Engineering Focus from: $DESTINATION"
