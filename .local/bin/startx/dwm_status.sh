#!/bin/sh
testweather() { \
	[ "$(stat -c %y "$HOME/.local/share/weatherreport" 2>/dev/null | cut -d' ' -f1)" != "$(date '+%Y-%m-%d')" ] &&
		ping -q -c 1 1.1.1.1 >/dev/null &&
		curl -s "wttr.in/$location" > "$HOME/.local/share/weatherreport" &&
		notify-send "🌞 Weather" "New weather forecast for today." &&
		refbar
		}


dte(){
	dte=$(date +"%a %b %d %I:%M%p")
	echo -e "🕐 $dte"
}
mem(){
	mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 /1024.0, $2 / 1024.0 }'`
	echo -e " $mem"
}

cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	temp=$(sensors | awk '/Core 0/ {print$3}')
	echo -e "💻 $cpu%" "$temp℃"
}
disc(){
	home=`df -h /home --output=used,size | awk 'NR==2 {printf "%s/%s", $1, $2}'`
	root=`df -h / --output=used,size | awk 'NR==2 {printf "%s/%s", $1, $2}'`
	echo -e " :$home /:$root"
}
vol(){
	if [[ $(pulsemixer --get-mute) = "1" ]]; then
		volume= echo -e "🔇"
	else
		volume=$(pulsemixer --get-volume | awk '{print $1}') && echo -e "🔊 $volume"
	fi

}
wttr(){
	[ "$(stat -c %y "$HOME/.local/share/weatherreport" 2>/dev/null | cut -d' ' -f1)" = "$(date '+%Y-%m-%d')" ] &&
		sed '16q;d' "$HOME/.local/share/weatherreport" | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/ /g" | tr -d '\n' &&
		sed '13q;d' "$HOME/.local/share/weatherreport" | grep -o "m\\(-\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " ",$1 "°","",$2 "°"}'
}


while true; do
	xsetroot -name "$(wttr) | $(disc) | $(cpu) | $(vol) | $(dte)"
	testweather &
	sleep 1s
done &

