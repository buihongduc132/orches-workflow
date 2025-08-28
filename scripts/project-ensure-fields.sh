#!/usr/bin/env bash
set -euo pipefail
OWNER=${1:?"Usage: $0 <owner> <project_number>"}
NUMBER=${2:?"Usage: $0 <owner> <project_number>"}
# AI Agent text field
gh project field-create "$NUMBER" --owner "$OWNER" --name "AI Agent" --text 2>/dev/null || echo "Field exists: AI Agent"
