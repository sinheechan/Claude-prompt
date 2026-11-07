---
name: python-coding-style
description: 희찬의 파이썬 코딩 스타일. 파이썬 코드를 새로 작성하거나 리뷰·리팩터링할 때, 데이터 파이프라인·ETL·ML 스크립트를 만들 때 사용.
---

# Python 코딩 스타일

## 핵심 원칙

1. **간결하고 읽기 쉽게.** 필요 없는 클래스·추상화·디자인 패턴을 만들지 않는다. 함수 몇 개로 끝나면 함수로 끝낸다.
2. **복잡한 로직은 풀어쓴다.** 한 줄 컴프리헨션·체이닝이 3단계 이상 중첩되면 중간 변수로 나눈다.
3. **동작하는 코드 전체를 준다.** "…생략…" 없이 바로 실행 가능한 파일 단위로 제공한다.

## 파일·함수 이름

- 파일명은 **역할이 바로 보이게** 동사_대상 형태로 짓는다.
  - 데이터 수집: `getdata_from_<출처>.py` (예: `getdata_from_y.py` = Yahoo Finance)
  - DB·CSV 입출력/제어: `db_control.py`
  - 피하기: `fetcher.py`, `db.py`, `utils.py`처럼 뭘 하는지 안 보이는 이름
- 함수명도 동사로 시작: `load_tracks()`, `save_to_db()`, `calc_rul()`

## 코드 구조

```python
"""한 줄 요약: 이 파일이 하는 일"""

# 1) import — 표준 라이브러리 / 서드파티 / 내 모듈 순
# 2) 상수 — 경로, 설정값은 파일 상단 대문자 상수로
# 3) write_log_print — 상수 바로 아래, 모든 파일에 매번 넣는다
# 4) 함수 — 위에서 아래로 실행 순서대로 배치
# 5) main — if __name__ == "__main__": 에서 흐름이 한눈에 보이게
```

## 주석·로그

- 주석은 한국어로, **왜** 이렇게 했는지 위주. 코드가 뭘 하는지는 코드로 보이게.
- `logging`은 쓰지 않는다. 출력은 `print` 대신 `write_log_print()`로 한다.
- 로그 파일은 **실행한 진입 파일 이름**으로 생긴다.
  - 단독 실행: `getdata_from_y.py` → `getdata_from_y.log`
  - `main.py`로 여러 파일을 묶어 실행: 전부 `main.log` 하나에 모임
  - 각 줄에 출력한 py 파일명이 찍히므로 어느 파일의 로그인지 구분된다.
- 모든 .py 파일에 아래 함수를 그대로 넣는다.

```python
import sys
from datetime import datetime
from pathlib import Path

# 진입 파일 기준으로 로그 생성 → main.py로 묶여 실행되면 모든 출력이 main.log에 모임
LOG_PATH = Path(sys.argv[0]).resolve().with_suffix(".log")


def write_log_print(*args):
    """print한 내용을 화면에 출력하고 로그 파일에도 남김"""
    msg = " ".join(str(a) for a in args)
    print(msg)
    line = f"{datetime.now():%Y-%m-%d %H:%M:%S} [{Path(__file__).name}] {msg}\n"
    with LOG_PATH.open("a", encoding="utf-8") as f:
        f.write(line)
```

## 데이터 처리 습관

- pandas는 원본을 덮어쓰지 않는다 (`df_raw` → `df_clean`).
- 결측치·이상치 처리 기준은 주석으로 근거를 남긴다.
- 경로는 `pathlib.Path` 사용.

## 채팅 답변 형식 (이 스킬의 다른 규칙보다 우선 적용)

- 말투는 자유롭게, 단 "~습니다", "~니다" 체는 쓰지 않음.
- 결론 먼저, 3~5줄 이내. 인사·서론·마무리 요약 없음.
- 코드, 코드 설명, 표, 정리 내용이 5줄 이상이면 채팅에 쓰지 않고 .md 파일로 전달함.
- 파일 전달 시 채팅에는 파일 설명 한 줄만 씀. 내용 재요약 없음.
- 5줄 미만 코드나 수정한 한두 줄은 채팅에 바로 씀.
