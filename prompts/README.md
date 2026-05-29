# prompts/ — Web 사용자 (ChatGPT / Gemini) 용 단발 prompt

본 디렉토리의 prompt 들은 **shell 사용 불가능한 AI 툴 (ChatGPT 웹 / Gemini 웹)** 학생용 fallback. Claude Code / Codex CLI / Cursor 사용자는 자동 skill / agent 가 phase trigger 하므로 본 디렉토리 사용 불필요.

## 사용법

1. 학생이 ChatGPT (또는 Gemini) 웹 새 conversation 시작.
2. 다음 컨텍스트 paste:
   - `AGENTS.md` 전체 (한 번만 paste 후 conversation 안에서는 reuse)
   - `paper/student_notes.md` (있으면)
3. 진행할 phase 의 prompt 파일 (예: `prompts/00-feasibility.md`) 내용을 paste.
4. agent 응답에서 산출 파일 (`thesis_state/00_feasibility.md` 등) 내용 copy → 학생이 본인 로컬에 저장.
5. 다음 phase prompt 로 진행.

## Phase 별 prompt 매핑

| Phase | Prompt 파일 |
|---|---|
| P0 Feasibility | `00-feasibility.md` |
| P1 Planning | `01-planning.md` |
| P2 Execution (1 task 씩) | `02-autopilot-step.md` |
| P2.5 Verification | `02_5-verification.md` |
| P3 Mid-presentation | `03-prof-rehearsal.md` |
| P4 Thesis section drafting | `04-thesis-section.md` |
| P5 Defense | `05-defense-rehearsal.md` |

## 한계

- 웹 AI 는 file 직접 write 불가 → 학생이 산출 copy-paste 로 저장.
- Phase 0.5 PDF → MD 변환은 학생이 본인 로컬에서 `marker_single` 또는 `docling` 실행 후 산출 paper.md 를 agent 에 paste 해야 함.
- Phase 2 의 코드 실행도 학생이 본인 로컬에서 실행 후 결과 paste.
- Overnight autopilot 불가 — phase 단계마다 학생이 trigger.

웹 AI 사용 시 turn-around 가 느려서 졸업논문 작성 wall-clock 이 길어진다. Claude Code 또는 Codex CLI 무료 / 학생 라이선스 있으면 그 쪽 강력 권장.
