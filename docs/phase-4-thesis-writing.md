# Phase 4 — Thesis writing (deferred-fill, 상세 spec)

> AGENTS.md §9 의 확장. 학과 양식 받기 전 / 후 자동 분기. 본문 한국어 / 영어 선택.

## 1. Section drafting (template 무관, Phase 4 의 본질)

`thesis_state/07_thesis_draft/` 에 다음 markdown 파일 작성:

```
07_thesis_draft/
├── abstract_kr.md           # 국문 초록
├── abstract_en.md           # 영문 초록
├── keywords.md              # 키워드 (kr + en)
├── 01_introduction.md
├── 02_literature.md         # 원저 + KR 시장 선행 연구
├── 03_data.md               # fnguide + CheckExpert + KRX + DART
├── 04_methodology.md        # 원저 method KR adaptation
├── 05_results.md            # main findings (표 + 그림 ref)
├── 06_robustness.md         # robustness checks
├── 07_discussion.md         # 원저 결과 와 비교, KR 특수성 해석
├── 08_conclusion.md
├── references.bib           # BibTeX (원저 refs + KR 선행 연구)
└── figures/
    ├── fig_01_*.png
    ├── tab_01_*.csv          # 표는 csv 로 두고 build 시 변환
    └── ...
```

각 section 작성 시 입력:
- `paper/converted/manifest.json` (원저 inventory)
- `paper/converted/structured/<section>.md` (원저 section)
- `thesis_state/00_feasibility.md` (KR 가용성 분석)
- `thesis_state/01_methodology_map.md` (원저 ↔ KR 매핑)
- `thesis_state/05_progress.log` (Phase 2 실험 결과 + Phase 2.5 verification matrix)
- `code/` 안 실제 구현
- `paper/student_notes.md` (학생 관심사)

각 section 의 KR 특수성 lock:
- §02 lit review: 원저 인용 + **KR 선행 연구 필수 cover** (한국재무학회지 / 재무관리연구 / 한국증권학회지 / Asia-Pacific J of Financial Studies 등)
- §03 data: fnguide / CheckExpert / KRX / DART + universe 명시 + 표본 기간 + 우선주 처리 + IFRS timing
- §04 methodology: 원저 method 표 + KR adaptation 표 (Phase 2.5 verification matrix 그대로 사용 가능)
- §05 results: Phase 2 실측 + 원저와 비교 표
- §06 robustness: Phase 2 의 robustness sweep 결과 + 원저와 차이 해석
- §07 discussion: KR 시장 특수성 (개인투자자 비중·상하한가·우선주·재벌 구조 등) 해석. 발표 핵심.

## 2. 4-deferred mode (default, `template/thesis.{tex,md}` 부재)

agent 가 template 부재 감지 시 자동으로 4-deferred 진입:

- §1 의 section draft 만 누적
- `template/_placeholder.tex` 또는 `_placeholder.md` 로 dry-run build 가능 (학생이 결과물 미리 보기) — Phase 4.6
- 학생이 양식 받으면 `template/thesis.tex` 또는 `template/thesis.md` 로 drop in → 다음 turn 에서 자동 4-final 진입

## 3. 4-final mode (`template/thesis.tex` 또는 `template/thesis.md` 감지)

### 3.1 Template detection 우선순위 (lock)

1. `template/thesis.tex` (LaTeX 최우선)
2. `template/thesis.md` (Markdown)
3. `template/_placeholder.tex` (CC0 generic skeleton, dry-run only)
4. `template/_placeholder.md` (동상)

위 4 후보 모두 부재 시 user task escalation: "학과 양식 받아서 `template/thesis.{tex,md}` 로 drop in 또는 `_placeholder.{tex,md}` 사용 결정 필요".

### 3.2 Structure parse — 2 단계 fallback

Step A — **Anchor convention** (우선):
- LaTeX: `% AGENT_FILL: <section_id>`
- Markdown: `<!-- AGENT_FILL: <section_id> -->`

지원 section_id (`07_thesis_draft/` 와 1:1 매칭):
- `title_page` (학생 정보 — 이름·학번·지도교수, 학생이 양식 안 또는 별도 작성)
- `abstract_kr`, `abstract_en`, `keywords`
- `chapter_1_introduction`, `chapter_2_literature`, `chapter_3_data`, `chapter_4_methodology`, `chapter_5_results`, `chapter_6_robustness`, `chapter_7_discussion`, `chapter_8_conclusion`
- `bibliography` (BibTeX include 위치)
- `appendix` (선택)

Step B — **Heading match fallback** (anchor 없을 때):
- 양식 안 h1/h2 heading parsing
- 한·영 keyword set 으로 매칭:
  - "서론" / "Introduction" → `01_introduction.md`
  - "선행 연구" / "이론적 배경" / "Literature" / "Literature Review" → `02_literature.md`
  - "자료" / "데이터" / "표본" / "Data" / "Sample" → `03_data.md`
  - "방법론" / "연구 방법" / "실증 방법" / "Methodology" / "Empirical Strategy" / "Methods" → `04_methodology.md`
  - "분석 결과" / "실증 결과" / "Results" / "Empirical Results" / "Main Findings" → `05_results.md`
  - "강건성" / "추가 분석" / "Robustness" / "Additional Tests" → `06_robustness.md`
  - "논의" / "토의" / "해석" / "Discussion" → `07_discussion.md`
  - "결론" / "Conclusion" → `08_conclusion.md`

heading 매칭 모호 시 (예: "결과 및 논의" 가 results 인지 discussion 인지) → user task escalation 으로 학생 명시 확인.

### 3.3 Fill 동작

- 각 anchor / heading 매칭 자리에 `07_thesis_draft/<section>.md` 의 본문 insert
- 학생이 양식 안 직접 작성한 부분 (title_page, 학생 본인 인사말, 감사의 글 등) 은 절대 덮어쓰기 금지 — anchor / heading 매칭된 위치만 fill
- bibliography 위치 (`\bibliography{...}` 또는 `<!-- bibliography -->`) → `07_thesis_draft/references.bib` 경로로 자동 link
- figure / table cross-ref 자동 정리 (`figures/fig_01_*.png` → `\ref{fig:01}` 또는 `[Figure 1](figures/fig_01.png)`)

### 3.4 Mode switch 안전성

- 4-deferred → 4-final 전환 시 `07_thesis_draft/*.md` 산출 그대로 재사용 (재작성 X)
- 4-final → 4-deferred 역전환 (학생이 양식 잘못 drop in 후 되돌리기) 도 지원 — `template/thesis.{tex,md}` 삭제 시 자동 4-deferred 복귀
- mode 전환은 항상 `05_progress.log` 에 기록

## 4. 4.6 — Build chain

### 4.1 LaTeX (template/thesis.tex 또는 _placeholder.tex)

```bash
cd <repo_root>
latexmk -xelatex -interaction=nonstopmode template/thesis.tex
```

요구사항 (user task escalation 자동 작성):
- TeX Live 또는 MiKTeX
- `xelatex` (한국어 wraparound)
- `kotex` (한국어 hangul, Linux/mac 표준) 또는 `xeCJK` (Windows 일반)
- Noto Sans KR / 함초롬 / 본명조 / KAIST 표준 폰트 (학과 양식 specify)
- BibTeX backend: `biber` (`biblatex` 사용 시) 또는 `bibtex`

산출: `template/thesis.pdf` + `thesis_state/08_build.log`

### 4.2 Markdown (template/thesis.md 또는 _placeholder.md)

```bash
pandoc template/thesis.md \
  --pdf-engine=xelatex \
  --bibliography=thesis_state/07_thesis_draft/references.bib \
  --csl=docs/citation-style.csl \
  -V mainfont="Noto Sans KR" \
  -V geometry:margin=2.5cm \
  -o template/thesis.pdf
```

요구사항: pandoc + xelatex + Noto Sans KR.

산출: `template/thesis.pdf` + `thesis_state/08_build.log`.

### 4.3 Build 실패 시 user task escalation

자동 작성 (`thesis_state/03_user_tasks.md` 안):

```
## Task U-N: <thesis build 환경 설정>
- **왜 필요한가**: Phase 4 final build 시 latexmk / pandoc / xelatex 또는 kotex/xeCJK 미설치.
- **무엇을 해야 하나** (LaTeX):
  Windows:
    1. https://miktex.org/download 에서 MiKTeX 설치
    2. 또는 `choco install miktex`
    3. 설치 후 `latexmk --version` 확인
    4. `xeCJK` 패키지 추가: MiKTeX Console → Packages → xeCJK install
    5. Noto Sans KR 폰트 설치: https://fonts.google.com/noto/specimen/Noto+Sans+KR
  mac:
    1. `brew install --cask mactex` (큰 download)
    2. `kotex` 자동 포함
  Linux:
    1. `sudo apt install texlive-full texlive-xetex texlive-lang-korean`
- **무엇을 해야 하나** (Markdown):
    1. `choco install pandoc` (Windows) / `brew install pandoc` (mac) / `apt install pandoc`
    2. 위 LaTeX 환경 + Noto Sans KR 함께 필요
- **완료 검증**: `latexmk -xelatex -interaction=nonstopmode template/_placeholder.tex` 또는 `pandoc template/_placeholder.md --pdf-engine=xelatex -o /tmp/test.pdf` 정상 동작.
- **막혔을 때 대안**: build 안 하고 markdown 그대로 지도교수 제출 (지도교수 양해 시).
- **상태**: blocked
```

## 5. 본문 언어 (한국어 vs 영어)

KAIST FE 졸업논문은 한·영 둘 다 허용 (학생 선택). agent 가 첫 입력 시 학생에게 confirm:

- "본문 언어: ko / en?" — default 한국어
- abstract 는 한·영 양쪽 의무 (학과 표준 — 학생 확인 후 lock)
- 학생 선택을 `thesis_state/07_thesis_draft/_language.json` 에 기록

영어 선택 시: `02_literature.md` 의 KR 선행 연구도 영어 인용 (KR 학회지 영문 abstract / SSRN preprint 우선) + 한국어 paper 인용 시 transliteration (Park (2021), 등).

## 6. Citation management

- BibTeX 만 1차 지원 (text-based, AI 친화)
- `references.bib` schema: standard BibTeX (article / book / incollection)
- `\cite{Famafrench1993}` 양식 또는 markdown `[@Famafrench1993]`
- 인용 style: 학과 양식 specify 또는 default APA (`docs/citation-style.csl` 에 default lock)
- Zotero / Mendeley 통합은 학생 본인이 BibTeX export → `references.bib` 에 merge (agent 가 도움)
