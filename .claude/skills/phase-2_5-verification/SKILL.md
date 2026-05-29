---
name: phase-2_5-verification
description: KAIST MFE 졸업논문 재현 Phase 2.5 implementation verification gate. 원저 method / variable / test / robustness inventory 와 KR 구현 (code/) cross-check + silent substitute · silent drop · silent proxy · silent add (Lock B) 4종 위반 자동 검출. PASS 후 Phase 3 진입 허용 (binding gate). 학생이 "verification 확인", "구현 검증", "Phase 3 진입 전 점검" 같이 말할 때 또는 Phase 2 autopilot 완료 시 자동 invoke.
---

본 skill 은 AGENTS.md §1 Phase 2.5 (verification gate) + `docs/phase-2_5-verification.md` 상세 spec 실행 wrapper.

## 진입 절차

1. Phase 2 완료 확인 (`04_agent_tasks.md` 안 task 모두 done 또는 blocked).
2. Verification matrix 4 종 작성 (`docs/phase-2_5-verification.md` §2):
   - Methodology coverage 표
   - Variable mapping 표
   - Test coverage 표
   - Robustness coverage 표
3. 자동 검출 rule 4 종 (`docs/phase-2_5-verification.md` §3):
   - **Silent substitute** (Lock A) — `manifest` 정의와 `code/` 구현 정의 불일치
   - **Silent drop** (Lock A) — `manifest` 항목인데 `code/` 매핑 없음
   - **Silent proxy** (Lock A) — `00_feasibility.md` PARTIAL 미명시 변수가 proxy 로 구현됨 (CheckExpert 가용 변수의 fnguide aggregate proxy 도 위반)
   - **Silent add** (Lock B 신설) — `code/replication/` 안 method 가 `manifest` inventory 에 없음 (agent 자의 추가)
4. 검출된 위반 분기:
   - Lock A drop/substitute/proxy → `03_user_tasks.md` U task 또는 Task M (MISSING 메일) escalation
   - Lock B silent-add → 해당 method 제거 (default) 또는 학생 명시 결정 + Phase 4 본문 명시
5. PASS 조건 (모두 충족):
   - 4 matrix 모든 row 가 IMPLEMENTED 또는 (PARTIAL §4.3 + Phase 4 본문 명시 기록) 또는 (PARTIAL §4.2 + 다른 vendor fix) 또는 (MISSING + Task M 메일 답 받음 + 학생 결정 기록)
   - 4 종 violation = 0 건
6. PASS → `05_progress.log` 에 verification audit marker append → Phase 3 진입 허용.

## 의무 참조

- `docs/rigor-lock.md` — faithful translation lock long-form (AGENTS.md §8 보충)
