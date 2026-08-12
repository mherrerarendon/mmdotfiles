#!/bin/bash
# Claude Code statusline: model name + context usage progress bar
# + Claude.ai subscription rate-limit usage (5h / 7d) + soonest reset time.
# Every field below is read from stdin JSON; anything absent is omitted
# rather than guessed at.

input=$(cat)
reset_style="\033[0m"

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

line="$model"

if [ -n "$used" ]; then
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

  line="${line} ${color}[${bar}] ${used_int}%${reset_style}"
fi

# --- Claude.ai subscription rate limits (optional; absent unless the
# user is a subscriber and at least one API response has been received) ---
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

rl=""
if [ -n "$five_pct" ]; then
  rl="${rl} 5h:$(printf '%.0f' "$five_pct")%"
fi
if [ -n "$week_pct" ]; then
  rl="${rl} 7d:$(printf '%.0f' "$week_pct")%"
fi

# Reset time: prefer the 5-hour window's reset (it comes sooner); fall
# back to the 7-day window's reset if that's the only one available.
# Accept either a Unix epoch or an ISO-8601 UTC timestamp, since it's not
# certain which the payload uses; anything unparseable is just omitted.
reset_raw="$five_reset"
if [ -z "$reset_raw" ]; then
  reset_raw="$week_reset"
fi
if [ -n "$reset_raw" ]; then
  if [[ "$reset_raw" =~ ^[0-9]+$ ]]; then
    reset_time=$(date -r "$reset_raw" "+%H:%M" 2>/dev/null)
  else
    # ISO-8601 (e.g. 2025-08-12T18:42:00Z): strip fractional secs + trailing Z,
    # parse as UTC to an epoch, then render in local time.
    iso="${reset_raw%%.*}"; iso="${iso%Z}"
    epoch=$(TZ=UTC date -jf "%Y-%m-%dT%H:%M:%S" "$iso" "+%s" 2>/dev/null)
    reset_time=$([ -n "$epoch" ] && date -r "$epoch" "+%H:%M" 2>/dev/null)
  fi
  if [ -n "$reset_time" ]; then
    rl="${rl} resets@${reset_time}"
  fi
fi

if [ -n "$rl" ]; then
  line="${line} \033[2m|${rl}${reset_style}"
fi

printf "%b" "$line"
