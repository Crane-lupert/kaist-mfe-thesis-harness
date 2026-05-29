---
name: phase-0-feasibility
description: KAIST FE 졸업논문 재현 Phase 0 진입. paper PDF 를 MD 로 변환 (token 최적화) + section split + methodology·variable·test inventory (manifest.json) + 한국 시장 가용성 분석 보고서 (00_feasibility.md). 학생이 "paper feasibility check", "한국에서 재현 가능한지 확인", "원저 분석 시작" 같이 말할 때 invoke.
---

본 skill 은 AGENTS.md §3 (Phase 0 — Paper ingestion + Feasibility) 실행 wrapper.

## 진입 절차

1. `thesis_state/tool.json` 확인 (없으면 `pwsh tool-routing/detect.ps1` 또는 `bash tool-routing/detect.sh` 실행).
2. `paper/original.pdf` 존재 확인. 없으면 거부 + 학생에게 paper 투입 요청.
3. AGENTS.md §3 + `docs/phase-0-paper-ingestion.md` 상세 spec 따라 진행:
   - 0.1 PDF → MD (marker-pdf default, fallback chain)
   - 0.2 Section split
   - 0.3 manifest.json 생성 (methodology / variable / test / data_sources inventory)
   - 0.4 `thesis_state/00_feasibility.md` 작성 (KR 가용성 분석)
4. TodoWrite 로 진행상황 트래킹.
5. 완료 후 학생에게 §5 risk flag + Phase 1 진입 권고 1줄 보고.

## faithful translation lock 의무 참조

`docs/rigor-lock.md` (AGENTS.md §8) — substitute / drop / proxy 임의 결정 금지.
