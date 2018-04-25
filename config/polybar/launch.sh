#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
DISPLAY1="$(xrandr -q | grep 'eDP1\|VGA-1' | cut -d ' ' -f1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY1" polybar topbar
echo "Bars launched..."
