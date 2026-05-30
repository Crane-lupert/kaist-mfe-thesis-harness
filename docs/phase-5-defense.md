# Phase 5 — Final defense prep (**모의면접 모드 / mock interview mode**, 상세 spec)

> AGENTS.md §10 의 확장. Phase 3 mid-presentation 보다 deeper. committee-level Q&A.
> Self-test gate **9/10** (Phase 3 의 8/10 보다 strict).
>
> **Strict entry gate**: Phase 2.5 PASS (deferred 0건, `docs/phase-2_5-verification.md` §4) + Phase 4 thesis writing 완료 + Phase 4 본문 안 KR-specific contribution subsection (`docs/phase-4-thesis-writing.md` §07 Discussion 안 §7.X) 명시. 위 3 항목 모두 충족 전 진입 차단.

## 0. 모의면접 모드 (mock interview mode)

본 phase 의 핵심 = **agent 가 심사위원 페르소나로 forensic Q&A**. 단순 Q&A list 제공이 아니라 **interactive interview**:

- **페르소나 1 — 지도교수**: 본 연구 design 결정의 학술적 사유 (sub-period split / universe / risk-free 선택 등). OVERRIDE block (`docs/rigor-lock.md` §5.5) 안 각 결정에 대한 forensic 질문.
- **페르소나 2 — 외부 심사위원 (methodology expert)**: methodology 정확성 (Lock A/B/C 위반 가능성), MODWT / PCA / similarity 등 recursive recomputation 검증 (Lock C), OOS evaluation framework, statistical test 의 적절성.
- **페르소나 3 — 외부 심사위원 (domain expert)**: KR 시장 mechanism 해석 (개인투자자 / 재벌 / short-sale ban / 외환), KR-specific contribution 의 후속 연구 방향.

학생이 페르소나 별 forensic 질문에 차례로 답변. agent 가 각 답변 평가 (5 차원 × ⭐⭐⭐⭐⭐ rubric, `docs/presentation-rubric.md` §1). 평균 9/10 통과 전 final 처리 차단.

## 1. Phase 3 vs Phase 5 차이

| 차원 | Phase 3 (mid) | Phase 5 (final defense) |
|---|---|---|
| 시점 | 학기 중간 발표 (보통 첫 학기 말 또는 두 번째 학기 중반) | 졸업 직전 final defense |
| 청중 | 지도교수 1인 또는 + 동료 | 심사위원회 3-5명 (지도교수 + 2-4명) |
| 산출 형태 | 5분 deck + Q&A 10-15개 | 20-30분 deck + Q&A 30-50개 + thesis 본문 |
| 청중의 deep 정도 | medium (지도교수 본인 결정) | high (외부 심사위원 forensic challenge) |
| 학생 이해도 threshold | 8/10 | 9/10 |
| 모범 답안 정확도 | "발표 통과 가능 수준" | "방어 가능 + 후속 연구 방향 제시" 수준 |
| Drill 회수 | 1-2회 | 3-5회 + thesis 본문 audit |

## 2. 산출: `thesis_state/09_defense.md`

```
last_updated: YYYY-MM-DD
current_phase: P5
next_action: 학생 self-test 9/10 → final defense | rehearsal 추가
---

# Final Defense Prep — <thesis title>

## §1 20-30분 deck draft
20-30 슬라이드, Phase 3 의 5분 deck 의 확장.

권장 구조:
- 1-2: title + motivation (논문의 의미, 왜 KR 시장 재현이 의미 있는지)
- 3-4: 원저 핵심 (1-2 문장 + 핵심 figure 1개)
- 5-6: KR 시장 특수성 (왜 단순 재현 이상으로 의미가 있나)
- 7-9: 데이터 (vendor, universe, sample period, cleaning)
- 10-13: 방법론 (원저 method + KR adaptation 차이 표)
- 14-18: main results (원저 비교 표 + figures)
- 19-22: robustness (각 robustness 의 의미 + 결과)
- 23-25: discussion (원저 결과와 KR 결과 차이 해석, KR 특수성으로 설명)
- 26-27: 한계 + 후속 연구 방향
- 28-30: 결론 + Q&A 대기

## §2 Committee-level Q&A (30-50개)

### §2.1 Methodology 질문
원저 method N 의 KR 구현 detail. Phase 2.5 verification matrix 입력.
- Q: 원저는 X 했는데 왜 Y 로 했나?
- Q: 원저 Newey-West 12 lags 가 KR 에 적절한 lag 인가?
- Q: Fama-MacBeth 의 KR 적용 시 sample size 문제는 없나?

### §2.2 Data 질문
KR 시장 특수성에 대한 forensic 질문.
- Q: 우선주 / 보통주 분리 처리는?
- Q: 상하한가 hit 한 종목 처리는?
- Q: 거래정지 / 관리종목 처리는?
- Q: IFRS 도입 전후 (2011-2013) 데이터 일관성은?
- Q: 외환위기 / 글로벌금융위기 / COVID-19 sub-period 별 결과는?

### §2.3 Results 질문
- Q: 원저보다 effect size 가 작은 / 큰 이유는?
- Q: 통계적 유의성과 경제적 유의성의 관계는?
- Q: out-of-sample 결과 해석은?

### §2.4 Robustness 질문
- Q: 다른 weighting scheme (equal / value) 결과 다른가?
- Q: sub-period split 결과 일관적인가?
- Q: alternative variable definition 결과는?

### §2.5 KR 시장 해석 질문 (가장 어려운 종류)
- Q: KR 시장의 개인투자자 비중이 결과에 어떤 영향?
- Q: 재벌 구조가 결과에 영향?
- Q: KR 시장의 short-sale 제약이 결과에 영향?
- Q: 본 결과가 다른 EM (대만 / 일본 / 중국) 에 일반화 가능한가?

### §2.6 후속 연구 방향 질문
- Q: 본 연구를 어떻게 확장할 수 있나?
- Q: 본 결과의 실무적 함의는?
- Q: 본 결과를 trading strategy 로 가져갈 수 있나?

각 질문에 모범 답안 작성 — 2-3 문장 + 본문 / 표 / figure 참조.

## §3 Robustness 시뮬레이션

agent 가 §2 의 30-50 질문 중 무작위 10개 던지고 학생 답변을 평가. 다음 평가 기준:
- 정확성 (원저 + 본 연구 사실과 일치하는가)
- 깊이 (단순 답변이 아니라 메커니즘 설명)
- 한계 인정 (모르는 것은 모른다고 인정하는가)
- 후속 연구 방향 (해당 시)

8/10 이상 통과 시 1차 PASS. 9/10 이상 통과 시 final PASS — Phase 5 산출을 final 처리.

## §4 Thesis 본문 audit

Final defense 전에 thesis 본문 (`thesis_state/07_thesis_draft/` 또는 build 된 PDF) 의 다음 항목 audit:

- 모든 cross-reference (figure / table / equation) 정상
- BibTeX 모든 인용 매칭
- 표 / figure 의 한글 / 영문 일관성
- 우선순위 typo / formatting / 문법
- abstract (한·영) 의 thesis 본문 일관성
- 결론의 thesis 본문 주장 일관성
- 한계 섹션의 hidden 약점 disclosure (심사위원이 forensic 으로 찾을 약점 미리 명시)

## §5 학생 self-test 9/10 통과 후

`09_defense.md` final 처리. PDF 결과 (`template/thesis.pdf`) + deck (`thesis_state/06_presentation.md` 의 확장본 또는 별도) 정리. 학생에게 final defense 진행 가능 알림.
```

## 3. Self-test 9/10 의 의미

8/10 (Phase 3) = "지도교수 앞 발표 통과 가능 수준". 학생이 일부 detail 을 모를 수도 있지만 main argument 는 자기 입으로 설명 가능.

9/10 (Phase 5) = "심사위원회 (외부 심사 포함) defense 통과 가능 수준". 학생이 다음을 추가로 해야:
- 모든 main results 의 underlying mechanism 을 자기 입으로 설명
- 원저와의 차이를 KR 시장 특수성으로 정량·정성적 해석
- 후속 연구 방향에 대한 자기 의견 보유
- "모르는 것" 을 forensic 질문 받았을 때 정직하게 인정 + 후속 연구로 회피

agent 가 강제할 수 없는 부분 (학생 본인의 자기 검증) 이므로 self-test 가 중요. 통과 못 하면 final 처리 차단.

## 4. Phase 5 user task

- 심사위원 명단 확정 (학생 → 학교 절차)
- 발표 일정 확정
- thesis 본문 학교 제출 형식 / 마감일 확인
- 발표 장소 / 기자재 확인
- (학교 요구 시) thesis 본문 print binding
