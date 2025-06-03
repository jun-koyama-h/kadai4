#!/bin/bash

# エラーメッセージを標準エラーに出力して終了
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# 入力チェック：引数が2つか
if [ $# -ne 2 ]; then
  error_exit "2つの自然数を引数として指定してください。"
fi

# 数字かつ自然数か（0より大きい整数か）を確認
for arg in "$1" "$2"; do
  if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
    error_exit "自然数のみを指定してください（0や負の数、文字列は不可）。"
  fi
done

# 変数へ代入
a=$1
b=$2

# ユークリッドの互除法で最大公約数を計算
while [ "$b" -ne 0 ]; do
  r=$((a % b))
  a=$b
  b=$r
done

# 結果を出力
echo "$a"
