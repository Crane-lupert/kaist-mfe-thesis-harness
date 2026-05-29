# Phase 1 — Replication planning prompt

> 이미 conversation 에 AGENTS.md + paper + `thesis_state/00_feasibility.md` paste 됐다고 가정.

---

Phase 0 완료. 지금 Phase 1 (Replication planning) 진행. AGENTS.md §4 따라 다음 4 종 산출.

## Task 1.1 — `thesis_state/01_methodology_map.md`

원저 method · variable ↔ KR 데이터 column 매핑 표. 00_feasibility.md §2 의 inventory + §3 의 가용성 표 를 입력으로:

```
| # | 원저 method / variable | 정의 | KR 매핑 (fnguide item code 또는 KR vendor) | 정의 일치 여부 (EXACT / PARTIAL / PROXY) | 출처 (docs/fnguide-dictionary.md §X) |
```

PARTIAL / PROXY 인 경우 처리 분기 (`docs/rigor-lock.md` §4):
- §4.2 (CheckExpert 또는 다른 KR vendor 로 fix 가능) → 학생 task U (라이선스 / 다운로드)
- §4.3 (자연스러운 KR replication 차원) → agent 자동 진행 + Phase 4 본문 명시 의무
- §4.1 MISSING → Task M (지도교수 메일) escalation

## Task 1.2 — `thesis_state/02_data_inventory.md`

필요 raw 데이터 list + 학생 라이선스 접근 가능 여부:

```
| Variable | 원저 vendor | KR vendor (fnguide / CheckExpert / KRX / DART / ECOS) | 학생 라이선스 가능 (yes/no/확인필요) | Export 절차 (학생 task 로 escalation 시 03_user_tasks.md 참조) |
```

## Task 1.3 — `thesis_state/03_user_tasks.md`

학생이 직접 해야 할 작업 list. AGENTS.md §6 escalation 양식:

```
## Task U-N: <한 줄 제목>
- **왜 필요한가**: <context>
- **무엇을 해야 하나**: <step-by-step, 화면·메뉴·클릭·저장 위치까지>
- **완료 검증**: <어느 파일이 어디에 어떤 형태로>
- **막혔을 때 대안**: <fallback>
- **상태**: blocked
```

일반적인 user task (`AGENTS.md` §6.1 양식):
- fnguide / CheckExpert (KAIST 라이선스 available) 데이터 export
- API 키 발급 (OpenDART / 한국은행 ECOS / arXiv / SSRN)
- 학과 양식 입수 (Phase 4 의 deferred → final 전환 trigger)

지도교수 메일 task (`AGENTS.md` §6.2 양식, Task M) — **MISSING 카테고리일 때만**:
- 원저 변수 / method 가 KR 에 정확히 부재 (검색 + vendor 문서 + 학술 문헌 확인 후)
- agent 가 대안 후보 2-3개 + 학생 의견 + 메일 본문 draft 작성
- 학생이 메일 보내고 답 받기

## Task 1.4 — `thesis_state/04_agent_tasks.md`

agent autopilot task list (의존성 표시):

```
## Task A-N: <한 줄 제목>
- **목적**: <어느 paper section / 어느 가설 검증>
- **의존성**: <필요 raw 데이터 / 선행 task A-M>
- **산출**: <code path / 결과 파일 위치>
- **검증**: <unit test / sanity check>
- **상태**: todo | in-progress | done | blocked
```

## Task split rule (AGENTS.md §4)

- **Agent task**: 코드 / 테스트 / 회귀 / 검정 / robustness sweep / 차트 / draft
- **User task**: 라이선스 / export / API 키 / 결제 / 실물 자료 / 지도교수 컨펌

애매하면 user task (over-escalation fail-secure).

## 출력 형식

위 4 종 산출의 markdown 내용을 차례로 출력. 학생이 copy → 각각 `thesis_state/01_methodology_map.md` / `02_data_inventory.md` / `03_user_tasks.md` / `04_agent_tasks.md` 에 저장.

## 완료 후

Phase 2 (Execution) 진입 권고 + user task 우선순위 1-2개 안내.
