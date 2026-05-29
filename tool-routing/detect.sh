#!/usr/bin/env bash
# tool-routing/detect.sh — POSIX tool detection for KAIST FE thesis harness
# AGENTS.md §0 의 자동 실행 helper. thesis_state/tool.json 에 결과 기록.
# 사용법: bash tool-routing/detect.sh

set -e
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
state_dir="$repo_root/thesis_state"
out_file="$state_dir/tool.json"

mkdir -p "$state_dir"

if [ -f "$out_file" ]; then
    echo "tool.json already exists at $out_file"
    cat "$out_file"
    exit 0
fi

tool="unknown"
capabilities="[]"

if [ -n "${CLAUDECODE:-}" ] || [ -n "${CLAUDE_CODE_VERSION:-}" ] || [ -n "${CLAUDE_CODE_TOOL_PERMISSION_MODE:-}" ]; then
    tool="claude-code"
    capabilities='["overnight-autopilot","skills","todowrite","bash","edit"]'
elif [ -n "${CODEX_CLI_VERSION:-}" ] || [ -n "${OPENAI_CODEX_CLI:-}" ] || [ -n "${CODEX_API_KEY:-}" ]; then
    tool="codex-cli"
    capabilities='["overnight-autopilot","apply-patch","shell"]'
elif [ -n "${CURSOR_USER:-}" ] || [ -n "${CURSOR_SESSION_ID:-}" ] || [ -d "$repo_root/.cursor" ]; then
    tool="cursor"
    capabilities='["step-trigger","composer-agent","edit"]'
elif [ -n "${ANTIGRAVITY_SESSION:-}" ] || [ -n "${GOOGLE_ANTIGRAVITY:-}" ]; then
    tool="antigravity"
    capabilities='["step-trigger","mission-mode"]'
else
    tool="generic-shell-agent"
    capabilities='["step-trigger","shell"]'
fi

detected_at="$(date -Iseconds 2>/dev/null || date '+%Y-%m-%dT%H:%M:%S%z')"

cat > "$out_file" <<EOF
{
  "tool": "$tool",
  "capabilities": $capabilities,
  "detected_at": "$detected_at",
  "detected_by": "tool-routing/detect.sh",
  "note": "Edit this file manually if detection is wrong; agent will trust this value. For web paste (ChatGPT/Gemini), write {\"tool\":\"web-paste\",\"capabilities\":[\"manual-paste-only\"]}."
}
EOF

echo "Detected tool: $tool"
echo "Capabilities: $capabilities"
echo "Written to: $out_file"
