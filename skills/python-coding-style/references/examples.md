# python-coding-style 예시

## 좋은 예: 수집 → 정제 → 저장

```python
"""getdata_from_y.py — Yahoo Finance 일별 시세를 받아 CSV로 저장"""

import logging
from pathlib import Path

import pandas as pd
import yfinance as yf

DATA_DIR = Path("data")
TICKERS = ["AAPL", "MSFT", "NVDA"]

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")


def get_prices(ticker: str, period: str = "1y") -> pd.DataFrame:
    df_raw = yf.download(ticker, period=period, progress=False)
    logging.info("%s 수집 완료: %d행", ticker, len(df_raw))
    return df_raw


def clean_prices(df_raw: pd.DataFrame) -> pd.DataFrame:
    # 거래 정지일(거래량 0)은 지표 계산을 왜곡하므로 제외
    df_clean = df_raw[df_raw["Volume"] > 0].copy()
    df_clean = df_clean.dropna()
    return df_clean


def save_prices(df: pd.DataFrame, ticker: str) -> None:
    DATA_DIR.mkdir(exist_ok=True)
    out_path = DATA_DIR / f"{ticker}.csv"
    df.to_csv(out_path)
    logging.info("저장: %s", out_path)


if __name__ == "__main__":
    for ticker in TICKERS:
        df_raw = get_prices(ticker)
        df_clean = clean_prices(df_raw)
        save_prices(df_clean, ticker)
```

## 피할 예

```python
# 이유 없는 클래스 + 뭘 하는지 안 보이는 이름
class DataFetcher:
    def run(self):
        return [x for x in (yf.download(t) for t in T) if x is not None and len(x[x.Volume > 0].dropna()) > 0]
```
