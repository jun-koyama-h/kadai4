#!/bin/bash

TARGET="./gcd.sh"
PASS_COUNT=0
FAIL_COUNT=0

pass() {
  echo "✅ $1"
  PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
  echo "❌ $1" >&2
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

run_test() {
  description=$1
  shift
  expected_output=$1
  shift
  output=$("$@" 2>/dev/null)

  if [ "$output" = "$expected_output" ]; then
    pass "$description"
  else
    fail "$description: 出力 '$output'（期待値 '$expected_output'）"
  fi
}

run_error_test() {
  description=$1
  shift
  "$@" > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    pass "$description"
  else
    fail "$description: エラーを検出できませんでした"
  fi
}

# 正常系
run_test "2と4 → 2を返す" 2 $TARGET 2 4
run_test "36と60 → 12を返す" 12 $TARGET 36 60
run_test "1と1 → 1を返す" 1 $TARGET 1 1

# 異常系
run_error_test "引数が1個 → エラー" $TARGET 5
run_error_test "引数が3個 → エラー" $TARGET 1 2 3
run_error_test "負の数 → エラー" $TARGET -3 9
run_error_test "0を含む → エラー" $TARGET 0 10
run_error_test "小数 → エラー" $TARGET 3.5 7
run_error_test "文字列 → エラー" $TARGET abc 5
run_error_test "極端に大きい数 → エラーを検出する" $TARGET 999999999999999999999 3

# 結果
echo
echo "✅ 成功: $PASS_COUNT"
echo "❌ 失敗: $FAIL_COUNT"

exit $FAIL_COUNT
