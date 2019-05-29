#!/bin/sh
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

while true; do
	xsetroot -name " $(disc) | $(cpu) | $(mem) | $(vol) | $(dte)"
	sleep 2s
done &

