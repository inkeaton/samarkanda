#!/usr/bin/env bash

chosen=$(echo Power | rofi -dmenu -i -p "Fai la tua scelta:")

case "$chosen" in
	"  Spegni") poweroff ;;
	"  Riavvia") reboot ;;
	" Sospendi") systemctl suspend ;;
	*) exit 1 ;;
esac
