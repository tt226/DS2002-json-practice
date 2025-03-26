#!/bin/bash

curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > weather.json

jq -r '.[].receiptTime' weather.json | head -n 6

temp_list=$(jq -r '.[].temp' weather.json)

total_temp=0
num_temps=0

for temp in $temp_list; do
    total_temp=$(echo "$total_temp + $temp" | bc)   
    num_temps=$((num_temps + 1))  
done

if [[ $num_temps -gt 0 ]]; then
    avg_temp=$(echo "scale=2; $total_temp / $num_temps" | bc)  
else
    avg_temp="N/A"   
fi

echo "Average Temperature: $avg_temp"

cloudy_count=$(jq -r '.[].clouds' weather.json | grep -v "CLR" | wc -l)
total_reports=$(jq -r '.[].clouds' weather.json | wc -l)

if [[ $cloudy_count -gt $((total_reports / 2)) ]]; then
    cloudy_majority="Yes"
else
    cloudy_majority="No"
fi

echo "Mostly Cloudy: $cloudy_majority"
