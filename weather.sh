# User configurables below:
# Uncomment this line for fahrenheit:
metric='imperial' && unit='F'
# Otherwise comment above line, uncomment here for celcius:
# metric='metric' && unit='C'

# First, geolocate our IP:
ipinfo=$(curl -s ipinfo.io)
city=$(echo $ipinfo | jq -r '.city')
cityid=$(grep -m 1 "$city" ~/.i3/city.list.us.json | jq -r '._id')

weather=$(curl -s http://api.openweathermap.org/data/2.5/weather\?id=${cityid}\&units\=${metric}\&APPID\=$(cat ~/.i3/appid.txt))
temperature=$(printf '%s' $(echo $weather | jq '.main.temp'))
condition=$(echo $weather | jq -r '.weather[0].main')

echo $condition $temperature °$unit
