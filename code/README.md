# code/ — 학생 + agent 코드

본 디렉토리에 agent 가 Phase 2 (Execution) 에서 작성하는 코드 + 학생이 직접 작성하는 helper 코드.

## 권장 구조 (agent 가 자동 생성)

```
code/
├── etl/                        # 데이터 추출 / 변환 / 로딩
│   ├── fnguide_loader.py       # fnguide CSV → pandas
│   ├── universe.py             # KOSPI / KOSDAQ universe filter
│   ├── corporate_action.py     # 수정주가 / 액면분할 / 무상증자 처리
│   └── ...
├── factors/                    # factor 구성
│   ├── bm_ratio.py
│   ├── momentum.py
│   └── ...
├── replication/                # 원저 method 재현
│   ├── fama_macbeth.py
│   ├── newey_west.py
│   ├── subperiod.py
│   ├── multiple_test.py        # Bonferroni / FDR
│   ├── robustness.py
│   └── ...
├── analysis/                   # main analysis script
│   ├── main_table_2.py         # 원저 Table 2 재현
│   ├── main_figure_1.py
│   └── ...
└── tests/                      # 단위 테스트 (의무)
    ├── test_etl.py
    ├── test_factors.py
    ├── test_replication.py
    └── ...
```

## 단위 테스트 의무 (Phase 2 autopilot loop)

각 agent task 의 산출 = (코드 .py) + (테스트 .py). `pytest tests/` 통과 후만 task `상태: done`.

## 데이터 위치

코드는 `data/raw/<vendor>/<file>.csv` 형식의 raw 데이터를 가정. 학생이 vendor (fnguide / CheckExpert) 에서 export 후 이 위치에 저장 — agent 가 자동 다운로드 안 함.

`data/` 디렉토리는 `.gitignore` 등록 (vendor 라이선스 보호).

## 코딩 스타일

- Python 3.11+
- pandas / numpy / statsmodels / scipy 표준 stack
- 옵션: polars (대용량 pandas 대체)
- linter: ruff
- formatter: black 또는 ruff format
- type hint 권장 (pyright 또는 mypy)

## 의무 참조

- `docs/rigor-lock.md` §3 — silent substitute / drop / proxy 금지
- `docs/phase-2_5-verification.md` — Phase 2 끝나면 verification gate
