---
name: skill-finder
description: 지금 하려는 작업을 듣고 그 시점에 가장 유용한 스킬을 추천. 사용자가 skill-finder를 부르거나 "스킬 추천해줘", "이럴 때 쓸 스킬 있어?", "어떤 스킬 깔면 좋아?"라고 물을 때만 사용.
---

# 스킬 추천

## 절차

1. **지금 상황 파악** — 아래 세 가지가 안 보이면 한 번에 하나만 묻는다
   - 무엇을 하려는지 (예: 버그 잡기, 보고서 쓰기, 파이프라인 만들기)
   - 어디서 쓰는지: claude.ai(웹·앱) / Claude Code / API
   - 일회성인지, 앞으로 반복할 작업인지
2. **지금 단계 판단** — 기획 / 구현 / 테스트·디버깅 / 문서화 / 배포 중 어디인지
3. **이미 쓸 수 있는 스킬부터** — 현재 대화에 로드된 스킬(내 스킬 + 기본 탑재)에 맞는 게 있으면 그걸 1순위로
4. **아래 카탈로그에서 후보 선정**
5. **카탈로그에 없거나 오래돼 보이면 웹 검색**으로 최신 스킬 확인 (anthropics/skills, GitHub에서 "SKILL.md" + 작업 키워드)
6. **스킬이 필요 없으면 솔직하게** — 기본 능력으로 충분하면 "스킬 없이 바로 하면 된다"고 말한다
7. **반복 작업인데 맞는 스킬이 없으면** — skill-creator로 직접 만들기를 제안

## 추천 내용

- 1순위 1개 + 대안 최대 2개, 각각 한 줄: `**스킬명** — 지금 유용한 이유 / 쓸 수 있는 곳 / 설치`
- 마지막 줄에 **바로 다음 행동** (예: "설치 후 '실패하는 테스트부터 써줘'라고 시작")
- 커뮤니티 스킬이면 "설치 전 SKILL.md와 스크립트 확인" 을 이유 끝에 붙인다

## 단계별 우선 후보

| 단계 | 먼저 볼 스킬 |
|---|---|
| 기획·설계 | frontend-design(화면), mcp-builder(외부 연동), skill-creator(반복 작업 자동화) |
| 구현 | python-coding-style, test-driven-development, subagent-driven-development(대규모), postgres(DB) |
| 테스트·디버깅 | systematic-debugging, webapp-testing, ios-simulator-skill |
| 문서화 | report-doc-style, pptx-corporate-style, docx, pdf, blog-post-chirpy |
| 공부·정리 | study-note-style |

## 카탈로그

### 내 스킬 (github.com/sinheechan/Claude-skills)

| 스킬 | 용도 |
|---|---|
| python-coding-style | 파이썬 코드 작성·리뷰 |
| report-doc-style | 보고서·제안서·회의록 |
| pptx-corporate-style | 발표자료 |
| blog-post-chirpy | 기술 블로그 글 |
| study-note-style | 공부 정리·학습 노트 |

### Anthropic 공식 (anthropics/skills)

| 스킬 | 용도 | 비고 |
|---|---|---|
| docx / pdf / pptx / xlsx | Word·PDF·PPT·엑셀 생성·편집 | claude.ai 기본 탑재 |
| skill-creator | 새 스킬 만들기 | claude.ai 기본 탑재 |
| frontend-design | 뻔하지 않은 UI 디자인 | claude.ai 기본 탑재 |
| mcp-builder | MCP 서버 제작 (Python·TS) | |
| webapp-testing | Playwright로 로컬 웹앱 테스트 | Claude Code 권장 |

Claude Code 설치: `/plugin marketplace add anthropics/skills` → `/plugin install document-skills@anthropic-agent-skills`

### superpowers (obra/superpowers)

| 스킬 | 용도 |
|---|---|
| test-driven-development | 테스트 먼저 쓰게 강제 |
| systematic-debugging | 4단계 원인 추적 디버깅 |
| subagent-driven-development | 서브에이전트 위임 + 2단계 리뷰 |

Claude Code 설치: `/plugin marketplace add obra/superpowers-marketplace` → `/plugin install superpowers@superpowers-marketplace`

### 커뮤니티

| 스킬 | 저장소 | 용도 |
|---|---|---|
| ios-simulator-skill | conorluddy | iOS 빌드·테스트 |
| postgres | sanjay3290 | PostgreSQL 쿼리 안전 실행 |
| react-best-practices | vercel-labs | React 베스트 프랙티스 |
| linear-claude-skill | wrsmith108 | Linear 이슈 관리 |
| varlock-claude-skill | varlock | 환경변수 보안 관리 |
| ffuf-web-fuzzing | jthack | 웹 퍼징·보안 테스트 |
| claude-scientific-skills | K-Dense-AI | 과학 연구 스킬 모음 |

## 설치 위치 안내

- **claude.ai**: 스킬 폴더를 zip으로 압축 → 설정의 스킬 메뉴에서 업로드
- **Claude Code**: `/plugin install ...` 또는 폴더를 `~/.claude/skills/`에 복사
- claude.ai와 Claude Code 스킬은 서로 동기화되지 않는다

## 채팅 답변 형식 (이 스킬의 다른 규칙보다 우선 적용)

- 말투는 자유롭게, 단 "~습니다", "~니다" 체는 쓰지 않음.
- 결론 먼저, 3~5줄 이내. 인사·서론·마무리 요약 없음.
- 코드, 코드 설명, 표, 정리 내용이 5줄 이상이면 채팅에 쓰지 않고 .md 파일로 전달함.
- 파일 전달 시 채팅에는 파일 설명 한 줄만 씀. 내용 재요약 없음.
- 5줄 미만 코드나 수정한 한두 줄은 채팅에 바로 씀.
