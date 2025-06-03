#!/bin/bash

# テスト対象スクリプト
TARGET="./gcd.sh"

# 成功したテスト数をカウント
PASS_COUNT=0
FAIL_COUNT=0

# 成功・失敗表示関数
pass() {
  echo "✅ $1"
  PASS_COUNT=$((PASS_COUNT+1))
}

fail() {
  echo "❌ $1" >&2
  FAIL_COUNT=$((FAIL_COUNT+1))
}

# テストケース：成功系
output=$($TARGET 2 4)
if [ "$output" = "2" ]; then
  pass "2と4 → 2"
else
  fail "2と4 → 想定外の出力（$output）"
fi

output=$($TARGET 15 5)
if [ "$output" = "5" ]; then
  pass "15と5 → 5"
else
  fail "15と5 → 想定外の出力（$output）"
fi

# テストケース：失敗系（引数不足）
if $TARGET 3 > /dev/null 2>&1; then
  fail "引数1個 → エラーにならない"
else
  pass "引数1個 → エラーを検出"
fi

# テストケース：文字列
if $TARGET a b > /dev/null 2>&1; then
  fail "文字列 → エラーにならない"
else
  pass "文字列 → エラーを検出"
fi

# テストケース：負の数
if $TARGET -2 4 > /dev/null 2>&1; then
  fail "負の数 → エラーにならない"
else
  pass "負の数 → エラーを検出"
fi

# テストケース：0の入力
if $TARGET 0 5 > /dev/null 2>&1; then
  fail "0を含む → エラーにならない"
else
  pass "0を含む → エラーを検出"
fi

# 結果まとめ
echo ""
echo "✅ 成功: $PASS_COUNT"
echo "❌ 失敗: $FAIL_COUNT"

# 終了コード
if [ "$FAIL_COUNT" -eq 0 ]; then
  exit 0
else
  exit 1
fi
