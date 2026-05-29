# Phase 3 — Mid-presentation prep prompt

> Phase 2.5 verification PASS 후. AGENTS.md + 00-05 thesis_state 파일 paste 됐다고 가정.

---

Phase 3 (Mid-presentation prep) 진행. AGENTS.md §7 + `docs/presentation-rubric.md` 따라:

## §1 — 1분 elevator pitch (10줄 이하)

학생이 그대로 외워서 사용 가능 수준. 다음 5 항목:
1. 원저 paper 의 1줄 요약 + 저널 + 연도
2. 왜 한국 시장 재현이 의미 있는가
3. 사용 데이터 + universe + sample period
4. 잠정 결과 (있으면) — 통계적 유의성 + 경제적 유의성
5. 현재 상태 + 다음 단계

## §2 — 5분 deck draft (8-10 슬라이드 markdown)

`docs/presentation-rubric.md` §4 의 권장 구조:

1. Title + motivation (1-2)
2. 원저 core (1-2)
3. KR 시장 특수성 (1)
4. 데이터 + 방법론 (1-2)
5. 잠정 결과 (1-2)
6. 한계 + 다음 단계 (1)

각 슬라이드는 다음 형식:

```
## Slide N — <제목>

[Bullet point 3-5 개. 각 < 15 단어.]

[Visual: 표 또는 figure 참조 — code/figures/fig_N.png 등]

[Speaker notes — 학생이 발표 시 말할 내용 풀이, 2-3 문장]
```

## §3 — Q&A 10-15개

`docs/presentation-rubric.md` §3 카테고리 (Methodology / Data / Results / KR 해석 / 한계 / 후속 연구) 별 균등 분포.

각 Q&A 형식:

```
### Q1 [Category]: <질문>
**모범 답안**: <2-3 문장, 근거 표 / figure 참조>
**보조 자료**: <필요 시 paper section ref 또는 본인 결과 표 ref>
```

질문은 `docs/presentation-rubric.md` §3 의 패턴 + 학생 본인 thesis 의 특수 사정 (PARTIAL / PROXY 사용 시 그 결정 사유 등).

## §4 — 학생 self-test

agent (= 본 conversation 의 AI) 가 §3 의 Q&A 중 5개 무작위 선택 → 학생에게 차례로 던지기.

학생 답변 받은 후 각각 평가:
- ⭐⭐ (낮음): 부정확 / 모호 / 발표 통과 어려움
- ⭐⭐⭐ (보통): 정확하지만 깊이 부족
- ⭐⭐⭐⭐ (좋음): 정확 + 메커니즘 설명 + 근거 참조
- ⭐⭐⭐⭐⭐ (탁월): 한계 인정 + 후속 방향

5개 평균 ≥ ⭐⭐⭐⭐ (= 8/10) 이면 Phase 3 PASS.

PASS 미달 시: 약한 답변의 카테고리 강화 + 학생에게 해당 paper section / 본인 결과 재학습 권고.

## 출력 형식

1. §1 elevator pitch (markdown)
2. §2 5분 deck (slide-by-slide)
3. §3 Q&A 10-15개
4. §4 5개 무작위 질문 → 학생 답변 대기

학생이 §4 답변 후 다음 turn 에 평가 + PASS / FAIL 판정.

## PASS 후

`thesis_state/06_presentation.md` 의 frontmatter `current_phase: P3-PASS` + 학생에게 발표 진행 가능 알림.
