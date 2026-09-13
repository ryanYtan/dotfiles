#!/bin/bash
# Claude Code status line (2 lines)
#   line 1: current working directory
#   line 2: context-window usage for this conversation, plus
#           5-hour / 7-day subscription usage limits
#
# All values below come directly from the JSON Claude Code pipes to this
# script on stdin for each render - no transcript parsing or extra API
# calls are needed:
#   .cwd                                  -> current working directory
#   .context_window.used_percentage       -> % of context window used
#   .context_window.total_input_tokens    -> tokens currently in context
#   .context_window.context_window_size   -> max tokens for this model
#   .rate_limits.five_hour.used_percentage  -> 5h session usage (subscribers)
#   .rate_limits.seven_day.used_percentage  -> 7d weekly usage (subscribers)
#   .rate_limits.five_hour.resets_at        -> 5h window reset (unix epoch secs)
#   .rate_limits.seven_day.resets_at        -> 7d window reset (unix epoch secs)

input=$(cat)
now=$(date +%s)

# formats seconds-until-reset as e.g. "2h14m" / "35m" / "3d4h"
fmt_reset() {
  local resets_at="$1"
  [ -z "$resets_at" ] && return
  local delta=$((resets_at - now))
  [ "$delta" -lt 0 ] && delta=0
  local d=$((delta / 86400))
  local h=$(((delta % 86400) / 3600))
  local m=$(((delta % 3600) / 60))
  if [ "$d" -gt 0 ]; then
    printf "%dd%dh" "$d" "$h"
  elif [ "$h" -gt 0 ]; then
    printf "%dh%dm" "$h" "$m"
  else
    printf "%dm" "$m"
  fi
}

# ---- line 1: cwd -----------------------------------------------------
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
dir=$(echo "$cwd" | sed "s|^$HOME|~|")
[ -z "$dir" ] && dir="?"

# ---- line 2: context window usage -------------------------------------
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_used=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

if [ -n "$ctx_pct" ]; then
  if [ -n "$ctx_used" ] && [ -n "$ctx_size" ]; then
    tok_str=$(awk -v u="$ctx_used" -v s="$ctx_size" 'BEGIN{printf "%.0fK/%.0fK", u/1000, s/1000}')
    ctx_str=$(printf "Context %.0f%% (%s)" "$ctx_pct" "$tok_str")
  else
    ctx_str=$(printf "Context %.0f%%" "$ctx_pct")
  fi
else
  ctx_str="Context n/a"
fi

# ---- line 2: subscription usage limits --------------------------------
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

usage_str=""
if [ -n "$five" ]; then
  five_str="5h $(printf '%.0f' "$five")%"
  five_reset_str=$(fmt_reset "$five_resets")
  [ -n "$five_reset_str" ] && five_str="$five_str (resets ${five_reset_str})"
  usage_str="$five_str"
fi
if [ -n "$week" ]; then
  wk_str="7d $(printf '%.0f' "$week")%"
  wk_reset_str=$(fmt_reset "$week_resets")
  [ -n "$wk_reset_str" ] && wk_str="$wk_str (resets ${wk_reset_str})"
  if [ -n "$usage_str" ]; then
    usage_str="$usage_str  $wk_str"
  else
    usage_str="$wk_str"
  fi
fi
[ -z "$usage_str" ] && usage_str="usage n/a"

# ---- render (dimmed colors) --------------------------------------------
DIR_COLOR='\033[2;36m'   # dim cyan
CTX_COLOR='\033[2;33m'   # dim yellow
USE_COLOR='\033[2;35m'   # dim magenta
RESET='\033[0m'

printf "${DIR_COLOR}%s${RESET}\n" "$dir"
printf "${CTX_COLOR}%s${RESET}  ${USE_COLOR}%s${RESET}\n" "$ctx_str" "$usage_str"
