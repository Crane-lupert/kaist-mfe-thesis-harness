# Phase 0 — Feasibility analysis prompt

> ChatGPT 웹 / Gemini 웹 사용자용. AGENTS.md + paper PDF 내용 + (선택) student_notes.md 를 이미 paste 한 conversation 에서 본 prompt 를 paste.

---

당신은 KAIST FE 졸업논문 재현 AI agent 다. 본 conversation 에 이미 `AGENTS.md` + paper content + (선택) `paper/student_notes.md` 가 제공됐다.

지금 Phase 0 (Paper ingestion + Feasibility) 진행. AGENTS.md §3 + `docs/phase-0-paper-ingestion.md` (있으면) 따라 다음을 수행:

## ⚠️ 사전 lock 의무

**Lock B (Add lock) — 자의 method 추가 금지**: 원저 text 에 명시되지 않은 method (예: Bonferroni / FDR / Newey-West / industry FE / sub-period split 등) 를 inventory 에 추가하지 마라. "관례상" / "standard" / "보통 이런 paper 는" 같은 사유로 자기 판단 추가 절대 금지. 원저에 그대로 명시된 것만 inventory.

**CheckExpert KAIST 라이선스 available** (confirmed): brokerage-level forecast / analyst dispersion / recommendation 등은 CheckExpert 로 정확 구현. fnguide aggregate proxy 사용 금지 (silent proxy 위반).

## Task 0.1 — Paper structure 식별

paper 의 다음 section 을 식별 + 각 section 의 page 범위 표시 (paste 한 PDF text 기반):
- Abstract
- Introduction
- Data / Sample
- Methodology / Empirical Strategy
- Results
- Robustness
- Conclusion
- References

## Task 0.2 — Inventory 작성 (4 종)

### Methodology inventory
| # | Method 이름 | section / page | Key parameters | KR 가용성 hint |

### Variable inventory
| Variable | 원저 정의 | source paper | KR 데이터 후보 (fnguide item code) | 가용성 |

### Test / robustness inventory
| Test / Robustness | 목적 | 원저 section / page | KR 적용 가능성 |

### Data source inventory
| 원저 데이터 source | KR equivalent (vendor + item code) | 가용성 |

## Task 0.3 — Feasibility 보고서 (`thesis_state/00_feasibility.md` 내용)

다음 양식으로 작성:

```
---
last_updated: YYYY-MM-DD
current_phase: P0
next_action: Phase 1 entry approval
---

# Phase 0 Feasibility — <paper title 요약>

## §1 원저 한 줄 요약
[발표용 1-2 문장]

## §2 원저 핵심 inventory
[위 §0.2 의 4 표]

## §3 한국 시장 가용성 분석 (AVAILABLE / PARTIAL §4.2 / PARTIAL §4.3 / MISSING)
- AVAILABLE (N 개): ... (자동 진행)
- PARTIAL §4.2 (M 개, CheckExpert 또는 다른 KR vendor 로 fix 가능): ... (학생 task — 라이선스 확인 + 데이터 다운로드)
- PARTIAL §4.3 (K 개, 자연스러운 KR replication — sub-period KR regime / 우선주 / industry 등): ... (agent 자동 진행 + Phase 4 본문 명시 의무)
- MISSING (L 개, KR 부재): ... (Task M 지도교수 메일 escalation, `docs/rigor-lock.md` §4.1)

## §4 한국 시장 특수성 한계
- 우선주 / 보통주 처리
- 상하한가 ±30% 효과
- KOSPI / KOSDAQ universe 분리
- 회계기준 IFRS 도입 timing (2011-2013)
- 5% 지분 공시 등 KR-specific 항목

## §5 Phase 1 진입 권고
- Risk flag: 낮음 / 중간 / 높음
- 사유: 1 줄
- 권장 다음 액션: Phase 1 진입 OR 학생 + 지도교수 사전 컨펌
```

## 출력 형식

위 보고서 내용을 markdown 으로 출력. 학생이 그대로 copy → `thesis_state/00_feasibility.md` 에 저장.

## 주의 의무

- faithful translation lock §8 (AGENTS.md / `docs/rigor-lock.md`) 엄격 적용 — 2 lock (Subtract + Add) 동시
- KR 시장 quirk 의무 참조 (`docs/kr-market-quirks.md` — 본 conversation 에 paste 됐으면)
- 모호 시 PARTIAL 또는 MISSING 으로 보수적 판정 — silent substitute 금지
- 원저 외 method (Bonferroni / FDR / industry FE 등) 자기 판단 추가 절대 금지 — silent add 위반
- CheckExpert (KAIST 라이선스 available) 사용 가능한 변수를 fnguide aggregate proxy 로 대체 금지 — silent proxy 위반
