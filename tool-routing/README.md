# tool-routing/ — AI 툴 자동 감지

이 디렉토리의 `detect.ps1` / `detect.sh` 는 현재 사용 중인 AI 코딩 툴을 env 변수 probe 로 감지해 `thesis_state/tool.json` 에 기록한다. AGENTS.md §0 의 첫 작업.

## 자동 실행

새 세션 시작 시 agent 가 자동 실행:

- Windows: `pwsh tool-routing/detect.ps1`
- mac/linux: `bash tool-routing/detect.sh`

이미 `thesis_state/tool.json` 이 있으면 그대로 신뢰하고 종료 (덮어쓰지 않음).

## 감지 결과 잘못된 경우

학생이 `thesis_state/tool.json` 을 직접 편집해서 교정 가능. agent 는 이 파일을 신뢰한다.

예시 — ChatGPT 웹 사용자 (shell 미사용) 의 경우:

```json
{
  "tool": "web-paste",
  "capabilities": ["manual-paste-only"],
  "detected_at": "2026-MM-DDTHH:mm:ss",
  "detected_by": "manual",
  "note": "ChatGPT web user — prompts/ 디렉토리 paste 로 진행"
}
```

## 감지 분기 (5 종)

| tool | capability tier | 사용 예 |
|---|---|---|
| `claude-code` | overnight-autopilot | `/loop` + skill 자동 invocation |
| `codex-cli` | overnight-autopilot | `codex --auto` |
| `cursor` | step-trigger | composer agent mode |
| `antigravity` | step-trigger | mission mode (신규, capability 미확정) |
| `generic-shell-agent` | step-trigger | aider 등 |
| `web-paste` | manual-paste-only | ChatGPT / Gemini 웹 |

`overnight-autopilot` 인 툴만 Phase 2 의 autopilot loop 가 실제 자율 진행. 나머지는 학생이 phase 별 trigger 필요.
