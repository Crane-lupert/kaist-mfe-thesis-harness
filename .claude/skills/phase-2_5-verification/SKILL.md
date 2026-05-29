---
name: phase-2_5-verification
description: KAIST FE 졸업논문 재현 Phase 2.5 implementation verification gate. 원저 method / variable / test / robustness inventory 와 KR 구현 (code/) cross-check + silent substitute · silent drop · silent proxy 3종 위반 자동 검출. PASS 후 Phase 3 진입 허용 (binding gate). 학생이 "verification 확인", "구현 검증", "Phase 3 진입 전 점검" 같이 말할 때 또는 Phase 2 autopilot 완료 시 자동 invoke.
---

본 skill 은 AGENTS.md §1 Phase 2.5 (verification gate) + `docs/phase-2_5-verification.md` 상세 spec 실행 wrapper.

## 진입 절차

1. Phase 2 완료 확인 (`04_agent_tasks.md` 안 task 모두 done 또는 blocked + sign-off).
2. Verification matrix 4 종 작성 (`docs/phase-2_5-verification.md` §2):
   - Methodology coverage 표
   - Variable mapping 표
   - Test coverage 표
   - Robustness coverage 표
3. 자동 검출 rule 3 종 (`docs/phase-2_5-verification.md` §3):
   - **Silent substitute** — `manifest` 정의와 `code/` 구현 정의 불일치
   - **Silent drop** — `manifest` 항목인데 `code/` 매핑 없음
   - **Silent proxy** — `00_feasibility.md` PARTIAL 미명시 변수가 proxy 로 구현됨
4. 검출된 모든 위반 → `03_user_tasks.md` escalation + 학생 sign-off 또는 추가 구현 후 Phase 2 재진입.
5. PASS 조건 (모두 충족):
   - 4 matrix 모든 row 가 IMPLEMENTED 또는 (PARTIAL + sign-off 기록) 또는 (MISSING + 학생 명시 drop + 사유)
   - 3 종 violation = 0 건
6. PASS → `05_progress.log` 에 verification audit marker append → Phase 3 진입 허용.

## 의무 참조

- `docs/rigor-lock.md` — faithful translation lock long-form (AGENTS.md §8 보충)
