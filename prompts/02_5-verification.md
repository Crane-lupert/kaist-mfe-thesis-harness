# Phase 2.5 — Implementation verification gate prompt

> Phase 2 의 agent task 모두 done 후. AGENTS.md + 00-05 thesis_state + `paper/converted/manifest.json` (또는 동등 inventory) + `code/` 안 실제 구현 내용 paste 됐다고 가정.

---

Phase 2.5 (Implementation verification gate) 진행. AGENTS.md §1 Phase 2.5 + `docs/phase-2_5-verification.md` 따라:

## Verification matrix 4 종 작성

### Methodology coverage

```
| # | 원저 method | KR 구현 위치 (code path:line) | 정의 일치 여부 | 상태 |
|---|---|---|---|---|
| 1 | <method name> | code/<path>:<line> | EXACT / PARTIAL / DROP | IMPLEMENTED / PARTIAL+signoff / MISSING+학생결정 |
```

### Variable mapping

```
| Variable | 원저 정의 | KR 구현 정의 | 일치 여부 | 상태 |
```

### Test coverage

```
| Test | 원저 section / page | KR 구현 위치 | 상태 |
```

### Robustness coverage

```
| Robustness | 원저 section | KR 구현 | 상태 |
```

## 자동 검출 rule 4 종 (Lock A 3 + Lock B 1)

### Silent substitute (Lock A)

`manifest` 정의와 `code/` 구현 정의 불일치 — agent 가 자체 판단으로 substitute. **위반 발견 → `03_user_tasks.md` 에 escalation 의무**.

### Silent drop (Lock A)

`manifest` 항목 (methodology / test / robustness) 이 `code/` 에 매핑 없음 — agent 가 자체 판단으로 drop. **위반 → escalation 의무** (MISSING 카테고리면 Task M 메일).

### Silent proxy (Lock A)

`00_feasibility.md` §3 PARTIAL 미명시 변수가 code 에서 proxy 로 구현됨. **위반 → escalation 의무**. CheckExpert KAIST 라이선스 available 변수를 fnguide aggregate proxy 로 대체한 경우도 위반.

### Silent add (Lock B — 신설)

`code/replication/` 안 method 가 `manifest` inventory 에 없음 — agent 가 "관례상" / "standard" 사유로 자기 판단 추가. 예: 원저 Bonferroni 언급 없는데 `bonferroni.py` 작성됨. **위반 → 해당 method 제거 또는 학생 명시 결정 + Phase 4 본문 명시 의무**.

## PASS 조건

다음 모두 충족 시 PASS:
- 4 matrix 모든 row 가 IMPLEMENTED OR (PARTIAL §4.3 + Phase 4 본문 명시 기록) OR (PARTIAL §4.2 + 다른 KR vendor 로 fix 완료) OR (MISSING + Task M 메일 답 받음 + 학생 결정 기록)
- Silent substitute / drop / proxy / **add** violation = 0 건 (4 종 lock)

PASS 시 `05_progress.log` 에 다음 entry append:

```
[YYYY-MM-DD HH:MM:SS] Phase 2.5 verification audit PASS.
  - Methodology coverage: <X / Y IMPLEMENTED, Z PARTIAL+signoff, W MISSING+drop>
  - Variable mapping: <...>
  - Test coverage: <...>
  - Robustness coverage: <...>
  - Silent violations: 0
  - Next: Phase 3 entry approved.
```

FAIL 시:
- 위반 항목 list
- `03_user_tasks.md` 에 분기 task append:
  - MISSING → Task M (지도교수 메일)
  - 다른 KR vendor 가능 → Task U (CheckExpert 등 다운로드)
  - 자연스러운 KR replication → Phase 4 본문 명시 의무 기록
  - Lock B silent-add → 해당 method 제거 또는 학생 명시 결정
- Phase 3 entry 차단 + Phase 2 재진입 권고

## 출력 형식

위 4 matrix + violation list (있으면) + PASS/FAIL 판정 + 05_progress.log append entry 의 markdown 출력. 학생이 copy → 저장.

## 의무 참조

- `docs/rigor-lock.md` — silent substitute / drop / proxy / **add** 의 long-form 정의 (Lock A 3 + Lock B 1) + §4 분기 양식 (MISSING 메일 / 다른 vendor fix / 자연스러운 자동 진행)
- `docs/phase-2_5-verification.md` — matrix 양식 + 4 종 검출 rule 상세
