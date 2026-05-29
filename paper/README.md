# paper/ — 학생 입력 위치

이 디렉토리에 다음을 넣는다.

## 필수

- **`paper/original.pdf`** — 재현할 원저 paper. agent 는 Phase 0.1 에서 이를 markdown 으로 변환 (`paper/converted/`).

## 선택

- **`paper/student_notes.md`** — 학생 본인의 관심사·이미 본 자료·아이디어. 양식은 `student_notes.md.template` 참조.
- **`paper/supplementary/`** — 원저 paper 의 부록 (별도 PDF / Excel / Stata code 등).

## agent 가 자동 생성

- **`paper/converted/`** — Phase 0.1 산출 (markdown 변환 + section split + manifest.json). 학생이 직접 편집 X.

## 주의

- `original.pdf` 는 `.gitignore` 에 등록 → public repo 에 commit 안 됨 (저작권 보호).
- 학생이 본인 private thesis repo 에 commit 하고 싶으면 `.gitignore` 수정.
- 데이터 vendor (fnguide / CheckExpert) 의 라이선스 약관 사전 확인 — paper 안 도표가 vendor 데이터 기반이면 외부 publish 제약 가능.
