# tool-routing/detect.ps1 — Windows tool detection for KAIST FE thesis harness
# AGENTS.md §0 의 자동 실행 helper. thesis_state/tool.json 에 결과 기록.
# 사용법: pwsh tool-routing/detect.ps1

$ErrorActionPreference = "Continue"
$repoRoot = Split-Path -Parent $PSScriptRoot
$stateDir = Join-Path $repoRoot "thesis_state"
$outFile  = Join-Path $stateDir "tool.json"

if (-not (Test-Path $stateDir)) {
    New-Item -ItemType Directory -Path $stateDir -Force | Out-Null
}

if (Test-Path $outFile) {
    Write-Output "tool.json already exists at $outFile"
    Get-Content $outFile
    exit 0
}

$tool = "unknown"
$capabilities = @()

if ($env:CLAUDECODE -or $env:CLAUDE_CODE_VERSION -or $env:CLAUDE_CODE_TOOL_PERMISSION_MODE) {
    $tool = "claude-code"
    $capabilities = @("overnight-autopilot", "skills", "todowrite", "bash", "edit")
}
elseif ($env:CODEX_CLI_VERSION -or $env:OPENAI_CODEX_CLI -or $env:CODEX_API_KEY) {
    $tool = "codex-cli"
    $capabilities = @("overnight-autopilot", "apply-patch", "shell")
}
elseif ($env:CURSOR_USER -or $env:CURSOR_SESSION_ID -or (Test-Path (Join-Path $repoRoot ".cursor"))) {
    $tool = "cursor"
    $capabilities = @("step-trigger", "composer-agent", "edit")
}
elseif ($env:ANTIGRAVITY_SESSION -or $env:GOOGLE_ANTIGRAVITY) {
    $tool = "antigravity"
    $capabilities = @("step-trigger", "mission-mode")
}
else {
    $tool = "generic-shell-agent"
    $capabilities = @("step-trigger", "shell")
}

$detected = [PSCustomObject]@{
    tool         = $tool
    capabilities = $capabilities
    detected_at  = (Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz")
    detected_by  = "tool-routing/detect.ps1"
    note         = "Edit this file manually if detection is wrong; agent will trust this value. For web paste (ChatGPT/Gemini), write {`"tool`":`"web-paste`",`"capabilities`":[`"manual-paste-only`"]}."
}

$detected | ConvertTo-Json -Depth 5 | Out-File -FilePath $outFile -Encoding utf8

Write-Output "Detected tool: $tool"
Write-Output "Capabilities: $($capabilities -join ', ')"
Write-Output "Written to: $outFile"
