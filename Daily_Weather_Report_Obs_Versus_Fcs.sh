#include shebang directive to make this as a executable file.
#! /bin/bash

#create an empty file to capture the data requested on a daily basis.
touch weather_rpt_poc.log

#create the header for the above file.
header=$(echo -e "year\tmonth\tday\thour\tobs_tmp\tfc_temp")
echo $header>weather_rpt_poc.log

#create empty daily file and name it with today's date.
today=$(date +%Y%m%d)
weather_report=raw_data_$today

#download daily data from the target website

city=Casablanca
curl wttr.in/$city --output $weather_report

#extract the lines containing the temperatures into another text file.
grep °C $weather_report > temperatures.txt

#Extract the current temperature, and store it in a shell variable called obs_tmp
obs_tmp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev)

#Extract tomorrow’s temperature forecast for noon, and store it in a shell variable called fc_tmp
fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 | rev)

#Store the current hour, day, month, and year in corresponding shell variables. The timezone TZ is set to the city we are interested in, then it fetches the current hr, day, month and year of the selected timezone.
hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

#finally store the daily report in the log file that was created in the first step. append the record to weather_rpt_poc.log
record=$(echo -e "$year\t$month\t$day\t$hour\t$obs_tmp\t$fc_temp")
echo $record>>weather_rpt_poc.log