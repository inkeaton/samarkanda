#!/bin/sh

nmcli -f IN-USE,SSID,BARS device wifi | awk '/^\*/{if (NR!=1) {print$2}}'