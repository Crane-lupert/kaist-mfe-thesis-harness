# AGENTS.md — KAIST FE 석사 졸업논문 재현 하네스

> 모든 AI 코딩 툴이 처음 읽는 단일 SoT (Source of Truth). Claude Code / Codex CLI / Cursor / Antigravity / GPT 웹 어디서 열어도 동일 동작.
> CLAUDE.md / .cursorrules / .codex/AGENTS.md 는 본 파일을 import 하는 thin wrapper.
> Phase 별 상세 spec 은 `docs/phase-*.md` 참조 (200줄 cap 유지 위해 분해).

## 0. Tool detection (모든 세션의 첫 작업)

1. `thesis_state/tool.json` 있으면 신뢰하고 §1 진입.
2. 없으면 `pwsh tool-routing/detect.ps1` (Windows) 또는 `bash tool-routing/detect.sh` (POSIX) 실행. env 변수 probe → JSON 작성 (`claude-code` / `codex-cli` / `cursor` / `antigravity` / `generic-shell-agent`).
3. shell 미사용 (ChatGPT/Gemini 웹) → 학생이 `thesis_state/tool.json` 직접 작성: `{"tool":"web-paste","capabilities":["manual-paste-only"]}`. `prompts/` 디렉토리 paste.
4. 학생에게 1줄 보고: "감지 툴: X. autopilot 가능 = (예/아니오). 진행할까요?"

## 1. 이 레포의 목적 + 6-phase pipeline

JF / JFE / RFS / JFQA 등 top 저널 paper 의 **한국 시장 재현** KAIST 경영대 FE 석사 졸업논문을 paper PDF + 학과 양식 (선택) 만 넣으면 **사용자가 직접 해야 하는 일을 제외한 모든 단계**를 자동 진행.

| Phase | 목적 | 산출 | 상세 spec |
|---|---|---|---|
| **0. Paper ingestion** | PDF → MD 변환 (token 최적화) + section split + methodology inventory + feasibility 분석 | `paper/converted/` + `thesis_state/00_feasibility.md` | `docs/phase-0-paper-ingestion.md` |
| **1. Planning** | 원저 변수 ↔ KR 데이터 mapping + agent task vs user task split | `thesis_state/01-04_*.md` | 본 파일 §4 |
| **2. Execution** | agent autopilot loop (overnight 가능 툴) + user task escalation | `code/` + `thesis_state/05_progress.log` | 본 파일 §5 |
| **2.5. Verification gate** | 원저 method · robustness 가 KR 구현에서 어떻게 매핑됐는지 자동 cross-check + faithful lock 위반 검출 | `thesis_state/05_progress.log` append | `docs/phase-2_5-verification.md` |
| **3. Mid-presentation prep** | 중간 교수 발표용 deck + Q&A + 학생 self-test 8/10 | `thesis_state/06_presentation.md` | 본 파일 §7 |
| **4. Thesis writing** | section 별 draft + figure/BibTeX + 학과 양식 받으면 자동 fill + PDF build | `thesis_state/07_thesis_draft/` + `08_build.log` | `docs/phase-4-thesis-writing.md` |
| **5. Defense prep** | 최종 defense deck + committee Q&A + self-test 9/10 | `thesis_state/09_defense.md` | `docs/phase-5-defense.md` |

## 2. 학생 입력 위치

- **원저 PDF**: `paper/` 디렉토리에 PDF 1개 (파일명 자유). agent 가 `paper/*.pdf` glob 으로 자동 감지. 2개 이상이면 학생에게 어느 것을 사용할지 묻기. **파일명 rename 강제 X.**
- `paper/student_notes.md` — 학생 관심사·이미 본 자료 (선택)
- `template/thesis.tex` 또는 `template/thesis.md` — 학과 졸업논문 양식 (받기 전엔 비워둠, 받은 후 drop in)
- **추가 데이터 경로** (선택): 학생이 본인 보유 raw data 디렉토리를 명시 가능 (예: `D:\my_kaist_data`, `E:\fnguide_backup`). Phase 0 entry 시 agent 가 "추가 데이터 경로 있나요?" 묻고 학생 응답에 따라 multi-path probe. 응답 없으면 `data/raw/` default.

PDF 누락 상태로 Phase 0 진입 요청 시 agent 거부 + 누락 항목 안내.

## 3. Phase 0 — Paper ingestion + Feasibility

자세히 → `docs/phase-0-paper-ingestion.md`. 요약:

- **0.1 PDF → MD**: `marker-pdf` default. fallback chain: `docling` → `PyMuPDF` → `pdftotext`. fallback 사용 시 `manifest.json` 안 `conversion_fidelity` 필드 `low` 표기 + Phase 1 의 table-based 변수 (paper Table N 의 numeric value 등) PDF 원본 재확인 의무.
- **0.2 Section split**: abstract / introduction / data / methodology / results / robustness / references → `paper/converted/structured/*.md`.
- **0.3 Inventory**: methodology · variable · test 의 machine-readable JSON → `paper/converted/manifest.json`. 이후 phase 가 manifest 만 보고 cherry-pick (token 절감 60-80%).
- **0.3.5 Data probe (의무)**: 학생 보유 모든 raw 데이터 디렉토리 (§2 의 추가 경로 포함) 안 모든 파일 (xlsx/csv/parquet/json) header + 상위 5 row + dtype + non-NaN coverage 자동 parsing → `thesis_state/_data_probe.json`. **파일명만으로 카테고리 추정 절대 금지**. 이후 Phase 1 매핑의 입력.
- **0.4 Feasibility**: `thesis_state/00_feasibility.md` — §1 원저 한 줄 요약 / §2 method·variable·test inventory 표 / §3 KR 가용성 (`AVAILABLE` / `PARTIAL §4.2` / `PARTIAL §4.3` / `MISSING` evidence 의무) / §4 KR 시장 특수성 한계 / §5 Phase 1 진입 권고 + risk flag + **각 결정 항목별 agent 권장 (강한 추천 + 학술적 사유 + trade-off) 의무** (단순 listing 금지).

`docs/kr-market-quirks.md` + `docs/fnguide-dictionary.md` + `docs/checkexpert-howto.md` 의무 참조.

## 4. Phase 1 — Replication planning

산출 4종 (모두 `thesis_state/`):

- `01_methodology_map.md` — 원저 변수명 ↔ KR 데이터 컬럼명 + 정의 일치 여부
- `02_data_inventory.md` — 필요 raw 데이터 file/api list + 학생 라이선스 접근 가능 여부
- `03_user_tasks.md` — 학생이 직접 해야 할 작업 list (§6 escalation 양식)
- `04_agent_tasks.md` — agent autopilot task list (의존성 표시)

Task split: agent = 코드·테스트·회귀·검정·robustness·차트·draft / user = 데이터 라이선스·export·API 키·결제·실물 자료. 애매하면 user task (over-escalation fail-secure).

### 4.5 Phase 1.5 — Existing-implementation audit (의무, 학생 prior 작업 있을 때)

학생이 본인 prior code (notebooks / .py / 산출 CSV 등) 를 보유한 경우 (예: `D:\my_data\Code\thesis.ipynb`, 학생이 작년 작업한 분량 등) Phase 1 진입 후 다음 audit 강제:

1. **Inventory probe**: prior code 안 모든 변수 derive 산식 / method 호출을 `manifest.json` 의 inventory 와 cross-check.
2. **Lock A/B 위반 검출 보고**: 학생 prior code 의 silent substitute (원저 X 변수 정의 ↔ 학생 산식 mismatch — 예: V9 LTY 가 paper 10y 인데 학생 산식 3y), silent drop (paper 명시 항목 미구현), silent proxy, silent add (z-score / Bonferroni / industry FE 등 paper 미언급 자의 추가) 모두 학생에게 보고.
3. **재사용 vs 재계산 결정**: 학생이 each violation 별로 (a) 재사용 (학생 명시 동의 + 본문 transparent) 또는 (b) agent 재계산 (paper-faithful) 선택.

산출: `thesis_state/01_methodology_map.md` 안 "Existing-implementation discrepancy" 표.

## 5. Phase 2 — Execution

### 5.1 Autopilot loop (claude-code / codex-cli 만 — `tool.json.capabilities` 에 `overnight-autopilot`)

1. `04_agent_tasks.md` 에서 의존성 충족 task 1개 선택 → 진행
2. 진행 중 user-blocking → §6 escalation + 다음 독립 task
3. 완료 → `05_progress.log` append (timestamp + task id + 결과)
4. task 상태 갱신 + 1번 반복

중단: 모든 task done/blocked / 학생 명시 stop / 데이터 가설 위반 발견 (§8 faithful lock 위반 가능성).

### 5.2 Step-trigger (cursor / antigravity / generic-shell-agent / web-paste)

`prompts/` 디렉토리 paste — `00-feasibility.md` / `01-planning.md` / `02-autopilot-step.md` / `02_5-verification.md` / `03-prof-rehearsal.md` / `04-thesis-section.md` / `05-defense-rehearsal.md`.

## 6. User-blocking escalation 양식

`03_user_tasks.md` 에 다음 2 sub-mode 중 하나로 append (멈추지 않음):

### 6.1 Task U-N (학생 직접 작업) — 데이터 다운로드 / API 키 / 환경 설치

```
## Task U-N: <한 줄 제목>
- **왜 필요한가**: <어느 paper section / 어느 agent task 진행 중>
- **무엇을 해야 하나**: <step-by-step, 화면·메뉴·클릭·저장 위치까지>
- **완료 검증**: <어느 파일이 어디에 어떤 형태로>
- **막혔을 때 대안**: <fallback>
- **상태**: blocked | done
```

### 6.2 Task M-N (지도교수 메일) — 원저에 있는데 KR 에 부재 (MISSING) 일 때만

```
## Task M-N: 지도교수 메일 — <원저 X 변수/method 가 KR 에 부재>
- **상황**: <원저 §X 의 무엇이 KR 에 정확히 부재인지 + 부재 증거 (검색 / vendor 문서 / 문헌)>
- **agent 대안 후보 (2-3개)**: <KR 시장 안 candidate proxy / drop / 다른 method>
- **학생 의견** (학생이 보내기 전 작성): <학생 본인 결정>
- **메일 본문 draft** (학생이 copy 또는 수정 후 send):
  ```
  교수님께,
  <졸업논문 paper 재현 중 본 변수/method 가 KR 에 부재 — 어느 대안이 좋을지 의견 부탁드립니다>
  ```
- **상태**: pending → 메일 보냄 → 답 받음 → done
```

작성 후 즉시 다음 독립 task 진행. 별도 interrupt 금지.

## 7. Phase 3 — Mid-presentation prep

산출: `thesis_state/06_presentation.md`.

- §1 1분 elevator (10줄 이하) / §2 5분 deck draft (8-10 슬라이드) / §3 Q&A 10-15개 + 모범 답안 (`docs/presentation-rubric.md` 기반) / §4 학생 self-test: agent 가 §3 5개 무작위 → 학생 답 평가, 이해도 **8/10** 통과 전 final 처리 금지.

**Strict Phase 3 entry gate** (절대 약화 금지): Phase 2.5 가 `PASS` 일 때만 진입. **`PASS_WITH_DEFERRALS` 같은 부분 PASS 개념 없음**. paper 의 모든 robustness (R1, R2, R3, ...) 가 기술적 불가능 (vendor 라이선스 자체 부재 + 학생 명시 sign-off) 외에는 100% 구현 완료 의무. deferred 1건이라도 있으면 Phase 3 entry 차단. 상세 → `docs/phase-2_5-verification.md`.

## 8. Faithful translation lock (rigor 핵심 — 절대 약화 금지)

다음 세 lock 동시 적용:

**Lock A — Subtract lock**: 원저 method · 변수 · 검증 · robustness 는 "한국에 존재하지 않음" 증명되지 않는 한 substitute / drop / proxy 대체 금지.

**Lock B — Add lock**: 원저에 명시되지 않은 standard method (예: Bonferroni / FDR / Newey-West / industry FE / sub-period split 등) 의 임의 추가 금지. "관례상 추가" / "standard 니까 넣었어요" 식 자기 판단 금지. 원저 text 에 그대로 명시된 것만 inventory + 구현.

**Lock C — Look-ahead bias lock**: rolling / expanding-window estimator (MODWT / PCA / ICA / factor loading / similarity scoring / quantile cut / standardization 등) 은 **각 OOS time step 에서 recursive recomputation 의무**. 전체 sample 으로 fit 한 후 test set 에 적용 금지. paper 가 "recursive" / "no look-ahead" / "at each iteration" 등으로 명시한 모든 항목 +  paper 미언급이라도 rolling-window context 인 모든 estimator 적용. Phase 2.5 가 자동 검출 (`docs/phase-2_5-verification.md` §3.5).

판정 순서 (Lock A):
1. KR 동등 존재 → 자동 사용
2. KR 정의 차이가 자연스러운 KR replication 차원 (예: KR sub-period regime / 우선주 universe filter / KR industry 분류) → agent 자체 판단 + Phase 4 thesis 본문에 transparent 명시. 별도 sign-off 불필요.
3. KR 에 정확히 부재 (MISSING) → `03_user_tasks.md` §6.2 Task M (지도교수 메일) escalation: agent 대안 후보 + 학생 의견 + 메일 본문 draft

판정 순서 (Lock B):
1. `paper/converted/manifest.json` 의 methodology_inventory / test_inventory 는 원저 text 안 명시된 것만 entry. agent 가 "관례" / "standard" / "일반적으로" 같은 사유로 추가 금지.
2. Phase 2.5 verification gate 가 code 안 method 가 manifest inventory 와 1:1 매칭하는지 검출. 매칭 없는 추가 method 발견 → silent-add 위반 → 제거 또는 학생 명시 결정.

agent "비슷한 변수로 했어요" / "관례상 Bonferroni 도 했어요" 임의 결정 절대 금지. Phase 2.5 verification gate 가 자동 검출.

## 9. Phase 4 — Thesis writing (deferred-fill)

자세히 → `docs/phase-4-thesis-writing.md`. 요약:

- **4.1 Template detection** — 우선순위: `template/thesis.tex` → `thesis.md` → `_placeholder.tex` → `_placeholder.md`
- **4.2 Section drafting** — `thesis_state/07_thesis_draft/{abstract_kr,abstract_en,01_introduction,02_literature,03_data,04_methodology,05_results,06_robustness,07_discussion,08_conclusion,references.bib}.md`
- **4.3 Figure / table** — matplotlib + seaborn 자동 생성 → `thesis_state/07_thesis_draft/figures/`
- **4.4 BibTeX 자동** — `paper/converted/structured/references.bib` 기반 + KR 선행 연구 추가
- **4.5 4-deferred vs 4-final** — `thesis.{tex,md}` 부재 → 4-deferred (sections 누적, placeholder dry-run 가능) / 감지 → 4-final (anchor 또는 heading-match 자동 fill + build)
- **4.6 Build chain** — LaTeX: `latexmk -xelatex` + `kotex` / `xeCJK`. Markdown: `pandoc` + `xelatex` + Noto Sans KR. 실패 시 user task escalation.

## 10. Phase 5 — Defense prep (**모의면접 모드 / mock interview mode**)

자세히 → `docs/phase-5-defense.md`. 요약: Phase 3 mid-presentation 보다 deeper. committee-level Q&A simulation. self-test threshold **9/10** (Phase 3 의 8/10 보다 strict).

**Strict Phase 5 entry gate**: Phase 2.5 PASS (deferred 0건) + Phase 4 thesis writing 완료 + Phase 4 본문에 KR-specific contribution 명시 (§7 Discussion 안 paper US 와 차이 발견 = 학생 thesis 의 학술적 contribution) 까지 모두 완료 후만 진입. **모의면접 모드** = agent 가 심사위원 페르소나 (지도교수 / 외부 심사 / methodology expert) 차례로 forensic Q&A.

## 11. State 파일 규약 (cross-tool baton)

`thesis_state/` 안 10종 + `paper/converted/` 가공물. 어느 툴이든 다음 세션 시작 시 읽고 어디까지 진행됐는지 파악.

- `tool.json` (P0) / `00_feasibility.md` (P0) / `01_methodology_map.md` `02_data_inventory.md` `03_user_tasks.md` `04_agent_tasks.md` (P1) / `05_progress.log` (P2 + P2.5 append-only) / `06_presentation.md` (P3) / `07_thesis_draft/` (P4 sub-tree) / `08_build.log` (P4 final build) / `09_defense.md` (P5)

각 markdown 상단 frontmatter 의무: `last_updated` / `current_phase` / `next_action`.

## 12. 비대상

- 실거래 신호 발신 / 주문 집행 — scope 외
- 학생 본인 thesis 결론·해석 — agent 분석·draft 만, 학술 주장은 학생 책임
- 데이터 라이선스 위반 우회 — fnguide / CheckExpert / WiseFn 라이선스 범위 안

## 13. 사용 룰 요약 (학생용 5줄)

1. `paper/original.pdf` 넣고 `paper/student_notes.md` 작성 (선택). 학과 양식 받으면 `template/thesis.{tex,md}` drop in (선택, 나중 가능).
2. 본인의 AI 툴 열기 (Claude Code / Codex / Cursor / Antigravity / GPT 웹).
3. 첫 입력: "Read AGENTS.md and start Phase 0" (web 인 경우 `prompts/00-feasibility.md` paste).
4. Phase 0 산출 검토 → Phase 1 / 2 / 2.5 / 3 / 4 / 5 진행 (overnight 가능 툴은 자동 다음 phase 진입).
5. Phase 3 self-test 8/10 통과 후 중간 발표 / Phase 5 self-test 9/10 통과 후 최종 defense.
