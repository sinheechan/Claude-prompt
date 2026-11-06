# claude-skills

희찬이의 Claude 스킬 모음. 폴더 하나 = 스킬 하나, 안에는 `SKILL.md` 파일 하나뿐.

| 스킬 | 언제 쓰나 |
|---|---|
| [python-coding-style](python-coding-style/SKILL.md) | 파이썬 코드 작성·리뷰 |
| [report-doc-style](report-doc-style/SKILL.md) | 보고서·제안서·회의록 |
| [pptx-corporate-style](pptx-corporate-style/SKILL.md) | 발표자료 |
| [blog-post-chirpy](blog-post-chirpy/SKILL.md) | 기술 블로그 글 |

## 쓰는 법

1. 스킬 폴더를 zip으로 압축 → claude.ai 설정의 스킬 메뉴에서 업로드
2. 프로젝트 지침에 한 줄: `문서는 report-doc-style 스킬을 따른다.`
3. 수정하면 다시 압축해서 덮어쓰기 업로드

## 새 스킬 추가

폴더를 만들고 `SKILL.md` 맨 위에 아래 두 줄만 넣으면 끝.

```
---
name: 폴더명과-같게
description: 무엇을 하는지 + 언제 쓰는지
---
```
