# 한국 시장 특수성 (KR market quirks)

> US/EU 시장 기반 paper 를 KR 에서 재현할 때 학생·agent 가 사전 lock 해야 할 KR 시장 quirk 모음. AGENTS.md §3 Phase 0 feasibility 와 `01_methodology_map.md` 작성 시 의무 참조.

## 1. Universe (KOSPI / KOSDAQ / KONEX / ETF / 리츠 / SPAC)

- **KOSPI**: 거래소 본 시장. ~800 종목 (2025 기준).
- **KOSDAQ**: 코스닥 시장. ~1600 종목.
- **KONEX**: 코넥스 (소규모). 학술 연구에서는 보통 제외.
- **ETF / ETN**: KOSPI 내 별도 분류 — equity universe 에서 제외 (paper 재현 시 의무).
- **리츠 (REITs)**: 별도 산업 분류, real estate paper 에서만 inclusion.
- **SPAC**: 학술 연구 보통 제외 (operating firm 아님).

→ Universe 명시는 모든 paper 의 §3 Data 의 1차 lock. KOSPI-only vs KOSPI+KOSDAQ vs KOSPI+KOSDAQ+KONEX 어느 것인지 명확.

## 2. Ticker code convention (fnguide 기준)

- 보통주: `A` + 6자리 (예: `A005930` = 삼성전자 보통주)
- 우선주: 보통주 ticker + 우선주 suffix (예: `A005935` = 삼성전자 우선주)
- ETF: `A` + 6자리 (구분 어려움, vendor 메타데이터로 분기)
- KRX 직접 코드 (`005930.KS` 등) 와 fnguide 코드 (`A005930`) 변환 의무

## 3. 우선주 (Preferred shares) 처리

- KR 시장은 우선주가 보통주와 별도 ticker 로 거래 (US 와 다름).
- Replication 시 결정 사항:
  - (a) 보통주 only — 일반적 default. 단 시가총액 (`S410001200`) 정의가 보통주만인지 보통+우선 합산인지 확인.
  - (b) 보통+우선 결합 — 우선주 거래량·가격 다른 dynamics, equal-weight 또는 outstanding-weighted 통합.
- 외국인보유비중 (`S420001800`) 은 보통+우선 결합 — 보통주만 분석 시 분리 의무.
- 우선주 배당 정책 다른 경우 있음 (우선 배당률 + 차등 배당).

## 4. 상하한가 ±30%

- **현재 (2015-03-21 이후)**: ±30% 가격제한폭.
- **이전 변경 history** (재현 시 sub-period 분리 의무):
  - 1998-12-07 ~ 2015-03-20: ±15%
  - 1996-11-25 ~ 1998-12-06: ±12%
  - 1995-04-01 ~ 1996-11-24: ±6%
  - 1989 ~ 1995-03-31: ±4.6% (정액 한도)
- 영향:
  - 상한가 hit 종목의 일간 return 이 제한됨 → return distribution truncation
  - paper 의 t-stat / Sharpe 계산에 bias
  - sub-period 분석 시 가격제한폭 변경 명시 의무

## 5. 매매정지 / 관리종목 / 거래정지 / 상장폐지

- **관리종목 지정** (`S410002700` 의 관리구분): 재무 부실, 분기 / 연간 실적 미공시 등 사유. 회계 정보 신뢰성 ↓.
- **거래정지**: 공시 위반, 횡령·배임, 감사보고서 거절 등. 가격 데이터 null.
- **상장폐지**: 영구 제외. survivorship bias 주의 — 데이터 backup 시점 universe 가 폐지 종목 제외돼 있을 수 있음.
- **단주 매매**: 우선주 / 소형주 거래량 매우 적음 → liquidity proxy 의무.

## 6. 회계기준 (K-GAAP → K-IFRS)

- **K-IFRS 의무 도입**: 상장 대기업 2011 회계연도부터 단계적, 2013 부터 모든 상장사.
- **K-GAAP (2010 이전)** vs **K-IFRS (2011 이후)** 차이:
  - 영업이익 정의 (영업외손익 분류 변경)
  - 연결재무제표 우선 (개별재무제표 → 연결 기준)
  - 무형자산 / 영업권 인식 변경
- 6000* fnguide 재무제표 계정의 2010-2011 구간 일관성 없음 — sub-period 분리 또는 명시 disclaimer.

## 7. 결산일 / 회계 timing

- **12월 결산** (대부분, ~90%)
- **3월 결산** (일부 — 일본계 사업)
- **6월 결산** (일부)
- 컨센서스 발표 timing: 분기 실적 발표 후 보통 1-2주 lag, 연간 잠정 → 확정 → 컨센서스 update 의 multi-stage timing.
- fnguide `(E3)` (3-month consensus) 와 `(잠정)` 과 `(확정실적속보)` 의 timing 차이 paper 의 forecast revision study 에서 critical.

## 8. 5% 지분 공시 (DART)

- **공시 의무**: 1인 또는 우호 지분 합산 5% 초과 시 5영업일 안 공시.
- **변경 사유**: 신규 / 보유비율 1% 이상 변동 / 보유 목적 변경.
- 패시브 ( holding only) vs 액티브 (경영 참여) 구분.
- KR 의 13D/13G 동등물.
- Insider trading study 의 1차 데이터 source.

## 9. Sub-period regime 분리 (의무)

US/EU paper 와 다른 KR sub-period:
- **1989-1997**: 거래소 개방 초기 + 한국재벌 구조
- **1997-1998 외환위기 (IMF)**: structural break
- **1998-2007**: 회복기
- **2008-2009 글로벌금융위기**: structural break
- **2009-2019**: 안정 성장 (가격제한폭 30% 로 2015 확대)
- **2020-2021 COVID-19**: structural break + 개인투자자 ('동학개미') 폭증
- **2022-현재**: 금리 정상화 + 글로벌 인플레

paper 의 sub-period split 그대로 KR 에 적용하면 안 됨 — KR-specific regime 명시 의무.

## 10. Short-sale 제약

- **2008-10 ~ 2009-05**: 글로벌금융위기 short-sale 전면 금지
- **2020-03 ~ 2020-09**: COVID-19 short-sale 전면 금지 (6개월)
- **2020-09 ~ 2021-04**: 부분 금지 (KOSPI200 / KOSDAQ150 종목만 허용)
- **2023-11 ~ 2024-03**: 6개월 전면 금지 (개인 short-sale 제도 미비 사유)
- US/EU short-sale paper 의 KR 재현 시 sub-period 의무 + 금지 기간 separately 분석.

## 11. 외환 (USD/KRW) effect

- KR 시장의 외국인 투자자 비중 (~30-40%) 가 USD/KRW 환율에 민감.
- US paper 의 macroeconomic / monetary policy 효과 재현 시 USD/KRW 변수 추가 의무.
- 한국은행 ECOS API 로 환율 시계열 무료 접근.

## 12. 개인투자자 비중 (KR 특수)

- KR 시장 거래 60-70% 가 개인 (US 30% 와 대조).
- 2020 COVID 이후 '동학개미' 폭증으로 short-term momentum / overreaction 효과 강화.
- 정보 비대칭 / behavioral finance paper 재현 시 KR 시장 결과가 US 와 다를 가능성 높음 — discussion 섹션의 1차 해석 포인트.

## 13. 재벌 / 그룹 구조

- 대기업 그룹 (삼성·현대·SK·LG 등) 의 관계기업·지배구조 효과.
- 한국공정거래위원회의 ' 대규모기업집단' 지정 (자산 5조원 이상) — 매년 update.
- corporate governance paper 의 KR 재현 시 group dummy 추가 의무.

## 14. 단주 거래 / liquidity

- KOSDAQ 소형주 / 우선주 거래량 매우 적음 (일간 거래량 < 1억원 종목 다수).
- liquidity-based factor (Amihud illiquidity, Pastor-Stambaugh) 의 KR 적용 시 universe filter (예: 일평균 거래대금 ≥ 1억원) 의무.

## 15. 거래수수료 / 세금

- **증권거래세**: KOSPI 0.05% + 농어촌특별세 0.15% (총 0.2%, 매도 시), KOSDAQ 0.25% (매도 시)
- **양도소득세**: 대주주 (지분 1% 이상 또는 시가총액 50억 이상) 만 — 일반 paper 에서는 무시 가능.
- **거래수수료**: 증권사별 다름 (개인: ~0.015%, 기관: 협상 가능).
- backtest 시 transaction cost 명시 의무 — paper 의 net return 계산.

## 16. Settlement (T+2)

- KR 결제일: T+2 (2024 까지). T+1 전환 논의 중 (미국 2024-05-28 T+1 전환과 동기화 가능성).
- 매매 시점과 결제 시점 차이로 인한 corporate action timing 이슈 (배당락, 권리락) — fnguide 의 `수정주가` (`S410000700`) 와 `수정주가(현금배당반영)` (`S410007700`) 구분 의무.

## 17. KOSPI200 / KOSDAQ150 (trading universe)

- 실제 trading 가능 universe 가 작음 (KOSPI200 = 시총 상위 200 종목, KOSDAQ150 = 시총 상위 150 종목).
- 외인 / 기관 거래 비중 높음.
- paper 의 cross-section 가 KOSPI200 / KOSDAQ150 한정인지 전체 universe 인지 명시 의무.

## 18. 추가 confirm 의무 항목

학생이 본인 paper 작업 시 다음을 명시 확인:

- [ ] Paper 의 sample period 가 KR 의 어느 regime 인지 (위 §9)
- [ ] Paper 의 universe (가격 < $5 filter, top 80% market cap 등) 를 KR 에 어떻게 translate 하는지
- [ ] Paper 의 거래 frequency (daily / weekly / monthly) 와 KR 시장 거래일 calendar (한국 공휴일) 동기화
- [ ] Paper 의 risk-free rate 가 KR 에서 어느 시계열인지 (한국은행 기준금리 vs 91일 CD vs 91일 통안증권 etc)
- [ ] Paper 의 market portfolio 가 KR 에서 어떤 index 인지 (KOSPI vs KOSPI200 vs KOSPI+KOSDAQ 가중평균 etc)

위 항목 미확인 상태에서 Phase 1 진입 금지.

## 19. Macro / Bond / Economic 매칭 표 (US paper → KR equivalent)

session log 2026-05-30 evidence: 기업 단위 데이터 (재무·시장·수급) 는 fnguide / CheckExpert 로 잘 매칭. **macro / bond / economic indicator 는 매칭 fail 가능성 높음** — vendor 정의 차이 / KR market 의 vendor product 부재 / 시계열 시작 시점 부재. 본 §19 가 1차 mapping reference.

| US paper 변수 | KR equivalent | KR vendor / source | 주의 |
|---|---|---|---|
| **3-month T-bill (Risk-free)** | 91일 통안증권 또는 한국은행 기준금리 | ECOS (한국은행) | KR 1-month T-bill **미발행** — 91d CD 또는 91d 통안 사용 (§4.3 자연 KR replication) |
| **1-month T-bill** | 91일 통안 (KR proxy) | ECOS | 동상 |
| **3-month gov bond yield** | 91일 통안 또는 91일 CD | ECOS / KOFIA | |
| **2y / 5y / 10y gov bond yield** | 국고채 2년 / 5년 / 10년 | ECOS `시장금리:국고N년` | 시작 2000-11 (10y) — sample period 제약 |
| **10y gov bond total return** | 국고채총수익지수 | KIS Pricing / fnguide | TR index 사용, pct_change → monthly return |
| **AAA corp bond yield** | AAA 회사채 무보증 | KOFIA / ECOS `시장금리:회사채(무보증3년AAA)` | KR 등급 매핑: AAA / AA / A / BBB |
| **AAA corp bond total return** | 회사채 무보증 AAA TR index | KIS Pricing 채권총수익지수 | |
| **BAA corp bond yield (~BBB-)** | BBB 회사채 무보증 | KOFIA / ECOS | KR 등급 표기: AA-, A-, BBB- 등 dash 포함 가능 |
| **Default yield spread (BAA - AAA)** | BBB - AA 회사채 spread | ECOS 또는 derive | **§4.3 KR 등급 매핑 transparency 명시 의무** |
| **Default return spread (corp LT - gov LT TR)** | 회사채 TR - 국고채 TR | KIS Pricing | TR index 매칭 필요 |
| **Term spread (LTY - TBL)** | derived (10y 국고 - 91d 통안/CD) | ECOS | |
| **CPI / Inflation** | KR CPI YoY (소비자물가지수) | 통계청 KOSIS / ECOS / fnguide `200_소비자물가지수.xlsx` | 시작 1965, base year 2020 |
| **Core CPI** | KR core CPI (식료품·에너지 제외) | KOSIS | |
| **IP / Industrial Production** | 광공업동향조사 생산지수 (산업생산지수) | KOSIS `전산업생산지수` | **시계열 결측 가능 — 경기종합지수 (composite cyclical indicator) fallback** (§4.3 자연 KR replication, session log Turn 14 evidence) |
| **Unemployment rate** | 통계청 경제활동인구조사 실업률 | KOSIS / ECOS | |
| **GDP** | KR GDP (한국은행 분기) | ECOS | quarterly only |
| **Money supply (M1, M2)** | KR M1 / M2 / Lf | ECOS | |
| **NBER recession dates** | 통계청 경기순환 또는 KDI 경기국면 | KOSIS / KDI | KR 정의 다름 — official dating committee 없음 |
| **Crude oil (WTI)** | WTI 그대로 (글로벌) | EIA / FRED / fnguide `200_WTI.xlsx` | global commodity, KR 등가 X |
| **Brent oil** | Brent 그대로 (글로벌) | EIA / FRED | |
| **Exchange rate** | USD/KRW | ECOS / 한국은행 | KR-specific addition 가능성 (paper US 에 없음) |
| **VIX (US implied vol)** | KOSPI200 VKOSPI | KRX | KR VKOSPI 2003-01+ |
| **TED spread** | KR equivalent 없음 | — | **MISSING 가능성** → Task M |
| **CDS spread (sovereign)** | KR sovereign CDS | Bloomberg / 한국은행 | vendor 제약 |
| **NTIS (net equity expansion)** | KR derive (유상증자 + IPO - 자사주매입) | DART OpenDART API | DART event-based aggregation 필요 |

### 19.1 매칭 fail 시 표준 대응 절차

원저 macro/bond/econ 변수가 KR 에 정확히 매칭 없을 때:

1. **Definition 차이 확인**: paper 의 변수 정의 (예: "10y gov bond yield, monthly average") 를 KR vendor 문서와 비교. 정의 일치하면 KR vendor 시계열 그대로 사용.
2. **시계열 시작 차이**: KR vendor 시작이 paper sample 보다 늦으면 sample period 단축 (예: 국고채 10y 시작 2000-11 → paper 1990 sample 사용 불가).
3. **Vendor product 부재**: KR 에 동등 vendor product 없음 → §4.3 자연 KR replication 가능한지 (예: 91d 통안 → 1m T-bill proxy) 또는 MISSING.
4. **Composite indicator fallback**: 정확 KR equivalent 부재 시 composite indicator (예: 경기종합지수 → US IP proxy) 사용 가능. Phase 4 본문 transparency disclosure 의무.
5. **MISSING 확정 시 Task M (지도교수 메일)** — `docs/rigor-lock.md` §4.1.

### 19.2 흔한 silent proxy 패턴 (Lock A 위반 위험)

- 원저 "T-bill rate" → KR "기준금리" 임의 사용 (KR 기준금리는 정책 금리, T-bill 과 다름)
- 원저 "long-term gov bond" → KR "국고 3년" 임의 사용 (paper "long-term" 보통 10y 이상)
- 원저 "default spread (BAA-AAA)" → KR "AA-A spread" 임의 사용 (KR BBB 등급 데이터 시작 시점 확인 필요)
- 원저 "term spread" → KR "10y - 91d CD" vs "10y - 3y" 차이 (paper 정의 정확 확인)
- 원저 "industrial production" → KR "전산업생산지수" 결측 → "경기종합지수" 사용 시 **명시 의무** (자의 substitute → silent proxy 위반)

위 패턴 모두 Phase 1.5 existing-implementation audit (`AGENTS.md` §4.5) 또는 Phase 2.5 verification gate 가 검출. 학생 prior code 안 위 substitute 발견 시 paper-faithful 로 재계산.
