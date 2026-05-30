# Onboarding — 5분 시작 가이드 + FAQ

> 처음 본 repo 를 받은 KAIST FE 학생을 위한 가이드.

## 1. 5분 시작

### Step 1 (1분) — repo 생성

GitHub Template 으로 본인 thesis repo 생성:

```bash
gh repo create my-thesis --template <owner>/kaist-mfe-thesis-harness --private
cd my-thesis
```

GitHub CLI 없으면 GitHub 웹에서 "Use this template" 버튼.

### Step 2 (1분) — paper + (선택) 데이터 경로 투입

재현할 원저 paper 의 PDF 를 `paper/` 디렉토리에 그대로 저장 (**파일명 rename 불필요**):

```bash
cp ~/Downloads/some-jf-paper.pdf paper/
# 예: paper/JFE_2024_paper_title.pdf 그대로
```

agent 가 `paper/*.pdf` 자동 감지. 여러 PDF 있으면 어느 것을 쓸지 물어봄.

선택: `paper/student_notes.md` 에 본인 관심사·이미 본 자료 작성 (생략 가능).

선택: 본인 보유 raw 데이터가 기본 `data/raw/` 외 다른 디렉토리에 있으면 (예: `D:\my_kaist_data`, `E:\fnguide_backup`), Step 4 첫 입력 시 agent 에게 알려주기. agent 가 multi-path probe + shallow parsing 후 Phase 1 매핑 입력으로 사용.

### Step 3 (1분) — AI 툴 열기

본인이 사용하는 AI 코딩 툴 열기:

- **Claude Code** (CLI 또는 IDE 확장) — 강력 권장 (autopilot + skill auto-invocation)
- **Codex CLI** (OpenAI) — 강력 권장 (autopilot)
- **Cursor** — step-trigger
- **Antigravity** (Google) — step-trigger
- **ChatGPT 웹 / Gemini 웹** — `prompts/` 디렉토리 paste

### Step 4 (1분) — 첫 입력

Claude Code / Codex / Cursor / Antigravity:

```
Read AGENTS.md and start Phase 0.
```

ChatGPT 웹 / Gemini 웹:
1. `AGENTS.md` 전체 paste (한 번만)
2. `prompts/00-feasibility.md` 내용 paste

### Step 5 (1분) — 결과 확인

agent 가 `thesis_state/00_feasibility.md` 작성. 학생이 검토 후 Phase 1 진입 결정.

## 2. 첫 turn 예시 대화 (Claude Code)

```
사용자: Read AGENTS.md and start Phase 0.

Claude: AGENTS.md 와 docs/phase-0-paper-ingestion.md 읽었습니다.

먼저 tool detection 실행.
[bash] pwsh tool-routing/detect.ps1
> Detected tool: claude-code
> Capabilities: overnight-autopilot, skills, todowrite, bash, edit
> Written to: thesis_state/tool.json

paper/original.pdf 존재 확인. ✓
paper/student_notes.md 존재 확인. ✓ (또는 부재 — agent 가 학생에게 student_notes 작성
권장 여부 물어볼 수 있음)

Phase 0.1 시작 — PDF → MD 변환 (marker-pdf default).

[bash] python -c "import marker; print(marker.__version__)"
> ModuleNotFoundError: No module named 'marker'

marker-pdf 미설치. fallback chain 시도.

[bash] python -c "import docling; print(docling.__version__)"
> ModuleNotFoundError

docling 미설치. PyMuPDF 시도.

[bash] python -c "import fitz; print(fitz.__version__)"
> 1.24.0

PyMuPDF 사용 가능. 단, 수식·표 손실 큼.
03_user_tasks.md 에 marker-pdf 또는 docling 설치 권고 task append.
PyMuPDF 로 우선 진행.

[진행 중...]
```

## 3. FAQ

### Q: AI 툴 없는데?

- Claude Code: https://docs.claude.com/claude-code/overview — 무료 tier 가능
- Codex CLI: OpenAI API key 필요 (paid)
- Cursor: 무료 tier 가능, paid 추천
- ChatGPT 웹: 무료, 단 slow + 직접 file 저장 불가 (copy-paste 작업)

학생 라이선스 / 학교 단체 라이선스 확인 권장.

### Q: paper PDF 가 한국어 paper 인데?

`docs/phase-0-paper-ingestion.md` §1.3 — docling 이 한국어 PDF 처리 더 안정적. agent 가 자동으로 docling 우선 선택.

### Q: 학과 양식이 LaTeX 인데 본인 LaTeX 모름

문제 없음. agent 가 양식 받으면 자동으로 fill (`docs/phase-4-thesis-writing.md`). 학생은 양식 file 만 drop in 하면 됨. build 시 LaTeX 환경 설치 필요 → agent 가 `03_user_tasks.md` 에 설치 가이드 자동 작성.

### Q: fnguide / CheckExpert 라이선스 없는데?

학생 본인 책임. 학교 도서관 라이선스 확인. 라이선스 없으면 본 harness 사용 한계 (대부분 paper 가 fnguide 류 데이터 필요).

### Q: agent 가 데이터 자동으로 다운로드?

❌ NO. 라이선스 / 보안 사유로 agent 가 vendor 데이터 직접 다운로드 금지. agent 는 `03_user_tasks.md` 에 다음과 같이 학생 task 로 escalation:

```
## Task U-N: fnguide 에서 수정주가 다운로드
- 어느 사이트 / 어느 메뉴 / 어떤 변수 선택 / 어디에 저장 — step-by-step 명시
```

학생이 위 task 수행 후 데이터 저장하면 agent 가 그 이후 작업 진행.

### Q: 데이터 라이선스 위반?

학교 라이선스 범위 안에서 본인 thesis 작업만 사용 가능. 데이터 자체를 본인 thesis repo 에 commit 하면 라이선스 위반 가능 — 본 harness 의 `.gitignore` 가 `data/` 폴더 자동 제외. 데이터는 본인 로컬에만 보관 권장.

### Q: 지도교수에게 언제 보고/문의?

기본 원칙 — **MISSING 카테고리 (원저 X 가 KR 에 정확히 부재) 일 때만 메일 보내기**. 그 외는 agent 자체 진행.

구체적:
- `AVAILABLE` (원저 X 의 KR 동등 변수 / method 존재) → agent 자동 진행, 보고 불필요
- `PARTIAL §4.3 자연스러운 KR replication` (sub-period KR regime / 우선주 처리 / KR industry 분류 등) → agent 자동 진행 + Phase 4 thesis 본문 transparent 명시. 별도 보고 불필요
- `PARTIAL §4.2 다른 KR vendor 가능` (예: CheckExpert 사용 시) → agent 자동 진행 + 학생이 라이선스 / 데이터 다운로드 task
- **`MISSING`** (KR 에 정확히 부재) → Task M (지도교수 메일) 양식으로 agent 가 메일 본문 draft 작성, 학생이 보내고 답 받기

자세히: `docs/rigor-lock.md` §1, §4.

### Q: 본인 thesis 결과를 외부 publish 할 수 있나?

학생 본인 / 지도교수 책임. 데이터 라이선스 (fnguide / CheckExpert) 가 외부 publish 시 figure / table 제약 가능. SSRN preprint / 학회 발표 / 학술지 투고 시 사전 vendor 약관 확인.

### Q: agent 가 만든 본문을 그대로 thesis 로 제출?

❌ NO. agent 가 만든 draft 는 초안. 학생 본인이 다음 책임:
- 본문 모든 줄 본인이 이해 + 본인 말로 설명 가능
- Phase 3 / 5 의 self-test gate 가 본 책임 강제 (이해도 미달 시 final 차단)
- 학교의 AI 사용 정책 (대부분 AI 보조 허용 + 명시 의무) 준수

### Q: 진행 중 다른 AI 툴로 옮길 수 있나?

✓ YES. `thesis_state/` 디렉토리가 cross-tool baton. 어느 툴이든 다음 세션 시작 시 `thesis_state/` 읽고 어디까지 진행됐는지 파악. 예: Phase 0 까지 Claude Code 로 → Phase 2 autopilot 은 Codex CLI 로 → Phase 4 thesis writing 은 Cursor 로.

### Q: 진행이 막혔을 때?

1. `thesis_state/03_user_tasks.md` 확인 — agent 가 학생에게 escalation 한 task 있는지
2. 해당 task 의 step-by-step 따라 진행
3. 완료 후 `상태: blocked → done` 변경 + agent 에게 "Task U-N done, continue" 알림
4. agent 가 다음 task 진행

### Q: 발표 통과 못 할 것 같은데?

Phase 3 self-test 가 8/10 미만 으로 fail 하면 agent 가 보완 작업 안내. 통과 못 하면 발표 미루기 / Phase 0 재진입 (paper 변경) 결정 — 학생 + 지도교수 책임.

## 4. 다음 단계

Phase 0 끝나면 학생이 `thesis_state/00_feasibility.md` 검토 후 Phase 1 진입 결정. agent 에게 `start Phase 1` 또는 `phase-1-planning` skill 호출. 이후 Phase 별로 진행.

## 5. 도움 요청

- GitHub issue: `<owner>/kaist-mfe-thesis-harness` repo 의 Issues 탭
- LinkedIn DM: 작성자에게
