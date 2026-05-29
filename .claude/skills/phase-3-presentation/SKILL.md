---
name: phase-3-presentation
description: KAIST FE 졸업논문 재현 Phase 3 (중간 발표) prep. 5분 deck + Q&A 10-15개 + 학생 self-test 8/10. 학생이 "중간 발표 준비", "Phase 3 시작", "교수 앞 발표 자료" 같이 말할 때 invoke. Phase 2.5 verification gate PASS 후만 진입 가능.
---

본 skill 은 AGENTS.md §7 (Phase 3 — Mid-presentation prep) 실행 wrapper.

## 진입 절차

1. Phase 2.5 PASS 확인 (`05_progress.log` 마지막 verification audit entry `PASS` marker).
2. `thesis_state/06_presentation.md` 작성 (AGENTS.md §7):
   - §1 1분 elevator (10줄 이하)
   - §2 5분 deck draft (8-10 슬라이드)
   - §3 Q&A 10-15개 + 모범 답안 (`docs/presentation-rubric.md` 기반)
   - §4 학생 self-test: agent 가 §3 5개 무작위 던지고 학생 답변 평가
3. 학생 self-test 이해도 **8/10 미만** 이면 §3 Q&A 보완 + 학생에게 재학습 권고 + final 처리 차단.
4. PASS (8/10 이상) 시 06_presentation.md frontmatter `current_phase: P3-PASS` + 학생에게 발표 진행 가능 알림.

## Phase 4 진입 trigger

Phase 3 PASS 후 학생이 `phase-4-thesis-writing` skill 으로 진행 (또는 학생이 명시 trigger).
