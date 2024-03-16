#!/bin/sh

if [ $(nmcli radio wifi | awk '/led/ {print}') = 'enabled'  ] ; then
  nmcli radio wifi off
else
  nmcli radio wifi on
fi
