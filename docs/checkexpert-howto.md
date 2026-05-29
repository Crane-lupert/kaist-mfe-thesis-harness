# CheckExpert (체크엑스퍼트) 사용 가이드

> **KAIST 라이선스 available (confirmed)** — KAIST 경영대학 / 도서관 라이선스로 자유 접근. 학생이 본인 라이선스 사용 가능 확인.

## 1. CheckExpert 가 무엇인가

WiseFn 산하 KR 시장 데이터 vendor. fnguide DataGuide 와 같은 회사 (WiseFn 그룹) 의 다른 product. 주력:

- **컨센서스** (analyst forecast) 의 **brokerage 별 detail**
- **추정치 history** (consensus revision tracking)
- **Recommendation 변화** (buy / hold / sell rating 시계열, brokerage 별)
- **목표주가 (target price)** revision

fnguide 의 `F730*` / `F752*` 계열이 컨센서스 **aggregate** (mean / max / min / median / std) 라면, CheckExpert 는 **brokerage-level detail** — 즉 각 증권사의 individual estimate / recommendation 시계열.

## 2. 데이터 family

KAIST 라이선스 web 인터페이스 또는 일부 학교는 API 제공. 학생이 본인 환경에서 정확한 export 형식 확인.

주요 변수:
- **Brokerage-level EPS forecast** (각 증권사 EPS 추정치, daily/weekly time series)
- **Brokerage-level sales forecast**
- **Brokerage-level operating income forecast**
- **Brokerage-level net income forecast**
- **Target price** (brokerage 별, revision event 포함)
- **Recommendation rating** (Strong Buy / Buy / Hold / Sell / Strong Sell, brokerage 별)
- **Forecast revision event** (각 brokerage 의 revision timestamp + 직전·신규 estimate)
- **Earnings announcement date** (실적 발표 일자, conference call 일정 포함)

## 3. fnguide 와 차이 / 보완

| 차원 | fnguide 컨센서스 (`F730*`) | CheckExpert |
|---|---|---|
| Granularity | aggregate (mean / median / max / min) | brokerage-level detail |
| Revision tracking | 1W / 1M / 3M / 6M Chg | 모든 forecast revision event (timestamp 단위) |
| Dispersion 분석 | aggregate (max-min) 또는 (1) | brokerage 별 std / dispersion measure 직접 계산 |
| Recommendation | 투자의견점수 (aggregate, F730*) | brokerage 별 rating change history |
| Forecast lead-lag | aggregate revision | brokerage 별 lead-lag 분석 가능 |

**핵심**: Paper 가 brokerage-level forecast dispersion / individual analyst behavior / herding 을 다룬다면 CheckExpert 필수. KAIST 라이선스 available 이므로 fnguide aggregate proxy 사용 금지 — silent proxy 위반 (`docs/rigor-lock.md` §3.3).

## 4. 학생 task escalation 예시

```
## Task U-N: CheckExpert 에서 brokerage-level EPS forecast 다운로드
- **왜 필요한가**: paper §X 의 analyst dispersion measure. 원저 IBES brokerage-level std → KR CheckExpert 동등.
- **무엇을 해야 하나**:
  1. KAIST 도서관 / 경영대학 → 경영·금융 DB → CheckExpert 라이선스 로그인
  2. 종목 선택 → KOSPI + KOSDAQ universe
  3. 변수: Analyst EPS forecast (brokerage-level detail)
  4. Term: <YYYYMMDD ~ YYYYMMDD>
  5. Export → CSV → `data/raw/checkexpert/eps_forecast_brokerage.csv`
- **완료 검증**: 파일 존재 + brokerage column (증권사명 또는 ID) 확인 + N_estimate > 10000.
- **막혔을 때 대안**: 라이선스 web 인터페이스 안 안 되면 KAIST 도서관 사서 문의. (라이선스 자체는 available.)
- **상태**: blocked
```

## 5. 본 doc 의 한계 (학생 보완)

- KAIST 라이선스 web 인터페이스 UI / export format 은 학교 라이선스 갱신에 따라 변경 가능
- 변수명 한·영 표기 KAIST 라이선스 시점 기준
- 학생이 본인 환경 확인 후 본 doc 또는 `02_data_inventory.md` 의 CheckExpert 섹션에 정확한 변수명·접근 절차 보완 권장
- 다른 학교 (서울대 / 연세대 등) 학생 사용 시 본교 라이선스 확인 — KAIST 외에는 라이선스 보장 없음
