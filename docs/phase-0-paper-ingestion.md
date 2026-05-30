# Phase 0 — Paper ingestion + Feasibility (상세 spec)

> AGENTS.md §3 의 확장. paper PDF 1 회 처리로 이후 phase 의 token 사용량 60-80% 절감.

## 1. 0.1 — PDF → Markdown 변환

### 1.1 Tool 우선순위

| 우선 | Tool | 강점 | 약점 | 설치 |
|---|---|---|---|---|
| 1 | **marker-pdf** | academic paper 최강 (수식 LaTeX 보존, 표 인식, 그림 추출) | GPU 권장 (CPU 도 동작), 큰 모델 download (~1 GB) | `pip install marker-pdf` |
| 2 | **docling** (IBM) | 학술 paper 강함, CPU 잘 동작 | 출력 형식 약간 다름 | `pip install docling` |
| 3 | **PyMuPDF** (fitz) | 빠르고 가벼움 | 수식·표 손실 큼 | `pip install pymupdf` |
| 4 | **pdftotext** (poppler) | 마지막 fallback | plain text only | `apt install poppler-utils` / `choco install poppler` |

agent 가 자동으로 1→4 순서 시도. 각 단계 fail (설치 안 됨 / 오류) 시 다음으로 fallback. 전부 fail 시 user task escalation.

### 1.2 변환 명령 (marker-pdf default, PDF auto-detect)

**PDF 파일명 강제 X**: agent 가 `paper/*.pdf` glob 으로 자동 감지. 1개 → 자동 사용. 2개 이상 → 학생에게 어느 것을 사용할지 묻기. rename 강제 금지.

```bash
# Pseudo-shell — 첫 PDF 자동 감지
PDF=$(ls paper/*.pdf | head -1)
marker_single "$PDF" paper/converted/ --output_format markdown
```

산출:
- `paper/converted/paper.md` — 전체 MD (수식 `$$...$$`, 그림 `![](figures/fig_N.png)`)
- `paper/converted/figures/fig_*.png` — 추출 그림
- `paper/converted/paper_meta.json` — marker-pdf 가 추출한 metadata + **`conversion_fidelity`** 필드:
  - `high` — marker-pdf / docling (수식 + 표 + 그림 보존)
  - `medium` — pdftotext + heuristics
  - **`low` — PyMuPDF fallback (수식·표 손실 가능)** → Phase 1 의 table-based 변수 (paper Table N 의 numeric value 등) PDF 원본 재확인 의무

### 1.3 한국어 paper 대응

KAIST FE 졸업논문이 KR replication 이긴 하지만 원저는 보통 영어 (JF/JFE 등). 영어 paper 변환에 marker-pdf / docling 모두 잘 동작.

원저가 한국어 paper 인 경우 (예: 한국재무학회지) → docling 이 marker-pdf 보다 한국어 PDF 처리가 안정적인 경우 있음. agent 가 paper 첫 5 페이지 sample 추출 후 한·영 비율 확인 → 한국어 dominant 시 docling 우선.

## 2. 0.2 — Section split

`paper/converted/paper.md` 를 다음 section 으로 분할:

```
paper/converted/structured/
├── abstract.md         # 보통 첫 페이지
├── introduction.md     # §1 또는 Introduction
├── data.md             # §2 또는 Data / Sample
├── methodology.md      # §3 또는 Methodology / Empirical strategy
├── results.md          # §4 또는 Results / Main findings
├── robustness.md       # §5 또는 Robustness / Additional tests
├── conclusion.md       # §6 또는 Conclusion
├── references.bib      # References → BibTeX (GROBID 추출 또는 LLM 추출)
└── appendix.md         # Appendix (선택)
```

Section 식별 rule:
1. Markdown h1/h2 heading 매칭 ("Introduction" / "I. Introduction" / "1. Introduction" / "서론" 등)
2. Heading 없으면 LLM 으로 추론 (`paper.md` 첫 5000 자 sample → section boundary 추정)
3. 모호 시 abstract.md 만 확정 + 나머지는 paper.md 단일 파일로 두고 manifest 에 표기

## 3. 0.3 — Methodology · variable · test inventory (manifest.json)

핵심: 이후 phase (Phase 1 / 2 / 2.5 / 4) 가 paper.md 전체를 다시 read 하지 않고 `manifest.json` 만 보고 필요한 section 만 cherry-pick. **token 절감의 본질**.

### 3.1 Schema

```json
{
  "paper_title": "...",
  "authors": ["Family Name, Given Name", "..."],
  "journal": "JF | JFE | RFS | JFQA | other",
  "year": 2020,
  "doi": "10.xxxx/yyyyy",
  "sections": [
    {"id": "abstract", "path": "structured/abstract.md", "page_range": [1, 1]},
    {"id": "introduction", "path": "structured/introduction.md", "page_range": [1, 4]},
    {"id": "data", "path": "structured/data.md", "page_range": [5, 8]},
    {"id": "methodology", "path": "structured/methodology.md", "page_range": [9, 14]},
    {"id": "results", "path": "structured/results.md", "page_range": [15, 22]},
    {"id": "robustness", "path": "structured/robustness.md", "page_range": [23, 28]},
    {"id": "conclusion", "path": "structured/conclusion.md", "page_range": [29, 30]}
  ],
  "methodology_inventory": [
    {
      "name": "Fama-MacBeth two-step regression",
      "section_ref": "methodology",
      "page": 12,
      "key_params": {"frequency": "monthly", "window": "rolling 60-month"},
      "kr_replicability_hint": "AVAILABLE — fnguide F730*/6000* + KR risk factor 가능"
    },
    {
      "name": "Newey-West HAC SE (12 lags)",
      "section_ref": "methodology",
      "page": 13,
      "key_params": {"lags": 12},
      "kr_replicability_hint": "AVAILABLE — statsmodels.regression.linear_model"
    }
  ],
  "variable_inventory": [
    {
      "name": "BE/ME",
      "definition": "book-to-market ratio, equity book value / market cap",
      "source_paper": "Fama-French 1992",
      "section_ref": "data",
      "page": 7,
      "fnguide_candidate": "S420006202 PBR(IFRS-연결) 의 역수 + 6000903003 지배주주지분"
    }
  ],
  "test_inventory": [
    {
      "name": "Bonferroni correction (m=25)",
      "section_ref": "results",
      "page": 18,
      "purpose": "multiple-testing adjustment over 25 sub-portfolios"
    },
    {
      "name": "Out-of-sample 2010-2015 forward",
      "section_ref": "robustness",
      "page": 22,
      "purpose": "OOS validation outside in-sample 1980-2009"
    }
  ],
  "data_sources_inventory": [
    {
      "name": "CRSP monthly returns",
      "section_ref": "data",
      "page": 5,
      "kr_equivalent": "fnguide S410007700 수정주가(현금배당반영) 일간 → 월간 변환"
    },
    {
      "name": "Compustat fundamentals",
      "section_ref": "data",
      "page": 5,
      "kr_equivalent": "fnguide 6000* 재무제표 시리즈 (분기·연간)"
    }
  ]
}
```

### 3.2 Inventory 생성 절차 + **Lock B (silent-add 차단)**

agent 가 `paper/converted/structured/methodology.md` + `data.md` + `results.md` + `robustness.md` 를 차례로 LLM 으로 parse 후 inventory entry 채움. 각 entry 의 `kr_replicability_hint` 는 Phase 0.4 feasibility 의 입력.

**Lock B 의무** (`docs/rigor-lock.md` §1, §2.2):
- `methodology_inventory` / `test_inventory` / `robustness_inventory` 안 entry 는 **원저 text 안 명시된 것만** 포함.
- agent 가 "관례상" / "이 종류 paper 는 보통 ... 도 한다" / "standard 니까" 같은 사유로 자의 추가 절대 금지.
- 예: 원저가 Newey-West HAC SE 만 명시했고 Bonferroni 언급 없으면 inventory 에 Bonferroni 추가 금지. 원저 sub-period split 언급 없으면 sub-period entry 추가 금지.
- 의심 시 entry 추가하지 말고, 학생에게 `paper.md` 의 해당 section 인용해서 "이 방법 명시됐는지 확인 부탁" 묻기.

Inventory 의 `kr_replicability_hint` 작성 시 (CheckExpert KAIST 라이선스 confirmed):
- fnguide 만으로 가능 → `AVAILABLE — fnguide <item code>`
- fnguide 부분 + CheckExpert brokerage-level 필요 → `AVAILABLE — fnguide aggregate + CheckExpert brokerage-level (KAIST 라이선스)`
- KR 부재 → `MISSING — <증거>. Lock A 위반 회피 위해 Task M (지도교수 메일) escalation 의무`
- KR 자연스러운 차이 (sub-period regime / 우선주 처리 등) → `PARTIAL (자연스러운 KR replication, Phase 4 본문 transparent 명시 의무)`

### 3.3 한 번 만들면 이후 재사용

이후 phase 에서 agent 는 다음 패턴:
- "원저 methodology N 번째가 뭐였더라?" → `manifest.methodology_inventory[N]` 만 load (paper.md 전체 X)
- "BE/ME 정의 다시 확인" → `manifest.variable_inventory` filter (paper 전체 X)
- "robustness §5.3 만 자세히" → `sections[robustness]` path 의 robustness.md 만 load

## 3.5 — Data probe (의무, session log 2026-05-30 evidence)

**핵심**: 학생이 본인 보유 데이터 디렉토리를 명시한 경우 (예: `D:\my_kaist_data`, `E:\fnguide_backup`), agent 는 모든 raw 데이터 파일을 자동 parsing — **파일명만 보고 카테고리 추정 절대 금지**.

### 3.5.1 Multi-path discovery

Phase 0 entry 직후 agent 가 학생에게 1줄 질문: "추가 데이터 보유 경로 있나요? (예: `D:\my_data`, `E:\backup`) — 없으면 `data/raw/` 만 사용":

학생 응답 받은 후 각 경로 의 모든 file (xlsx / csv / parquet / json) recursive list → `thesis_state/_data_paths.json`.

### 3.5.2 Shallow parsing 의무

각 file 마다:
- Header (첫 row 또는 첫 5 rows — vendor 별 metadata layout)
- 상위 5 data rows (sample values)
- dtype (per column)
- non-NaN coverage (%)
- date 범위 (date column 존재 시)
- 파일 size

→ `thesis_state/_data_probe.json` (per file structure):
```json
{
  "path": "D:/my_data/추가논문2/200_EPS.xlsx",
  "size_mb": 1.4,
  "encoding": "cp949",
  "header_layout": "FnGuide DataGuide standard (row 0-7 metadata)",
  "columns": ["A005930", "A000660", ...],
  "sample_rows": [...],
  "dtype_summary": {...},
  "non_nan_coverage": 0.94,
  "date_range": ["1989-01-01", "2024-06-30"],
  "guessed_content": "KOSPI 200 EPS time-series, individual stock columns"
}
```

### 3.5.3 Phase 1 입력으로 사용

`_data_probe.json` 이 Phase 1 의 `02_data_inventory.md` 매핑 표 작성의 1차 입력. 파일명 기반 추정이 아니라 실제 column / sample row 기반 매핑 의무.

## 4. 0.4 — Feasibility 분석 (`thesis_state/00_feasibility.md`)

`manifest.json` 의 inventory 4종 (methodology + variable + test + data_sources) 을 입력으로 다음 보고서 작성. AGENTS.md §3 의 부모 audit P0 요건 유지 + inventory 기반으로 강화.

```
last_updated: YYYY-MM-DD
current_phase: P0
next_action: Phase 1 entry approval | Phase 0 재실행 (변환 품질 문제 시)
---

# Phase 0 Feasibility — <paper title 요약>

## §1 원저 한 줄 요약
<발표 자료로 그대로 쓸 수 있는 수준. 1-2 문장.>

## §2 원저 핵심 inventory (manifest.json 기반)
### Methodology
| # | Method | 원저 page | KR 가용성 |
|---|---|---|---|
| 1 | Fama-MacBeth two-step | 12 | AVAILABLE |
| 2 | Newey-West HAC (12 lags) | 13 | AVAILABLE |
| ... |

### Variables
| Variable | Original definition | KR 데이터 후보 (fnguide item code) | 가용성 |
|---|---|---|---|

### Tests / Robustness
| Test | Purpose | KR 적용 가능성 |
|---|---|---|

### Data sources
| Original | KR equivalent (vendor + item) | 가용성 |
|---|---|---|

## §3 한국 시장 가용성 분석 (3-class: AVAILABLE / PARTIAL / MISSING)
- **AVAILABLE** (X 개): ...
- **PARTIAL** (Y 개): 어느 변수가 partial 인지 + 어떻게 proxy 가능한지 + faithful lock §8 충돌 여부
- **MISSING** (Z 개): 어느 변수가 KR 에 부재인지 + 증거 (vendor 문서 / 한국 학술 문헌 / fnguide 매뉴얼 search result)

## §4 한국 시장 특수성 한계
- 우선주 (-P) / 보통주 분리 처리 필요
- 상하한가 (±30%) 효과
- KOSPI / KOSDAQ universe 분리
- 회계기준 IFRS 도입 timing (2011-2013)
- 5% 지분 공시 등

## §5 Phase 1 진입 권고
- **Risk flag**: 낮음 / 중간 / 높음
- **사유**: 1 줄
- **권장 다음 액션**: Phase 1 진입 OR 학생 + 지도교수 사전 컨펌
```

## 5. User task escalation 예시 (이 phase 에서 자주 발생)

```
## Task U-1: marker-pdf 또는 docling 설치
- **왜 필요한가**: Phase 0.1 PDF → MD 변환. agent 가 marker-pdf 시도 → 미설치, docling 시도 → 미설치, PyMuPDF 시도 → 설치되어 있지만 수식·표 손실 큼.
- **무엇을 해야 하나**:
  1. `pip install marker-pdf` (GPU 있으면 권장)
  2. 또는 `pip install docling`
  3. 설치 확인: `marker_single --version` 또는 `docling --version`
- **완료 검증**: 위 명령 정상 출력.
- **막혔을 때 대안**: PyMuPDF 결과로 진행 (수식·표 손실 명시 후 §3.2 manifest 의 inventory 정확도 ↓ 감수)
- **상태**: blocked
```
