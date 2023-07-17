#!/bin/bash

ERROR_RED='\033[0;31m'
NC='\033[0m'

remove_empty_directories() {
  local dir=$1

  if [[ ! -d "$dir" ]]; then
    return
  fi

  local entries=$(find "$dir" -mindepth 1 -type d)
  for entry in $entries; do
    remove_empty_directories "$entry"
  done

  if [[ -z "$(ls -A "$dir")" ]]; then
    echo "削除: $dir"
    rmdir "$dir"
  fi
}

if [[ -z "$1" ]]; then
  echo -e "${ERROR_RED}ディレクトリが指定されていません${NC}"
  exit 1
fi

if [[ -d "$1" ]]; then
  remove_empty_directories "$1"
  echo "空のディレクトリの削除が完了しました"
else
  echo -e "${ERROR_RED}指定されたディレクトリが存在しません${NC}"
  exit 1
fi

