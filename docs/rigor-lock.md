# Faithful translation lock — long-form

> AGENTS.md §8 의 보충. 졸업논문 학술 무결성의 핵심 lock. 2 lock (Subtract / Add) 동시 적용.

## 1. 원칙 (5줄)

**Lock A (Subtract)**: 원저 method · 변수 · 검증 · robustness 는 "한국에 존재하지 않음" 증명되지 않는 한 substitute / drop / proxy 대체 금지.

**Lock B (Add)**: 원저에 명시되지 않은 standard method 임의 추가 금지. agent 가 "관례상" / "보통 이런 paper 는 ... 도 해요" 식 자기 판단으로 추가 절대 금지.

판정 순서:
1. KR 동등 존재 → 자동 진행
2. KR 정의 차이가 자연스러운 KR replication (sub-period KR regime / 우선주 처리 / KR industry 분류 등) → agent 자체 판단 + Phase 4 thesis 본문 transparent 명시
3. KR 에 정확히 부재 (MISSING) → 지도교수 메일 (M task) escalation

## 2. 왜 이 두 lock 이 critical 인가

### 2.1 Lock A (Subtract) 가 필요한 이유

졸업논문은 paper 의 KR replication 이 학술적 가치. 원저 변수 / method 의 임의 변경 = 논문 가치 훼손. 발표 자리 forensic 질문:

- "원저는 X 변수를 썼는데 왜 Y 를 썼나?"
- "원저의 robustness check Z 를 왜 안 했나?"

### 2.2 Lock B (Add) 가 필요한 이유 — 중요!

agent (특히 LLM 기반) 가 paper 작성 시 자기 학습 분포 안 "흔한" method 를 자기 판단으로 추가하는 경향. 예시:

- 원저 Fama-MacBeth + Newey-West 만 → agent 가 "Bonferroni correction 도 보통 같이 하니까" → 자기 판단 추가
- 원저 cross-section regression 만 → agent 가 "industry FE 도 표준이니까" → 자기 판단 추가
- 원저 monthly returns 만 → agent 가 "daily 결과도 robustness 로 ..." → 자기 판단 추가

이런 silent-add 가 위험한 이유:
1. 학생이 발표에서 "왜 이 검정 추가했나?" 질문에 답 못 함 (본인이 결정 안 함)
2. 원저와 비교 시 어떤 결과가 원저 동등 검증인지 학생도 헷갈림
3. 결과 표 에 원저 외 추가 검정 결과까지 들어가 paper 의 "독립적 KR replication" 가치 훼손

→ **inventory + 구현 = 원저 명시 1:1 매칭 lock**.

## 3. 위반 패턴 (자동 검출 대상)

### 3.1 Silent substitute (Lock A 위반)

`manifest.json` 정의와 `code/` 구현 정의 불일치 — agent 가 자체 판단으로 substitute.

예: 원저 `BE/ME = book equity / market cap (fiscal-year-end)` 인데 code 가 `book equity / market cap (calendar-year-end)` 사용.

### 3.2 Silent drop (Lock A 위반)

`manifest.json` 항목 (methodology / test / robustness) 이 `code/` 에 매핑 없음.

예: 원저 §5.3 "Stambaugh bias correction" 인데 code 에 구현 없음.

### 3.3 Silent proxy (Lock A 위반)

KR 에 부분 가용 변수가 정확히 부재 명시 없이 proxy 로 구현됨.

예: 원저 IBES brokerage-level forecast std → fnguide aggregate `(E3 max-min)/2` 로 proxy. CheckExpert 라이선스 있는데 fnguide aggregate 사용한 경우 = silent proxy 위반 (`docs/checkexpert-howto.md` — KAIST 라이선스 available 이므로 CheckExpert 사용 의무).

### 3.4 Silent add (Lock B 위반 — 신설)

`code/` 안 method 가 `manifest.json` inventory 에 없음 — agent 자기 판단 추가.

예: 원저 paper 에 Bonferroni 언급 없는데 `code/replication/bonferroni.py` 가 작성됨. → 위반.

검출: `code/replication/` 안 모든 method file 의 main function ↔ `manifest.methodology_inventory` 와 `test_inventory` 와 `robustness_inventory` 의 entry 매칭. 매칭 없는 file = silent add.

## 4. Phase 2.5 verification gate 가 자동 검출

`docs/phase-2_5-verification.md` 가 위 4 종 패턴을 cross-check matrix 로 검출:

- Methodology coverage 표 — 원저 method ↔ KR 구현 매핑
- Variable mapping 표 — 원저 def ↔ KR 구현 def
- Test coverage 표 — 원저 test ↔ KR 구현 매핑
- Robustness coverage 표
- **Silent-add 검출 표** — code 안 method 가 manifest 에 없는 항목 list (Lock B 신설)

위반 발견 시:
- Lock A 위반 (substitute / drop / proxy) → `03_user_tasks.md` 에 escalation
  - MISSING 카테고리 → §4.1 Task M (지도교수 메일)
  - PARTIAL (CheckExpert / 다른 KR vendor 로 가능) → §4.2 fix (vendor 데이터 추가 + 구현 수정)
  - PARTIAL (자연스러운 KR replication 차원) → §4.3 transparent 보고 (sign-off X)
- Lock B 위반 (silent add) → 해당 method file 제거 또는 학생이 명시적으로 "추가하기로 결정함" 기록 + Phase 4 본문에 명시

## 4.1 MISSING 카테고리 — 지도교수 메일 (M task)

```
## Task M-N: 지도교수 메일 — <원저 X 변수/method 가 KR 에 부재>
- **상황**: <원저 §X 의 무엇이 KR 에 정확히 부재인지 + 부재 증거>
  - 검색: fnguide DataGuide variable search "..." → 결과 없음
  - 검색: CheckExpert variable search "..." → 결과 없음
  - 검색: KRX / DART / ECOS → 해당 변수 부재
  - 한국 학술 문헌 KCI / RISS → 본 변수 사용 KR paper 없음
- **agent 대안 후보 (2-3개)**:
  1. <대안 A: 어떤 KR 변수 / method / drop 등> — 장단점
  2. <대안 B>
  3. <대안 C: drop 후 limitation 으로 명시>
- **학생 의견**: (학생이 본 메일 보내기 전 본인 결정 작성)
- **메일 본문 draft**:
  ```
  안녕하세요 교수님,

  졸업논문으로 진행 중인 <paper title> 재현 작업 중,
  원저의 <변수/method> 가 한국 시장 데이터에서 부재함을 확인했습니다.

  부재 증거: <위 상황 요약>

  검토한 대안:
  1. <대안 A>
  2. <대안 B>
  3. <대안 C>

  본인 의견은 <대안 X> 가 적절하다고 봅니다. <사유>.

  교수님의 의견 부탁드립니다.

  감사합니다.
  ```
- **상태**: pending → 메일 보냄 → 답 받음 → done
```

## 4.2 PARTIAL (다른 KR vendor 가능) — fix task

CheckExpert 또는 다른 KR vendor (WiseFn / KRX / DART) 로 원저 동등 구현 가능한 경우 — agent 가 자동으로 해당 vendor 사용 + 구현 수정. user task escalation 만 (라이선스 확인 / 데이터 다운로드).

예: 원저 IBES brokerage-level forecast std → CheckExpert 의 brokerage-level forecast 사용. fnguide aggregate proxy 사용 금지 (CheckExpert 가 KAIST 라이선스 available).

## 4.3 PARTIAL (자연스러운 KR replication) — 자동 진행 + transparent 보고

다음 경우는 agent 자체 판단 + Phase 4 thesis 본문 §3 data / §4 method / §6 robustness / §7 discussion 에 transparent 명시. 별도 sign-off 또는 메일 불필요:

- **Sub-period 분할**: 원저의 sub-period (예: 1980-1999 / 2000-2009) 가 KR regime 와 align 안 됨 → KR regime (외환위기 / IMF / 가격제한폭 변경 / COVID 등) 으로 자동 재정의 + 본문 명시
- **Universe filter**: 원저 NYSE+AMEX+NASDAQ → KOSPI+KOSDAQ 보통주 (우선주 / ETF / REIT / SPAC 제외) — KR 시장 conventional choice, 본문 §3 명시
- **Industry 분류**: 원저 12 industry → KR 11 GICS sector (또는 fnguide CP10000500 Sector Code) — KR vendor 의 표준 분류, 본문 §4 명시
- **거래 calendar**: 원저 US trading day → KR 영업일 (한국 공휴일 반영) — 자명, 본문 명시 가능
- **Risk-free rate**: 원저 3-month T-bill → 한국은행 91일 통안증권 또는 91일 CD — KR 시장 standard

위는 KR replication 의 자연스러운 차원. 학생이 발표에서 "왜 KR 양식으로 변경?" 질문 받으면 본문 명시한 사유를 자기 입으로 설명 가능.

## 5. 학생 책임 — Phase 4 본문 명시 + Phase 3/5 self-test

agent 가 PARTIAL §4.3 자동 진행한 경우, 학생은 다음을 본인 책임으로 수행:
- Phase 4 thesis 본문 작성 시 해당 변경 사유 transparent 명시
- Phase 3 / Phase 5 self-test 의 Q&A 에서 "왜 KR 양식 X 로 변경?" 질문 답안 본인이 이해 + 설명 가능

발표에서 "왜 다른 양식으로 했나" 질문 받았을 때 학생이 답을 못 하면 → 해당 변경의 본문 명시가 부족했거나 학생 학습이 부족 → Phase 3 / 5 self-test 가 차단.

## 6. 이 lock 의 한계

본 lock 은 silent substitute / drop / proxy / add 4 종을 차단하지만, paper 의 핵심 가설 자체가 KR 에 적용 가능한지는 판단하지 못한다. 다음은 학생 + 지도교수 책임 (Phase 0 진입 전):

- KR 시장 특수성 (개인투자자 비중, 재벌 구조 등) 이 paper 가설의 mechanism 을 무효화하는지
- KR 시장의 sample size (universe 작음) 가 paper 의 통계적 power 를 보장하는지
- KR 의 기관 (KRX rule, 한국 금감원 regulation) 이 paper 가설 검증에 영향 주는지

위 항목은 Phase 0 feasibility (`00_feasibility.md`) §4 의 한계 섹션에 학생이 직접 작성. 본 lock 의 자동 검증 범위 외.
