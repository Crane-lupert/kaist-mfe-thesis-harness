# KAIST FE 석사 졸업논문 재현 하네스

> JF / JFE / RFS / JFQA top 저널 paper 의 한국시장 재현을 AI agent (Claude Code / Codex CLI / Cursor / Antigravity / ChatGPT) 와 함께 4-phase pipeline 으로 진행하는 GitHub Template.

## 누구를 위한 것인가

- **KAIST 경영대학 금융공학(FE) 석사과정생** — 졸업논문으로 top 저널 paper 의 KR 시장 재현을 진행 중이거나 곧 시작할 예정.
- 다른 학교·학과여도 KR 시장 quant 재현이라면 그대로 가져다 쓸 수 있음 (서울대 / 연세대 MFE / 통계·경영 박사과정 등).

## 무엇을 해주나

1. **Phase 0 — Feasibility 분석**: 원저 paper 를 읽고 "한국에서 재현 가능한지, 어떤 변수가 빠지는지, 어떤 proxy 가 가능한지" 를 1쪽 보고서로 작성. 그대로 발표 자료에 쓸 수 있음.
2. **Phase 1 — Planning**: 원저 변수를 fnguide / CheckExpert / KRX / DART 등 KR 데이터 컬럼으로 매핑. agent 가 할 일과 학생이 직접 해야 할 일을 분리.
3. **Phase 2 — Execution**: agent 가 코드·검정·robustness 를 overnight autopilot 으로 작성 (지원 툴 한정). 학생이 해야 할 일 (데이터 다운로드, API 키 발급 등) 은 step-by-step 지시문으로 따로 정리해줌.
4. **Phase 3 — Presentation prep**: 중간 발표용 deck + 예상 Q&A. agent 가 학생에게 질문을 던지고 이해도 self-test (8/10 이상 통과해야 final 처리).

## 어느 AI 툴이 지원되나

| 툴 | Overnight Autopilot | Step-trigger | 비고 |
|---|:---:|:---:|---|
| Claude Code | O | O | `/loop` 으로 overnight, skill 자동 invocation |
| Codex CLI (OpenAI) | O | O | `codex --auto` 로 overnight |
| Cursor | 제한적 | O | composer agent mode |
| Antigravity (Google) | 신규 (capability 미확정) | O | mission mode |
| ChatGPT / Gemini 웹 | X | O | `prompts/` 디렉토리의 prompt 를 paste |

레포 첫 진입 시 `tool-routing/detect.ps1` (Windows) 또는 `detect.sh` (mac/linux) 가 자동으로 어느 툴인지 감지하고 `thesis_state/tool.json` 에 기록한다. 이후 세션은 이 파일 신뢰. 감지 결과가 틀리면 `tool.json` 을 수동 편집.

## 5분 시작 가이드

```bash
# 1. 이 template 으로 본인 thesis 레포 생성
gh repo create my-thesis --template <owner>/kaist-mfe-thesis-harness --private
cd my-thesis

# 2. 원저 paper 와 본인 노트 투입
cp ~/Downloads/some-jf-paper.pdf paper/original.pdf
$EDITOR paper/student_notes.md   # 본인 관심사·이미 본 자료 등 (생략 가능)

# 3. 본인 AI 툴 열고 첫 입력
#  - Claude Code / Codex / Cursor: "Read AGENTS.md and start Phase 0"
#  - ChatGPT 웹: prompts/00-feasibility.md 내용을 paste

# 4. Phase 0 산출 (thesis_state/00_feasibility.md) 검토 → 다음 phase 진행
```

## 데이터 vendor 가정

- **fnguide DataGuide**: KAIST 라이선스 또는 학생 본인 라이선스. raw CSV export 또는 API.
- **CheckExpert**: KAIST 라이선스. 컨센서스 + 일부 회계 데이터.
- **KRX**: 공시 + 시세 (공개).
- **DART**: 전자공시 (공개, OpenDART API 키 무료 발급).
- **한국은행 ECOS**: macro time series (공개, API 키 무료 발급).

각 vendor 별 데이터 형태 + 학생이 해야 할 라이선스 확인 절차는 `docs/fnguide-dictionary.md`, `docs/checkexpert-howto.md`.

## 한국 시장 특수성 lock

- 우선주 (`-P` 접미사) / 보통주 분리
- 상하한가 (±30%) 처리
- KOSPI / KOSDAQ universe 분리
- 매매정지·관리종목·거래정지·상장폐지
- 결산일 분기·반기·연간 + 컨센서스 발표일 lag
- 5% 지분 공시 (DART) / 우호 지분

자세한 caveat: `docs/kr-market-quirks.md`.

## Faithful translation lock (rigor 핵심)

원저 paper 의 방법론·변수·검증은 **"한국에 존재하지 않음"** 이 증명되지 않는 한 substitute / drop / proxy 로 대체 금지. agent 가 "비슷한 다른 변수로 했어요" 식 임의 결정 자동 차단. 자세한 규칙: `AGENTS.md` §6 + `docs/rigor-lock.md`.

발표 자리에서 "왜 다른 변수를 썼냐" 질문 받았을 때 학생이 답을 못 하는 상황을 미연 차단.

## 디렉토리 구조

```
my-thesis/
├── AGENTS.md            # 모든 AI 가 처음 읽는 SoT (≤ 200 줄)
├── README.md            # 본 파일
├── paper/               # 원저 PDF + 학생 노트 (학생 채움)
├── thesis_state/        # 4-phase 산출 7 파일 (agent 채움, cross-tool baton)
├── code/                # 학생 + agent 코드
├── docs/                # KR 시장 quirks / fnguide / checkexpert / rigor lock / 발표 rubric
├── prompts/             # web (ChatGPT/Gemini) 사용자용 paste prompt
├── tool-routing/        # detect.ps1 / detect.sh
├── .claude/             # Claude Code 전용 (settings + skills)
├── .codex/              # Codex CLI 전용 (config.toml + AGENTS.md import)
└── .cursorrules         # Cursor 전용 (AGENTS.md import)
```

## 라이선스

MIT. 자유롭게 fork / 수정 / 본인 thesis 에 사용. credit 의무 없음 (단 LinkedIn 후배 누군가가 도움 됐다고 메시지 보내주면 작성자 동기부여).

## 한계 및 책임 분리

- **데이터 라이선스**: 학생 본인 책임. 이 template 은 어떤 데이터도 포함하지 않음.
- **학술 무결성**: 발표 자료·thesis 본문은 학생 본인이 작성. agent 가 만든 draft 는 초안이고, 학생이 자기 머리로 통과시키는 게 본질.
- **AI 사용 정책**: 본인 학교·지도교수의 AI 보조 사용 policy 를 사전 확인. (대부분 학교에서 AI 보조 허용, 단 명시 의무.)

## 피드백 / 이슈

LinkedIn DM 또는 GitHub issue.
