---
name: phase-5-defense
description: KAIST FE 졸업논문 재현 Phase 5 (final defense) prep. 20-30분 deck + Q&A 30-50개 + thesis 본문 audit + 학생 self-test 9/10 (Phase 3 의 8/10 보다 strict). 학생이 "final defense 준비", "Phase 5 시작", "심사위원회 발표 준비" 같이 말할 때 invoke.
---

본 skill 은 AGENTS.md §10 (Phase 5 — Final defense prep) + `docs/phase-5-defense.md` 상세 spec 실행 wrapper.

## 진입 절차

1. Phase 4 완료 확인 — `template/thesis.pdf` (또는 markdown build) 존재 + `08_build.log` 최종 PASS.
2. `thesis_state/09_defense.md` 작성 (`docs/phase-5-defense.md` §2):
   - §1 20-30분 deck draft (Phase 3 의 5분 deck 확장)
   - §2 Committee-level Q&A 30-50개 + 모범 답안 (Methodology / Data / Results / Robustness / KR 해석 / 후속 연구)
   - §3 Robustness 시뮬레이션 — agent 가 §2 의 10개 무작위 → 학생 답 평가
   - §4 Thesis 본문 audit (cross-ref / BibTeX / 한·영 일관성 / typo / 한계 disclosure)
3. 학생 self-test 이해도 **9/10 미만** 시 §2 Q&A 보완 + 학생 재학습 권고 + final 처리 차단.
4. PASS (9/10 이상) 시 `09_defense.md` frontmatter `current_phase: P5-PASS` + 학생에게 final defense 진행 가능 알림.

## Phase 3 vs Phase 5 차이 lock

| 차원 | Phase 3 (mid) | Phase 5 (final) |
|---|---|---|
| 청중 | 지도교수 1인 ± | 심사위원회 3-5명 |
| Self-test | 8/10 | 9/10 |
| 시간 | 5분 | 20-30분 |
| Q&A 개수 | 10-15 | 30-50 |
| 답변 깊이 | 발표 통과 수준 | 방어 + 후속 방향 |

## 의무 참조

- `docs/presentation-rubric.md` — 발표 평가 기준 (Phase 3·5 공통)
- `docs/phase-5-defense.md` — committee-level Q&A 카테고리 6 종 + 모범 답안 패턴
