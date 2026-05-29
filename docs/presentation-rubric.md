# 발표 평가 rubric (Phase 3 mid + Phase 5 final)

> Phase 3 (중간 발표) 와 Phase 5 (final defense) 의 평가 기준. agent 의 self-test gate (8/10 / 9/10) 와 Q&A 생성의 입력.

## 1. 공통 평가 차원 (5종)

### 1.1 원저 이해도

학생이 paper 의 motivation / hypothesis / contribution 을 자기 말로 설명 가능한가.

- ⭐⭐ (낮음): paper 의 abstract 만 외움. mechanism 이해 부족.
- ⭐⭐⭐ (보통): paper 의 main result 와 contribution 1줄 설명 가능.
- ⭐⭐⭐⭐ (좋음): paper 의 핵심 가설 + underlying economic mechanism 자기 말로 설명 가능.
- ⭐⭐⭐⭐⭐ (탁월): paper 의 한계 + 후속 연구 방향까지 본인 의견 보유.

### 1.2 데이터 + KR 시장 특수성 이해

- ⭐⭐: vendor 이름만 나열 (fnguide / CheckExpert).
- ⭐⭐⭐: universe + sample period + 데이터 cleaning 설명 가능.
- ⭐⭐⭐⭐: KR 시장 특수성 (우선주·상하한가·sub-period regime 등) 을 paper 결과 해석에 연결 가능.
- ⭐⭐⭐⭐⭐: KR 의 어떤 quirk 가 paper 의 어느 결과를 변화시키는지 정량·정성 설명.

### 1.3 방법론 충실도

- ⭐⭐: 원저 method 이름만 나열.
- ⭐⭐⭐: 원저 method 의 각 step 을 자기 말로 설명 가능.
- ⭐⭐⭐⭐: 원저 method 와 KR 적용 시 차이 (lag length / standard error 종류 / sub-period 분할) 명시 + 사유 설명.
- ⭐⭐⭐⭐⭐: 원저 method 의 한계 + KR 에서 다른 method 가 더 적절할 가능성 본인 의견.

### 1.4 결과 해석

- ⭐⭐: 통계 표 읽기만.
- ⭐⭐⭐: 통계적 유의성 vs 경제적 유의성 구분 가능.
- ⭐⭐⭐⭐: 원저 결과와 KR 결과 차이를 KR 시장 특수성으로 해석 가능.
- ⭐⭐⭐⭐⭐: 본 연구의 함의 (실무·정책·후속 연구) 본인 의견.

### 1.5 한계 + 후속 연구

- ⭐⭐: "한계는 없습니다" (즉시 실패).
- ⭐⭐⭐: 1-2 한계 명시 (sample size / period 등 obvious).
- ⭐⭐⭐⭐: 3-5 한계 명시 + 각 한계가 결과에 어떻게 영향을 미치는지 설명.
- ⭐⭐⭐⭐⭐: 한계 명시 + 그 한계를 극복하는 후속 연구 design 본인 의견.

## 2. Phase 3 (mid) vs Phase 5 (final) 차이

| 평가 차원 | Phase 3 통과 threshold | Phase 5 통과 threshold |
|---|---|---|
| 원저 이해도 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 데이터 + KR 특수성 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 방법론 충실도 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 결과 해석 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 한계 + 후속 연구 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **자기 self-test threshold** | **8/10** | **9/10** |

Phase 3 = "발표 통과 가능" 수준 (⭐⭐⭐ 평균).
Phase 5 = "방어 가능 + 후속 방향 제시" 수준 (⭐⭐⭐⭐ 평균).

## 3. 자주 받는 질문 카테고리 (Q&A 생성용 입력)

### 3.1 Methodology 질문

- 원저 lag length / standard error 종류 / Bonferroni m 의 KR 적용 시 결정 사유?
- 원저 fixed effect (firm / industry / time) 의 KR 적용 시 적정 분류?
- 원저 rolling window 의 KR 적용 시 적정 width?

### 3.2 Data 질문

- universe 결정 사유? (KOSPI only / +KOSDAQ / +KONEX)
- 우선주 / ETF / REIT / SPAC 처리?
- 상하한가 hit 종목 처리?
- 매매정지 / 관리종목 처리?
- IFRS 도입 전후 sub-period?

### 3.3 Results 질문

- 원저보다 effect size 작은 / 큰 이유?
- 통계적 유의성과 경제적 유의성 관계?
- OOS 결과의 해석?
- 거래 비용 net 결과?

### 3.4 KR 시장 해석 질문 (가장 어려움)

- 개인투자자 비중이 결과에 어떻게 영향?
- 재벌 구조가 결과에 어떻게 영향?
- short-sale 제약이 결과에 어떻게 영향?
- 외환 (USD/KRW) effect 처리?
- 본 결과를 다른 EM (대만 / 일본 / 중국) 에 일반화 가능?

### 3.5 후속 연구 방향

- 본 연구 확장 가능성?
- 실무적 함의 (trading strategy 로 가져갈 수 있나)?
- 본 결과 한계 극복 후속 design?

## 4. Phase 3 / Phase 5 deck 구조 권장

### Phase 3 — 5분 deck (8-10 슬라이드)

1. Title + motivation (1-2 슬라이드)
2. 원저 core (1-2 슬라이드)
3. KR 시장 특수성 (1 슬라이드)
4. 데이터 + 방법론 (1-2 슬라이드)
5. 잠정 결과 (1-2 슬라이드)
6. 한계 + 다음 단계 (1 슬라이드)

### Phase 5 — 20-30분 deck (20-30 슬라이드)

자세히 → `docs/phase-5-defense.md` §2.

## 5. 자주 받는 forensic 질문 (Phase 5 만)

심사위원회의 forensic 질문 대비:

- "이 결과가 noise 가 아니라는 걸 어떻게 증명?"
- "본인 method 가 원저와 다른데 그것이 main result 에 영향?"
- "왜 robustness X 를 안 했나? 그것이 main result 를 무효화 가능?"
- "본인 paper 가 새로운 contribution 인가, 단순 replication 인가?"
- "본인 paper 의 결과를 본인이 직접 trading 한다면 어떻게?"
- "본 결과가 publication 가능한 수준인가? 어느 저널?"

위 질문에 학생이 정직하게 ("모르겠습니다" 포함) + 후속 연구 방향 으로 답하는 게 핵심. 거짓말 / 회피 = 즉시 실패.
