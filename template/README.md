# template/ — 졸업논문 양식 drop in 위치

## 1. 학과 양식 받기 전

이 디렉토리에 `_placeholder.tex` 와 `_placeholder.md` 가 미리 들어 있다. agent 는 학과 양식 부재를 자동 감지 → **4-deferred mode** 로 동작 (section draft 만 `thesis_state/07_thesis_draft/` 에 누적, build 는 placeholder 로 dry-run 가능).

학생이 PDF 결과물을 미리 보고 싶으면:

```bash
# LaTeX placeholder
latexmk -xelatex -interaction=nonstopmode template/_placeholder.tex

# Markdown placeholder
pandoc template/_placeholder.md \
  --pdf-engine=xelatex \
  --bibliography=thesis_state/07_thesis_draft/references.bib \
  -V mainfont="Noto Sans KR" \
  -V geometry:margin=2.5cm \
  -o template/_placeholder.pdf
```

(요구 환경 설치 안 됐으면 `thesis_state/03_user_tasks.md` 에 agent 가 자동으로 설치 가이드 작성.)

## 2. 학과 양식 받은 후

학과·지도교수로부터 받은 양식 파일을 다음 이름으로 drop in:

- **LaTeX 양식** → `template/thesis.tex` (`.cls` / `.sty` 파일들은 같은 디렉토리 또는 본인 `texmf` 경로)
- **Markdown 양식** → `template/thesis.md`

다음 turn 에서 agent 가 자동으로 감지 → **4-final mode** 진입 → 양식 안 anchor 또는 heading 매칭 → `thesis_state/07_thesis_draft/<section>.md` 산출 자동 fill → PDF build.

## 3. 양식 안 anchor convention

agent 가 인식하는 anchor 양식 (양식 안에 직접 작성하면 정확히 그 자리에 fill):

**LaTeX**:
```latex
\chapter{Introduction}
% AGENT_FILL: chapter_1_introduction

\chapter{Methodology}
% AGENT_FILL: chapter_4_methodology
```

**Markdown**:
```markdown
# 1. Introduction

<!-- AGENT_FILL: chapter_1_introduction -->

# 4. Methodology

<!-- AGENT_FILL: chapter_4_methodology -->
```

지원 section_id (`docs/phase-4-thesis-writing.md` §3.2 참조):
`title_page` / `abstract_kr` / `abstract_en` / `keywords` / `chapter_1_introduction` / `chapter_2_literature` / `chapter_3_data` / `chapter_4_methodology` / `chapter_5_results` / `chapter_6_robustness` / `chapter_7_discussion` / `chapter_8_conclusion` / `bibliography` / `appendix`.

## 4. Anchor 없는 양식

학과 양식에 anchor 가 없어도 동작한다 (heading-match fallback). agent 가 양식 안 chapter / section heading 의 한·영 키워드를 매칭:

| Section ID | 매칭 한·영 keyword |
|---|---|
| `chapter_1_introduction` | "서론" / "Introduction" |
| `chapter_2_literature` | "선행 연구" / "이론적 배경" / "Literature" |
| `chapter_3_data` | "자료" / "데이터" / "표본" / "Data" / "Sample" |
| `chapter_4_methodology` | "방법론" / "연구 방법" / "Methodology" / "Methods" |
| `chapter_5_results` | "분석 결과" / "실증 결과" / "Results" |
| `chapter_6_robustness` | "강건성" / "추가 분석" / "Robustness" |
| `chapter_7_discussion` | "논의" / "토의" / "해석" / "Discussion" |
| `chapter_8_conclusion` | "결론" / "Conclusion" |

heading 모호 시 (예: "결과 및 논의" 가 results 인지 discussion 인지) → agent 가 `03_user_tasks.md` 에 escalation 으로 학생 명시 확인 요청.

## 5. 안전 보장

- agent 는 anchor / heading 매칭된 위치만 fill. 학생이 양식 안 직접 작성한 부분 (학생 본인 인사말, 감사의 글, 표지 학생 정보 등) 절대 덮어쓰기 금지.
- mode 전환 (deferred ↔ final) 은 항상 `thesis_state/05_progress.log` 에 기록.
- `template/thesis.{tex,md}` 삭제 시 자동 4-deferred 복귀 (학생이 양식 잘못 drop in 했을 때 되돌리기 안전).
