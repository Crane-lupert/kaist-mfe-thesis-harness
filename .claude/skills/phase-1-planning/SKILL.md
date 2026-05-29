---
name: phase-1-planning
description: KAIST FE 졸업논문 재현 Phase 1 진입. 원저 변수 ↔ KR 데이터 mapping + agent task vs user task split. 학생이 "Phase 1 시작", "replication 계획 세워줘", "데이터 inventory 만들어" 같이 말할 때 invoke.
---

본 skill 은 AGENTS.md §4 (Phase 1 — Replication planning) 실행 wrapper.

## 진입 절차

1. Phase 0 완료 확인 — `thesis_state/00_feasibility.md` 존재 + frontmatter `current_phase: P0` 또는 `next_action: Phase 1 entry`.
2. `paper/converted/manifest.json` 의 inventory 4종 + `00_feasibility.md` 의 §3 가용성 표를 입력으로:
   - `01_methodology_map.md` 작성 (원저 method · variable ↔ KR 매핑)
   - `02_data_inventory.md` 작성 (필요 raw 데이터 list + 학생 라이선스 접근 가능 여부)
   - `03_user_tasks.md` 작성 (학생 직접 작업 list, AGENTS.md §6 escalation 양식)
   - `04_agent_tasks.md` 작성 (agent autopilot task list, 의존성 표시)
3. Task split rule (AGENTS.md §4): 애매하면 user task (fail-secure).
4. 완료 후 학생에게 user task N 개 / agent task M 개 + Phase 2 진입 권고 보고.

## 의무 참조

- `docs/fnguide-dictionary.md` — fnguide item code 매핑
- `docs/kr-market-quirks.md` — KR 시장 특수성
- `docs/checkexpert-howto.md` — CheckExpert 접근 절차
