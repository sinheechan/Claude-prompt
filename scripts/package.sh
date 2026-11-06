#!/usr/bin/env bash
# 스킬 폴더를 claude.ai 업로드용 zip으로 묶는다.
# 사용법: ./scripts/package.sh            → 전체
#        ./scripts/package.sh <스킬명>    → 하나만
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"
DIST_DIR="$ROOT/dist"
mkdir -p "$DIST_DIR"

package_one() {
  local name="$1"
  local dir="$SKILLS_DIR/$name"

  if [[ ! -f "$dir/SKILL.md" ]]; then
    echo "건너뜀: $name (SKILL.md 없음)"
    return
  fi

  # 프런트매터 name과 폴더명이 같은지 확인
  local fm_name
  fm_name="$(grep -m1 '^name:' "$dir/SKILL.md" | sed 's/^name:[[:space:]]*//')"
  if [[ "$fm_name" != "$name" ]]; then
    echo "오류: $name 폴더의 name이 '$fm_name'로 되어 있음" >&2
    exit 1
  fi

  rm -f "$DIST_DIR/$name.zip"
  (cd "$SKILLS_DIR" && zip -qr "$DIST_DIR/$name.zip" "$name" -x '*.DS_Store')
  echo "완료: dist/$name.zip"
}

if [[ $# -gt 0 ]]; then
  package_one "$1"
else
  for dir in "$SKILLS_DIR"/*/; do
    package_one "$(basename "$dir")"
  done
fi
