#!/bin/bash

while true; do
	if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 15 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ]; then
	    notify-send -u critical "¡BATERÍA BAJA!" "Conecta el cargador inmediatamente" 
	fi

	sleep 60
done
