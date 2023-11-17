#!/bin/bash

mkdir -p ~/Downloads/Apachebench2_apache

c=0
for ((i=1; i<=30; i++)) do

	ab -t 300 -n 10000 -c 100 http://192.168.137.1:81/home > ~/Downloads/Apachebench2_apache/result_exec_$i.txt
	result=$(awk 'NR==18 {print $3}' ~/Downloads/Apachebench2_apache/result_exec_$i.txt)
	if [ $result -eq 0 ]; then
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Windows_Apache_wsl.csv
			awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var, v}' ~/Downloads/Apachebench2_apache/result_exec_$i.txt >> Windows_Apache_wsl.csv
			c=1
		else
                        awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_apache/result_exec_$i.txt >> Windows_Apache_wsl.csv

		fi
	else
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Windows_Apache_wsl.csv
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=21 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_apache/result_exec_$i.txt >> Windows_Apache_wsl.csv
			c=1
		else
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=21 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_apache/result_exec_$i.txt >> Windows_Apache_wsl.csv
		fi
	fi
done

