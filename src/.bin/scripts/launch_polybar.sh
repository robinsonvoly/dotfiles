# kill running polybars
killall -q polybar

# wait
while pgrep -x polybar > /dev/null; do sleep 1; done

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload rob &
	done
else
	polybar --reload rob &
fi
