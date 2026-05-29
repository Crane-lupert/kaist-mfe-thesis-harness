# thesis_state/ — 4-phase cross-tool baton

이 디렉토리는 agent 의 phase 산출이 누적되는 곳. **cross-tool baton** — 학생이 AI 툴을 바꿔도 (Claude Code → Cursor → Codex CLI 등) 다음 세션이 그대로 이어받음.

학생이 직접 편집 가능 (예: tool detection 잘못되면 `tool.json` 수동 교정).

## 파일 매핑 (10 종)

| 파일 | Phase | 산출 시점 | 내용 |
|---|---|---|---|
| `tool.json` | P0 detection | 첫 세션 | 감지된 AI 툴 + capabilities |
| `00_feasibility.md` | P0 | Phase 0 완료 | KR 가용성 + 한계 분석 |
| `01_methodology_map.md` | P1 | Phase 1 | 원저 ↔ KR 매핑 |
| `02_data_inventory.md` | P1 | Phase 1 | 필요 데이터 list + 라이선스 가용성 |
| `03_user_tasks.md` | P1, P2, ... | append-only | 학생 직접 작업 list (단계마다 추가) |
| `04_agent_tasks.md` | P1 | Phase 1 | agent autopilot task list |
| `05_progress.log` | P2, P2.5 | append-only | 진행 로그 + verification audit marker |
| `06_presentation.md` | P3 | Phase 3 | 중간 발표 deck + Q&A + self-test |
| `07_thesis_draft/` | P4 | Phase 4 | sub-tree — 10 section .md + figures + references.bib |
| `08_build.log` | P4 | Phase 4 final build | latexmk / pandoc build 로그 |
| `09_defense.md` | P5 | Phase 5 | final defense deck + Q&A + audit |

## Frontmatter 의무 (markdown 파일)

각 markdown 파일 상단:

```yaml
---
last_updated: YYYY-MM-DD
current_phase: P0 | P1 | P2 | P2.5 | P3 | P3-PASS | P4 | P4-final | P5 | P5-PASS
next_action: <한 줄>
---
```

## 학생이 직접 편집 가능

- `tool.json` — detection 잘못된 경우 수동 교정
- `03_user_tasks.md` — task `상태: blocked → done` 갱신 (학생이 task 완료 후)
- `student_notes.md` (paper/) 또는 본 디렉토리 의 frontmatter `next_action` — 학생 우선순위 변경 시

## .gitignore 와 관계

본 디렉토리의 산출 파일들은 `.gitignore` 에 등록 → public template repo 에는 commit 안 됨 (학생 본인 작업물 보호). 학생이 본인 thesis private repo 에 commit 하려면 `.gitignore` 수정.
