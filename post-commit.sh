#!/bin/bash

BIN="lucky_commit"
COUNT=$(git rev-list HEAD --count)
HASH=$(printf "%07d" "${COUNT}")

[[ -x "$(command -v "${BIN}")" ]] || {
	echo "${BIN} not found! Install it first: https://github.com/not-an-aardvark/lucky-commit."
	exit 1
}

echo "[${BIN}] committing for ${HASH}..."
eval "${BIN} ${HASH}"