---
name: phase-2-autopilot
description: KAIST FE 졸업논문 재현 Phase 2 (Execution) autopilot loop 시작. `04_agent_tasks.md` 의 task 1개씩 실행 + user-blocking 만나면 `03_user_tasks.md` 에 escalation + 다음 task 진행 (멈추지 않음). 학생이 "autopilot 시작", "overnight 진행", "Phase 2 실행" 같이 말할 때 invoke. Claude Code / Codex CLI overnight-autopilot capability 인 경우만.
---

본 skill 은 AGENTS.md §5.1 (Phase 2 — Execution autopilot loop) 실행 wrapper.

## 진입 절차

1. `thesis_state/tool.json.capabilities` 에 `overnight-autopilot` 포함 확인. 없으면 step-trigger mode 안내 후 종료.
2. Phase 1 완료 확인 (`01-04_*.md` 4 종 존재).
3. Autopilot loop (AGENTS.md §5.1):
   a. `04_agent_tasks.md` 에서 의존성 충족 task 1개 선택
   b. 진행 (코드 작성 / 테스트 / 회귀 / 검정 / robustness sweep / 차트)
   c. user-blocking 만나면 AGENTS.md §6 양식으로 `03_user_tasks.md` append + 다음 독립 task
   d. 완료 → `05_progress.log` append + task 상태 갱신
   e. 1번 반복
4. 중단 조건 (AGENTS.md §5.1):
   - 모든 task done 또는 blocked
   - 학생 명시 stop
   - faithful lock §8 위반 가능성 발견 → 즉시 stop + escalation
5. TodoWrite 로 task 진행 동시 트래킹 (학생이 임의 시점 진행상황 확인 가능).

## Phase 2.5 진입 trigger

agent task 모두 done 시 자동으로 `phase-2_5-verification` skill 호출 (binding gate, Phase 3 차단).
