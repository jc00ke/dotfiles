#!/bin/sh
xrandr \
  --output DisplayPort-0 --primary --mode 3840x2160 --pos 0x840 --rotate normal \
  --output DisplayPort-1 --mode 3840x2160 --pos 3840x0 --rotate left \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --off
