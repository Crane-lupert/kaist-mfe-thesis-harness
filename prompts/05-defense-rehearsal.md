# Phase 5 — Final defense prep prompt

> Phase 4 완료 (thesis 본문 build 됨) 후. AGENTS.md + 00-08 thesis_state + 본문 (또는 PDF text) paste 됐다고 가정.

---

Phase 5 (Final defense prep) 진행. AGENTS.md §10 + `docs/phase-5-defense.md` 따라 committee-level Q&A + thesis 본문 audit + self-test 9/10.

## §1 — 20-30분 deck draft

Phase 3 의 5분 deck (`thesis_state/06_presentation.md`) 을 확장. `docs/phase-5-defense.md` §2 권장 구조:

- 1-2: title + motivation (왜 KR 재현이 의미 있는가, 본 연구 contribution)
- 3-4: 원저 핵심 (1-2 문장 + 핵심 figure 1개)
- 5-6: KR 시장 특수성 (왜 단순 재현 이상으로 의미가 있나)
- 7-9: 데이터 (vendor, universe, sample period, cleaning, summary stats)
- 10-13: 방법론 (원저 method + KR adaptation 차이 표)
- 14-18: main results (원저 비교 표 + figures + 통계·경제 유의성)
- 19-22: robustness (각 robustness 의 의미 + 결과 + 원저와 차이)
- 23-25: discussion (원저 결과와 KR 결과 차이 해석, KR 특수성 mechanism)
- 26-27: 한계 + 후속 연구 방향
- 28-30: 결론 + Q&A 대기

각 슬라이드: bullet 3-5개 + visual ref + speaker notes 3-4 문장.

## §2 — Committee-level Q&A 30-50개

6 카테고리 균등 (`docs/phase-5-defense.md` §2.1-§2.6):

### §2.1 Methodology (6-8 질문)
원저 method N 의 KR 구현 detail. lag length / SE 종류 / Bonferroni m / sub-period split / fixed effect / rolling window 의 결정 사유 + KR-specific 차이.

### §2.2 Data (6-8 질문)
universe 결정 / 우선주·ETF 처리 / 상하한가 hit / 매매정지·관리종목 / IFRS sub-period / 외환위기·COVID structural break / 컨센서스 timing.

### §2.3 Results (6-8 질문)
원저 대비 effect size 차이 / 통계·경제 유의성 / OOS / 거래 비용 net / 표 / figure cross-ref.

### §2.4 Robustness (5-7 질문)
weighting scheme / sub-period sign / alternative variable def / alternative model spec / placebo / falsification.

### §2.5 KR 시장 해석 (6-8 질문, 가장 어려움)
개인투자자 비중 / 재벌 / short-sale 제약 / 외환 / 일반화 가능성 (대만 / 일본 / 중국).

### §2.6 후속 연구 (4-6 질문)
확장 가능성 / 실무 함의 / trading strategy / publication 가능 저널.

각 Q&A 형식:

```
### Q [Category]: <질문>
**모범 답안**: <2-3 문장 + 본 thesis section / 표 / figure ref>
**Forensic follow-up**: <심사위원 추가 질문 예상 + 답안>
```

## §3 — Robustness 시뮬레이션

agent (= 본 conversation AI) 가 §2 의 30-50 Q 중 10개 무작위 선택 → 학생에게 차례로 던지기.

학생 답변 받은 후 각각 평가 (`docs/presentation-rubric.md` §1.1-§1.5 의 5 차원, ⭐⭐⭐⭐⭐ 5점 만점).

10개 평균:
- ≥ ⭐⭐⭐⭐ (= 8/10): Phase 3 통과 수준. Phase 5 미통과.
- ≥ ⭐⭐⭐⭐⭐ partial (= 9/10): Phase 5 PASS.

PASS 미달 시: 약한 답변 카테고리 강화 + 학생에게 해당 본문 section 재학습 권고 + 다시 §3 진행.

## §4 — Thesis 본문 audit

Phase 4 산출 (`thesis_state/07_thesis_draft/` 또는 build 된 PDF) 의 다음 항목 audit:

- 모든 cross-reference (figure / table / equation) 정상
- BibTeX 모든 인용 매칭 (본문 \cite ↔ references.bib)
- 표 / figure 의 한·영 일관성
- 우선순위 typo / formatting / 문법
- abstract (한·영) 의 thesis 본문 일관성
- 결론의 thesis 본문 주장 일관성
- 한계 섹션의 hidden 약점 disclosure (심사위원이 forensic 으로 찾을 약점 미리 명시)

audit 결과 + 발견 issue list 출력.

## 출력 형식

1. §1 deck (slide-by-slide markdown)
2. §2 Q&A 30-50개 (카테고리 별 균등)
3. §3 무작위 10개 → 학생 답변 대기
4. §4 본문 audit 결과

학생이 §3 답변 후 다음 turn 에 평가 + PASS / FAIL 판정.

## PASS 후

`thesis_state/09_defense.md` frontmatter `current_phase: P5-PASS` + 학생에게 final defense 진행 가능 알림.

## §5 — Phase 5 학생 책임 task

다음 항목은 학생 본인 task (`03_user_tasks.md` 에 append):
- 심사위원 명단 확정 (학교 절차)
- 발표 일정 확정
- thesis 본문 학교 제출 형식 / 마감일 확인
- 발표 장소 / 기자재 확인
- thesis print binding (학교 요구 시)
