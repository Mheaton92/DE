#!/bin/sh
dte(){
	dte=$(date +"%a %b %d %I:%M%p")
	echo -e "🕐 $dte"
}
mem(){
	mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 /1024.0, $2 / 1024.0 }'`
	echo -e "🖥 $mem"
}

cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	temp='sensors | awk '/Core 0/ {print$3}''
	echo -e "💻 $cpu% $tem ℃ "
}
disc(){
	home=`df -h /home --output=used,size | awk 'NR==2 {printf "%s/%s", $1, $2}'`
	root=`df -h / --output=used,size | awk 'NR==2 {printf "%s/%s", $1, $2}'`
	echo -e "⌂:$home /:$root"
}

while true; do
	xsetroot -name "$(disc) | $(cpu) | $(mem) | $(dte)"
	sleep 30s
done &

