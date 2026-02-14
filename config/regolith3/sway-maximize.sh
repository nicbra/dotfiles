#!/usr/bin/env bash
set -euo pipefail

# Requires: swaymsg, jq
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/sway-pseudomax"
mkdir -p "$STATE_DIR"

tree="$(swaymsg -t get_tree -r)"
focused="$(jq -r '.. | objects | select(.focused? == true) | .id' <<<"$tree")"

# Focused node info
node="$(jq -r ".. | objects | select(.id? == $focused)" <<<"$tree")"
floating="$(jq -r '.floating // "user_off"' <<<"$node")"
x="$(jq -r '.rect.x' <<<"$node")"
y="$(jq -r '.rect.y' <<<"$node")"
w="$(jq -r '.rect.width' <<<"$node")"
h="$(jq -r '.rect.height' <<<"$node")"

state_file="$STATE_DIR/${focused}.json"

# If state exists => restore
if [[ -f "$state_file" ]]; then
  prev="$(cat "$state_file")"
  prev_floating="$(jq -r '.floating' <<<"$prev")"
  prev_x="$(jq -r '.x' <<<"$prev")"
  prev_y="$(jq -r '.y' <<<"$prev")"
  prev_w="$(jq -r '.w' <<<"$prev")"
  prev_h="$(jq -r '.h' <<<"$prev")"

  # Restore floating state
  if [[ "$prev_floating" == "user_on" || "$prev_floating" == "auto_on" ]]; then
    swaymsg "[con_id=$focused]" floating enable >/dev/null
    swaymsg "[con_id=$focused]" move position "$prev_x" "$prev_y" >/dev/null
    swaymsg "[con_id=$focused]" resize set width "$prev_w" px height "$prev_h" px >/dev/null
  else
    swaymsg "[con_id=$focused]" floating disable >/dev/null
  fi

  rm -f "$state_file"
  exit 0
fi

# Otherwise => save current state, then pseudo-maximize
jq -n \
  --arg floating "$floating" \
  --argjson x "$x" --argjson y "$y" --argjson w "$w" --argjson h "$h" \
  '{floating:$floating,x:$x,y:$y,w:$w,h:$h}' >"$state_file"

# Make it pseudo-maximized: float + fill output
swaymsg "[con_id=$focused]" floating enable >/dev/null
swaymsg "[con_id=$focused]" move position 0 0 >/dev/null
swaymsg "[con_id=$focused]" resize set width 100 ppt height 100 ppt >/dev/null
