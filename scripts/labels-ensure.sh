#!/usr/bin/env bash
set -euo pipefail
REPO=${1:?"Usage: $0 owner/repo"}
labels=(
  "ai-task:#1f883d:Task for AI agents"
  "human-review-needed:#fbca04:Needs human attention"
  "cross-component:#8250df:Spans multiple components"
  "status:ai-review:#0e8a16:AI review stage"
  "status:ai-test:#0e8a16:AI test stage"
  "status:ai-approved:#1f883d:AI approved stage"
)
for l in "${labels[@]}"; do
  name=${l%%:*}; rest=${l#*:}; color=${rest%%:*}; desc=${rest#*:}
  gh label create "$name" -R "$REPO" -c "$color" -d "$desc" 2>/dev/null || echo "Label exists: $name"
done
