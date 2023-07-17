#!/bin/bash

backup_dir="$HOME/kadai3/backups"
source_dir="$HOME/kadai3"
backup_date=$(date +%Y%m%d)
backup_file="$backup_dir/$backup_date.tar.gz"

if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

tar -czf "$backup_file" -C "$source_dir" .

if [ $? -eq 0 ]; then
  echo "バックアップが完了しました: $backup_file"
else
  echo "バックアップ中にエラーが発生しました"
  exit 1
fi

