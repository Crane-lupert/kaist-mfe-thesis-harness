---
name: phase-4-thesis-writing
description: KAIST FE 졸업논문 재현 Phase 4 (thesis 본문 작성). Section 별 markdown draft (`thesis_state/07_thesis_draft/`) + figure / table / BibTeX 자동 생성 + 학과 양식 받으면 자동 fill (deferred-fill 패턴). 학생이 "thesis 작성 시작", "본문 draft", "양식에 내용 채워" 같이 말할 때 invoke.
---

본 skill 은 AGENTS.md §9 (Phase 4 — Thesis writing) + `docs/phase-4-thesis-writing.md` 상세 spec 실행 wrapper.

## 진입 절차

1. Phase 3 PASS 확인 (`06_presentation.md` frontmatter `current_phase: P3-PASS`).
2. **Template detection** (`docs/phase-4-thesis-writing.md` §3.1 우선순위):
   1. `template/thesis.tex` (LaTeX)
   2. `template/thesis.md` (Markdown)
   3. `template/_placeholder.tex` (dry-run only)
   4. `template/_placeholder.md` (동상)
3. **Mode 분기**:
   - `thesis.{tex,md}` 부재 → **4-deferred mode**:
     - section drafting only (`thesis_state/07_thesis_draft/` 안 10 종 파일 + figures/ + references.bib)
     - 학생이 양식 받기 전까지 sections 누적
     - `_placeholder.{tex,md}` 로 dry-run build 가능 (학생이 결과물 미리 보기)
   - `thesis.{tex,md}` 감지 → **4-final mode**:
     - Step A: anchor parse (`% AGENT_FILL: <section>` 또는 `<!-- AGENT_FILL: <section> -->`)
     - Step B: anchor 없으면 heading-match fallback (`docs/phase-4-thesis-writing.md` §3.2 한·영 keyword 표)
     - Step C: `07_thesis_draft/*.md` 산출을 매칭 위치에 fill
     - Step D: build (LaTeX: `latexmk -xelatex`, Markdown: `pandoc + xelatex`)
     - Step E: build 실패 시 user task escalation (`docs/phase-4-thesis-writing.md` §4.3 양식)
4. 학생이 학과 양식 받으면 다음 turn 에서 4-deferred → 4-final 자동 전환 + 기존 draft 재사용.

## 본문 언어

학생이 첫 진입 시 한국어 / 영어 confirm — `07_thesis_draft/_language.json` 에 lock.

## 의무 참조

- `docs/phase-4-thesis-writing.md` — 상세 spec (section drafting + deferred-fill + build chain)
- `docs/rigor-lock.md` — substitute 금지 lock (작성 시 원저 method 자기 임의 해석 금지)
