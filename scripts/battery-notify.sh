#!/bin/bash

while true; do
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$status" == "Discharging" ]]; then
        if [[ "$capacity" -le 5 ]]; then
            notify-send -u critical "WHERE DA DAM CHARGER!!!!👺🫨" "${capacity}%"
        elif [[ "$capacity" -le 10 ]]; then
            notify-send -u critical "TS going on life support😵‍💫" "${capacity}%"
        elif [[ "$capacity" -le 15 ]]; then
            notify-send -u normal "Ringup the pikachu!⚡" "${capacity}%"
        elif [[ "$capacity" -le 20 ]]; then
            notify-send -u normal "Watchout for the juice brotha😉" "${capacity}%"
        fi
    fi

    sleep 60
done
