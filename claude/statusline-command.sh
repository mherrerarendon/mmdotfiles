#!/bin/bash
# Claude Code statusline: model name + context usage progress bar

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -z "$used" ]; then
  printf "%s" "$model"
  exit 0
fi

used_int=$(printf '%.0f' "$used")

bar_width=10
filled=$(( used_int * bar_width / 100 ))
if [ "$filled" -gt "$bar_width" ]; then filled=$bar_width; fi
if [ "$filled" -lt 0 ]; then filled=0; fi
empty=$(( bar_width - filled ))

bar=""
for ((i = 0; i < filled; i++)); do bar="${bar}#"; done
for ((i = 0; i < empty; i++)); do bar="${bar}-"; done

if [ "$used_int" -ge 80 ]; then
  color="\033[31m"   # red - context nearly full
elif [ "$used_int" -ge 50 ]; then
  color="\033[33m"   # yellow - context filling up
else
  color="\033[32m"   # green - plenty of context left
fi
reset="\033[0m"

printf "%s ${color}[%s] %d%%${reset}" "$model" "$bar" "$used_int"
