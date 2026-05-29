<!-- template/_placeholder.md
     CC0 generic skeleton for KAIST FE thesis harness (Markdown 버전).

     사용법:
       - 학과 졸업논문 양식이 markdown 기반이면 thesis.md 로 이름 바꾸고 drop in.
       - 받기 전에는 이 placeholder 로 dry-run build 가능 (pandoc + xelatex).
       - agent 가 <!-- AGENT_FILL: <section> --> anchor 를 인식해서 자동 fill.
       - anchor 가 없는 양식이면 heading-match fallback (docs/phase-4-thesis-writing.md §3.2).

     Build:
       pandoc template/_placeholder.md \
         --pdf-engine=xelatex \
         --bibliography=thesis_state/07_thesis_draft/references.bib \
         -V mainfont="Noto Sans KR" \
         -V geometry:margin=2.5cm \
         -o template/_placeholder.pdf
-->

---
title: "[Thesis Title 자리]"
subtitle: "[Subtitle 자리]"
author: "[학생 이름] | 지도교수: [지도교수 이름]"
institute: "한국과학기술원 경영대학 금융공학프로그램"
date: "[YYYY 년 MM 월]"
lang: ko
mainfont: "Noto Sans KR"
geometry: margin=2.5cm
bibliography: thesis_state/07_thesis_draft/references.bib
csl: docs/citation-style.csl
---

<!-- AGENT_FILL: title_page -->
<!-- (학생 정보: 이름·학번·학과·지도교수. 위 YAML frontmatter 에 작성하거나 여기에 본문 추가) -->

# Abstract (English)

<!-- AGENT_FILL: abstract_en -->

# 국문 초록

<!-- AGENT_FILL: abstract_kr -->

## Keywords

<!-- AGENT_FILL: keywords -->

\newpage

# 1. Introduction

<!-- AGENT_FILL: chapter_1_introduction -->

# 2. Literature Review

<!-- AGENT_FILL: chapter_2_literature -->

# 3. Data

<!-- AGENT_FILL: chapter_3_data -->

# 4. Methodology

<!-- AGENT_FILL: chapter_4_methodology -->

# 5. Empirical Results

<!-- AGENT_FILL: chapter_5_results -->

# 6. Robustness Checks

<!-- AGENT_FILL: chapter_6_robustness -->

# 7. Discussion

<!-- AGENT_FILL: chapter_7_discussion -->

# 8. Conclusion

<!-- AGENT_FILL: chapter_8_conclusion -->

\newpage

# 참고문헌 / References

<!-- bibliography 자동 삽입 위치 (pandoc citeproc) -->

# 부록 / Appendix

<!-- AGENT_FILL: appendix -->
