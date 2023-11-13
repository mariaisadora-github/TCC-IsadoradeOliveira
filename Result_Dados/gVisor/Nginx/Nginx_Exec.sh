#!/bin/bash

mkdir -p ~/Downloads/Apachebench2_nginx

c=0
for ((i=1; i<=30; i++)) do

	ab -t 300 -n 10000 -c 100 http://10.42.0.1:80/home > ~/Downloads/Apachebench2_nginx/result_exec_$i.txt
	result=$(awk 'NR==18 {print $3}' ~/Downloads/Apachebench2_nginx/result_exec_$i.txt)
	if [ $result -eq 0 ]; then
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Ubuntu_Nginx_gVisor.csv
			awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var, v}' ~/Downloads/Apachebench2_nginx/result_exec_$i.txt >> Ubuntu_Nginx_gVisor.csv
			c=1
		else
                        awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_nginx/result_exec_$i.txt >> Ubuntu_Nginx_gVisor.csv

		fi
	else
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Ubuntu_Nginx_gVisor.csv
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=20 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_nginx/result_exec_$i.txt >> Ubuntu_Nginx_gVisor.csv
			c=1
		else
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=20 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench2_nginx/result_exec_$i.txt >> Ubuntu_Nginx_gVisor.csv
		fi
	fi
done

