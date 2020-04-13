function toggle_displays
  set intern "eDP1"
  set extern "DP2-2"
  set xr (xrandr)

  if xrandr --listactivemonitors | grep -q $intern
    # switch to external
    _switch_to $intern $extern
  else
    # switch to laptop
    _switch_to $extern $intern
  end

  sleep 0.3
  nitrogen --restore
end

function _switch_to
  set off $argv[1]
  set on $argv[2]
  xrandr --output $off --off --output $on --auto
end
