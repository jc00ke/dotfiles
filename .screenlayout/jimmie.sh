#!/bin/sh
xrandr \
  --output DisplayPort-0 --mode 3840x2160 --pos 0x0 --rotate left \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --mode 3840x2160 --pos 2160x330 --rotate normal --primary
