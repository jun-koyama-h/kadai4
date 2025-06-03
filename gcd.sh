#!/bin/bash

# 最大整数値
MAX_INT=9223372036854775807

error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# 引数チェック
if [ $# -ne 2 ]; then
  error_exit "2つの自然数を指定してください。"
fi

# 自然数チェック＋最大値チェック
for arg in "$1" "$2"; do
  if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
    error_exit "自然数（1以上の整数）を指定してください。入力値: $arg"
  fi

  # MAX_INT を超えるかチェック
  if [ "$arg" -gt "$MAX_INT" ] 2>/dev/null; then
    error_exit "数値が大きすぎます（最大: $MAX_INT）。入力値: $arg"
  fi
done

a=$1
b=$2

# ユークリッドの互除法
while [ "$b" -ne 0 ]; do
  r=$((a % b))
  a=$b
  b=$r
done

echo "$a"
