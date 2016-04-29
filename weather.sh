#!/bin/bash
# User configurables below:
# Uncomment this line for fahrenheit:
metric='imperial' && unit='F'
# Otherwise comment above line, uncomment here for celcius:
# metric='metric' && unit='C'

# First, geolocate our IP:
ipinfo=$(curl -s ipinfo.io)

lat=$(printf '%.1f' `expr $(echo $ipinfo | jq -r '.loc') : '^\(.*\),'`)
long=$(printf '%.1f' `expr $(echo $ipinfo | jq -r '.loc') : '^.*[,]\(.*\)$'`)

city=$(echo $ipinfo | jq -r '.city')
cityid=$(grep "$city" ~/.i3/city.list.us.json | grep "\($lat\|$long\)" | jq -r '._id')

weather=$(curl -s http://api.openweathermap.org/data/2.5/weather\?id=${cityid}\&units\=${metric}\&APPID\=$(cat ~/.i3/appid.txt))
temperature=$(printf '%s' $(echo $weather | jq '.main.temp'))
condition=$(echo $weather | jq -r '.weather[0].main')

echo $condition $temperature °$unit
