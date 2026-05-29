# Phase 4 — Thesis section drafting prompt

> Phase 3 PASS 후. AGENTS.md + 00-06 thesis_state + paper/converted/structured/<section>.md (있으면) paste 됐다고 가정.

---

Phase 4 (Thesis writing) 진행. AGENTS.md §9 + `docs/phase-4-thesis-writing.md` 따라 본 turn 에 1개 section 작성.

## Step 1 — Section 선택

학생이 본 prompt 와 함께 작성할 section 명시:
- `abstract_kr` / `abstract_en` / `keywords`
- `01_introduction` / `02_literature` / `03_data` / `04_methodology` / `05_results` / `06_robustness` / `07_discussion` / `08_conclusion`
- `references.bib`

학생이 명시 안 했으면 다음 권장 순서 따라 진행:
03 data → 04 methodology → 05 results → 06 robustness → 02 literature → 07 discussion → 01 introduction → 08 conclusion → abstract → keywords

## Step 2 — 본문 언어 lock

학생이 본 prompt 직전에 한국어 / 영어 명시. 없으면 default 한국어.

## Step 3 — Section 작성

본 section 의 입력:
- `paper/converted/manifest.json` 의 해당 section 관련 inventory
- `paper/converted/structured/<section>.md` (있으면) 의 원저 내용
- `thesis_state/00_feasibility.md` 의 KR 가용성
- `thesis_state/01_methodology_map.md` 의 원저 ↔ KR 매핑
- `thesis_state/05_progress.log` 의 Phase 2 실측 결과 + Phase 2.5 verification matrix
- `code/` 의 실제 구현 (코드는 이미 paste 됐다고 가정 또는 학생이 본 turn 에 paste)
- `paper/student_notes.md` 의 학생 관심사

본 section 작성 시 의무:
- `docs/rigor-lock.md` §8 faithful translation — 원저 method 자기 임의 해석 금지
- 원저 인용 의무 (BibTeX `\cite{Name2020}` 양식)
- KR 시장 특수성 (`docs/kr-market-quirks.md`) 의무 반영 (해당 section 일 때)
- 표 / figure 는 `thesis_state/07_thesis_draft/figures/` 또는 `code/figures/` 의 산출 참조

## Step 4 — Section 별 작성 가이드

### `03_data.md`
- vendor 명시 (fnguide / CheckExpert / KRX / DART / ECOS)
- universe (KOSPI / +KOSDAQ / +KONEX) + 사유
- sample period + 사유 (KR regime 분리 의무 — `docs/kr-market-quirks.md` §9)
- data cleaning (우선주 / ETF / REIT / 매매정지 / 관리종목 처리)
- summary statistics 표 (mean / std / min / max / N)

### `04_methodology.md`
- 원저 method 표 + KR adaptation 표 (Phase 2.5 verification matrix 그대로 사용 가능)
- 통계 모델 spec (Fama-MacBeth / Newey-West HAC / Bonferroni m / sub-period split)
- KR-specific 차이 명시 (예: KOSPI ↔ NYSE universe size 차이로 인한 power 영향)

### `05_results.md`
- main result 표 (원저 비교 column 의무)
- figures (시각화)
- 통계적 유의성 + 경제적 유의성 분리

### `06_robustness.md`
- Phase 2 의 모든 robustness sweep 결과 + 원저와 차이 해석
- sub-period analysis (KR regime 의무)

### `07_discussion.md` (가장 중요)
- 원저 결과와 KR 결과 차이를 KR 시장 특수성 (`docs/kr-market-quirks.md`) 으로 해석
- 개인투자자 비중 / 재벌 / short-sale 제약 / 외환 등의 mechanism 설명
- 본 연구 contribution + 실무적 함의

### `02_literature.md`
- 원저 핵심 인용 (`paper/converted/structured/references.bib` 기반)
- **KR 선행 연구 필수 cover** (한국재무학회지 / 재무관리연구 / 한국증권학회지 / Asia-Pacific J of Financial Studies)
- KR 선행 연구 검색은 학생 본인이 KCI / RISS / Google Scholar 에서 진행 → 학생 task escalation 가능

### `08_conclusion.md`
- 본 연구 요약 (results)
- 한계 + 후속 연구 (의무, "한계는 없습니다" 금지 — `docs/presentation-rubric.md` §1.5)

### `01_introduction.md`
- 동기 (왜 KR 재현이 가치 있는가) + 본 연구 contribution + paper 구조

### Abstract / Keywords
- 본문 완료 후 마지막 작성. 본문 모든 chapter 의 1-2 문장 요약.

## 출력 형식

선택한 section 의 markdown 본문 출력. 학생이 copy → `thesis_state/07_thesis_draft/<section>.md` 저장.

Section 길이 권장:
- 01 / 08: 3-5 페이지 (10-15 단락)
- 02: 5-10 페이지
- 03: 5-8 페이지 (표 다수)
- 04: 5-10 페이지 (수식 + 표)
- 05: 8-15 페이지 (표 + figure 다수)
- 06: 5-10 페이지
- 07: 5-10 페이지 (해석 중심)
- abstract: 200-500 단어

## Faithful lock 점검

작성 중 원저와 다른 결정 필요 시 즉시 stop. 분기 (`docs/rigor-lock.md` §4):
- KR 에 정확히 부재 (MISSING) → Task M (지도교수 메일) escalation
- 다른 KR vendor 로 fix 가능 → Task U
- 자연스러운 KR replication 차원 → Phase 4 본문 명시 의무 (sign-off X)

자기 임의 결정 금지 — 원저 외 method 추가 절대 금지 (Lock B silent-add).
