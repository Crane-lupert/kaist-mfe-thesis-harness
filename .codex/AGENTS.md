# .codex/AGENTS.md — Codex CLI 전용 thin wrapper

> 본 파일은 **../AGENTS.md** (repo root) 를 import 하는 wrapper. 모든 logic 은 root AGENTS.md.
> Codex CLI 사용자만 적용되는 추가 설정.

@../AGENTS.md

## Codex CLI 특화

- 첫 세션 시작 시 `bash tool-routing/detect.sh` 또는 `pwsh tool-routing/detect.ps1` 실행 → `thesis_state/tool.json` 에 `tool="codex-cli"`, `capabilities=["overnight-autopilot","apply-patch","shell"]` 자동 감지.
- Overnight autopilot: `codex --auto` 모드 (단 본 repo 의 `.codex/config.toml` 안 sandbox / auto-approve allowlist 가 thesis 작업에 한정되어 위험 동작 차단).
- Codex CLI 의 `apply-patch` 사용 시 thesis_state/ + code/ + template/thesis.{tex,md} 만 modify 권장.
- python / pip / pytest / pandoc / latexmk / marker-pdf / docling 은 `.codex/config.toml` 의 auto-approve allowlist 에 포함.
