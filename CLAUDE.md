# CLAUDE.md — Claude Code 전용 thin wrapper

> 본 파일은 **AGENTS.md** 를 import 하는 wrapper. 모든 logic 은 AGENTS.md 가 single SoT.
> Claude Code 사용자만 적용되는 추가 설정.

@AGENTS.md

## Claude Code 특화

- 첫 세션 시작 시 `tool-routing/detect.ps1` (Windows) 또는 `tool-routing/detect.sh` (mac/linux) 가 `thesis_state/tool.json` 작성. 본 환경은 `tool="claude-code"`, `capabilities=["overnight-autopilot","skills","todowrite","bash","edit"]` 으로 감지될 것.
- `.claude/skills/` 안 7 skill (phase-0 ~ phase-5 + phase-2_5) 가 자동 invocation 가능. 학생이 "feasibility check 해줘" / "autopilot 시작" 같은 자연어로 phase trigger 가능.
- Overnight autopilot 은 `/loop` slash command 권장 (예: `/loop 10m` 으로 10분 마다 다음 task pickup, 또는 dynamic mode).
- 작업 추적은 TodoWrite 로 (AGENTS.md §5.1 의 autopilot loop 와 결합).
- Permission allowlist 는 `.claude/settings.json` 에 thesis 작업에 필요한 도구 (python / pip / pytest / pandoc / latexmk / marker-pdf / docling / WebFetch to fnguide·KRX·DART·ECOS) 사전 등록.
