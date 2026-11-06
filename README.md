# claude-skills

희찬이의 Claude 스킬 관제탑. 프로젝트마다 필요한 스타일(코딩·문서·발표·블로그)을 스킬로 만들어 두고,
각 프로젝트 지침에서 골라 쓰는 구조입니다.

## 왜 스킬로 관리하나

- 평소에는 스킬의 `name`·`description`(약 100토큰)만 컨텍스트에 올라가고, 본문은 호출될 때만 로드됩니다.
- `references/` 아래 파일은 SKILL.md에서 필요하다고 할 때만 읽힙니다 → 예시·템플릿을 많이 넣어도 평소 비용 거의 없음.
- 한 번 등록하면 모든 프로젝트·대화에서 사용 가능.

## 스킬 목록

| 스킬 | 언제 쓰나 | 버전 |
|---|---|---|
| [python-coding-style](skills/python-coding-style/SKILL.md) | 파이썬 코드 작성·리뷰·리팩터링 | 1.0 |
| [report-doc-style](skills/report-doc-style/SKILL.md) | 사업계획서·과제 보고서·제안서 등 공식 문서 | 1.0 |
| [pptx-corporate-style](skills/pptx-corporate-style/SKILL.md) | 발표자료·PPT 제작 | 1.0 |
| [blog-post-chirpy](skills/blog-post-chirpy/SKILL.md) | GitHub Pages(Jekyll Chirpy) 기술 블로그 글 | 1.0 |

## 폴더 구조

```
claude-skills/
├── README.md              # 이 파일 (스킬 목록 = 관제판)
├── CHANGELOG.md           # 스킬별 변경 이력
├── templates/
│   └── SKILL_TEMPLATE.md  # 새 스킬 만들 때 복사해서 시작
├── scripts/
│   └── package.sh         # 스킬 폴더 → 업로드용 zip
└── skills/
    └── <skill-name>/
        ├── SKILL.md       # 필수: 프런트매터 + 핵심 지침
        └── references/    # 선택: 예시·템플릿 (필요할 때만 로드)
```

## 작성 규칙

- 스킬 폴더명 = 프런트매터 `name` (소문자·숫자·하이픈, 64자 이내).
- `name`에 `claude`, `anthropic`이라는 단어는 쓰지 않습니다.
- `description`은 "무엇을 + 언제 쓰는지"를 한두 문장으로. 이 문장이 스킬 호출 여부를 결정합니다.
- SKILL.md 본문은 짧게(대략 500줄 이내), 긴 예시는 `references/`로 분리.

## 등록(업로드) 방법

```bash
./scripts/package.sh                      # 전체 스킬을 dist/*.zip으로 묶기
./scripts/package.sh report-doc-style     # 하나만 묶기
```

claude.ai → 설정의 스킬 메뉴에서 `dist/<skill-name>.zip` 업로드.
수정했으면 같은 이름으로 다시 업로드하면 덮어씁니다.

> claude.ai에 올린 스킬은 API·Claude Code와 동기화되지 않습니다.
> Claude Code에서도 쓰려면 `skills/<name>` 폴더를 `~/.claude/skills/`에 복사하세요.

## 프로젝트에서 스타일 고르기

각 Claude 프로젝트의 지침(Instructions)에 한 줄만 적습니다.

```
이 프로젝트의 문서는 report-doc-style 스킬, 코드는 python-coding-style 스킬을 따른다.
```

## 변경 관리

1. `skills/<name>/SKILL.md` 수정
2. `CHANGELOG.md`에 한 줄 기록, README 표의 버전 갱신
3. `git commit -m "report-doc-style: 표 작성 규칙 추가"` → zip 재업로드
