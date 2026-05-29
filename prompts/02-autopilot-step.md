# Phase 2 — Execution (1 task per turn) prompt

> 본 prompt 는 web AI 의 step-trigger 용 — 1 turn 에 agent task 1개씩 진행.
> 이미 conversation 에 AGENTS.md + 00-04 thesis_state 파일 paste 됐다고 가정.

---

Phase 2 (Execution) 진행. AGENTS.md §5 따라 `04_agent_tasks.md` 에서 task 1개 선택 + 진행.

## Task 선택 rule

1. `04_agent_tasks.md` 의 task 중 `상태: todo` + 의존성 충족 (모든 dependency 가 `done`) 인 첫 task 선택.
2. 의존성에 user task (`03_user_tasks.md` U-N) 가 있는데 그 task `상태: blocked` 면 skip + 다음 독립 task.
3. 모든 task done / blocked / 의존성 미충족 이면 Phase 2.5 verification gate 진입 권고.

## 진행 절차

선택한 task 의 산출 (코드 / 테스트 / 결과 표 / 차트 등) 을 markdown 으로 출력. 학생이 본인 로컬에 저장 + 실행.

코드 출력 시 다음 형식:

````markdown
## Task A-N 진행 — <task 제목>

### 산출 파일 1: `code/<path>/<file>.py`

```python
# <짧은 docstring — 이 코드의 목적, 의존 데이터, 출력>
import pandas as pd
...
```

### 산출 파일 2: `code/<path>/<test>.py` (의무 — 단위 테스트)

```python
import pytest
from ... import ...

def test_<name>():
    ...
```

### 실행 절차

학생이 본인 로컬에서:
1. 위 코드 저장
2. `pytest code/<path>/<test>.py` 실행 → PASS 확인
3. 실제 데이터 (`data/raw/<file>.csv`) 가 있으면 main script 실행

### 결과 검증

[기대 결과 명시 — 예: t-stat 범위, Sharpe 범위, 표 모양]

### `05_progress.log` append 항목 (학생이 추가)

```
[YYYY-MM-DD HH:MM:SS] Task A-N done.
  - Output: code/<path>/<file>.py
  - Test: code/<path>/<test>.py PASS
  - Result: <한 줄 요약>
```

### `04_agent_tasks.md` 상태 갱신

Task A-N 의 `상태: todo` → `done`.
````

## 만약 user-blocking 만나면

AGENTS.md §6 escalation 양식으로 `03_user_tasks.md` 에 task append + Task A-N 의 `상태: todo` → `blocked` (의존성 추가) + 다음 task 선택 권고.

## Faithful lock §8 점검

진행 중 원저 method / variable / robustness 와 다른 결정이 필요하면 즉시 stop + `03_user_tasks.md` 에 sign-off task escalation (`docs/rigor-lock.md` §5 양식).

## 완료 후

다음 turn 에 학생이 본 prompt 를 다시 paste 하면 다음 task 진행.
