# Phase 2.5 — Implementation verification gate (상세 spec)

> AGENTS.md §1 의 Phase 2.5. Phase 3 (mid-presentation) 진입 전 binding gate.
> 원저 method / variable / test 가 KR 구현에서 어떻게 매핑됐는지 자동 cross-check + faithful lock §8 위반 (substitute / drop / proxy 임의 결정) 자동 검출.

## 1. 이 gate 의 의도

발표 자리에서 교수가 던지는 핵심 질문 3종:
- "원저의 method N 을 KR 에서 어떻게 구현했나?"
- "원저의 변수 X 가 KR 에는 무엇인가? proxy 라면 왜 그 proxy 인가?"
- "원저의 robustness Y 를 KR 에서 했나? 안 했다면 왜?"

이 질문에 학생이 답을 못 하는 가장 흔한 사유 = agent 가 substitute / drop / proxy 를 학생 미인지 상태로 임의 결정. Phase 2.5 가 발표 이전에 이를 자동 검출.

## 2. Verification matrix

`paper/converted/manifest.json` 의 inventory 와 `code/` 안 실제 구현을 cross-check:

```
thesis_state/05_progress.log 안에 append:

# Phase 2.5 Verification Audit (YYYY-MM-DD)

## Methodology coverage
| # | Original method | KR 구현 위치 (code path) | 상태 |
|---|---|---|---|
| 1 | Fama-MacBeth two-step | code/replication/fama_macbeth.py:run() | IMPLEMENTED |
| 2 | Newey-West HAC (12 lags) | code/replication/fama_macbeth.py:_se() | IMPLEMENTED |
| 3 | Sub-period split (1980-1999 / 2000-2009) | code/replication/subperiod.py:split() | IMPLEMENTED |
| 4 | Industry FE (12 industries) | code/replication/regressions.py:industry_fe() | PARTIAL — KR 11 GICS sector 사용, 원저 12 와 다름 |
| 5 | Stambaugh bias correction | (미구현) | MISSING — Phase 3 전 결정 필요 |

## Variable mapping
| Variable | Original definition | KR 구현 값 source | 상태 |
|---|---|---|---|
| BE/ME | book equity / market cap | code/etl/bm_ratio.py: S420006202 역수 × 6000903003 | IMPLEMENTED |
| Momentum (12-2) | t-12~t-2 cumulative return | code/etl/momentum.py | IMPLEMENTED |
| Idiosyncratic vol | residual std from CAPM regression | (미구현) | MISSING |

## Test coverage
| Test | Original (paper section / page) | KR 구현 | 상태 |
|---|---|---|---|
| Bonferroni m=25 | §4, p.18 | code/replication/multiple_test.py | IMPLEMENTED |
| Out-of-sample 2010-2015 | §5.1, p.22 | code/replication/oos.py | IMPLEMENTED |
| Reverse causality test | §5.3, p.24 | (미구현) | MISSING |

## Robustness coverage
| Robustness | Original | KR 구현 | 상태 |
|---|---|---|---|
| Sub-sample by size | §5.2 | code/replication/size_subsample.py | IMPLEMENTED |
| Alternative weighting | §5.4 | (미구현) | MISSING |
```

## 3. 자동 검출 rule

agent 는 다음 4 종 위반을 자동 검출 + Phase 3 차단:

### 3.1 Silent substitute (Lock A)

`manifest.methodology_inventory[i]` 또는 `variable_inventory[i]` 에 있는데 `code/` 안 구현에서 정의가 다른 경우 — substitute.

검출:
- code 안 변수명·함수명 + comment grep → manifest 정의와 비교
- 위반 발견 → `thesis_state/03_user_tasks.md` 에 escalation 으로 강제 학생 검토

예시 — manifest 에 `BE/ME = book equity / market cap` 인데 code 에 `book equity / total equity` 로 구현된 경우: **silent substitute 위반**.

### 3.2 Silent drop (Lock A)

`manifest.methodology_inventory` / `test_inventory` / `robustness_inventory` 항목 중 `code/` 에 매핑 없음 — drop.

검출:
- manifest entry 마다 code path 매핑 표 작성
- 매핑 없는 entry 발견 → `03_user_tasks.md` escalation
- MISSING 카테고리인 경우 (KR 부재) → §4 Task M (지도교수 메일) 양식 escalation

예시 — manifest 에 `Stambaugh bias correction` 있는데 구현 없음: **silent drop 위반**.

### 3.3 Silent proxy (Lock A)

manifest 의 variable / data_source 가 KR 에 정확히 없어서 proxy 사용한 경우. `00_feasibility.md` §3 의 PARTIAL 항목과 일치하는지 확인.

검출:
- code 안 variable 정의 ↔ feasibility 의 PARTIAL 목록 cross-check
- PARTIAL 목록에 없는 변수가 proxy 로 구현된 경우 → **silent proxy 위반**
- 단, CheckExpert KAIST 라이선스 available 인 변수가 fnguide aggregate proxy 로 구현된 경우 → silent proxy 위반 (CheckExpert 로 fix 의무, `docs/checkexpert-howto.md`)

예시 — `analyst dispersion` 을 원저는 IBES brokerage-level std 인데 KR 구현은 fnguide `(E3 max-min)` aggregate proxy → silent proxy. CheckExpert 사용 의무.

### 3.4 Silent add (Lock B — 신설)

`code/replication/` 안 method file 또는 main analysis 의 method 가 `manifest.json` 의 inventory 에 없음 — agent 자기 판단 추가.

검출:
- `code/replication/` 의 모든 .py 파일 main function ↔ `manifest.methodology_inventory + test_inventory + robustness_inventory` entry 매칭 표 작성
- 매칭 없는 method 발견 → **silent add 위반**

예시:
- 원저 paper 에 Bonferroni 언급 없는데 `code/replication/bonferroni.py` 작성됨 → 위반
- 원저 industry FE 미언급인데 regression 에 industry FE 포함됨 → 위반
- 원저 monthly only 인데 daily robustness 자체 추가됨 → 위반

Lock B 위반 처리:
- 해당 method file / code 제거 (default)
- OR 학생이 명시 "이 추가 method 를 본 thesis 의 contribution 으로 한다" 결정 시 `03_user_tasks.md` 안 사유 기록 + Phase 4 thesis 본문 §4 methodology 에 "원저 외 추가 method" 명시 의무

## 4. PASS 조건

Phase 2.5 PASS 는 다음 모두:

1. Methodology coverage 표 안 모든 row `IMPLEMENTED` 또는 (`PARTIAL §4.3 자연스러운 KR replication` + Phase 4 본문 명시 의무 기록) 또는 (`MISSING` + Task M 메일 보냄 + 답 받음 + 학생 결정 기록)
2. Variable mapping 표 동일 조건
3. Test coverage 표 동일 조건
4. Robustness coverage 표 동일 조건
5. Silent substitute / drop / proxy / **add** 위반 0 건 (4 종 lock)

FAIL 시: `03_user_tasks.md` 에 escalation 추가 + Phase 3 entry 차단. 학생이 추가 구현 (Lock A drop/substitute fix) / silent-add 제거 (Lock B fix) / Task M 메일 진행 후 Phase 2 재진입 → 재 verification.

## 5. PASS 후 산출

`thesis_state/05_progress.log` 에 verification audit append 한 마지막 entry 가 PASS marker. Phase 3 entry 시 agent 가 이 marker 확인.

발표 자료 (Phase 3 의 §3 Q&A) 작성 시 이 verification matrix 가 직접 입력. "원저 method N 을 KR 에서 어떻게 구현했나?" 질문에 학생이 답할 수 있는 모범 답안 자동 생성.
