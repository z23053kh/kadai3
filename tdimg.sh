#!/bin/bash

supported_extensions=("gif" "png" "jpeg" "jpg" "webp")

ERROR_RED='\033[0;31m'
NC='\033[0m'

directory=$1

if [ -z "$directory" ]; then
  echo -e "${ERROR_RED}ディレクトリのパスを指定してください${NC}"
  exit 1
fi

if [ ! -d "$directory" ]; then
  echo -e "${ERROR_RED}指定されたディレクトリが存在しません${NC}"
  exit 1
fi

for file in "$directory"/*; do
  extension="${file##*.}"
 
  if [[ " ${supported_extensions[@]} " =~ " $extension " ]]; then
    filesize=$(stat -c%s "$file")
    new_filename="${filesize}.${extension}"

    mv "$file" "$directory/$new_filename"
    echo "処理完了: $new_filename"
  else
    echo -e "${ERROR_RED}エラー: サポートされていないファイルが含まれています${NC}"
    exit 1
  fi
done

