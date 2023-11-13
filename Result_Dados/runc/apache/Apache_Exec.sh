#!/bin/bash

mkdir -p ~/Downloads/Apachebench1_apache

c=0
for ((i=1; i<=30; i++)) do

	ab -t 300 -n 10000 -c 100 http://10.42.0.1:81/home > ~/Downloads/Apachebench1_apache/result_exec_$i.txt
	result=$(awk 'NR==18 {print $3}' ~/Downloads/Apachebench1_apache/result_exec_$i.txt)
	if [ $result -eq 0 ]; then
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Ubuntu_Apache_Runc.csv
			awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var, v}' ~/Downloads/Apachebench1_apache/result_exec_$i.txt >> Ubuntu_Apache_Runc.csv
			c=1
		else
                        awk -v var="$i," 'NR>=17 && NR<=20 {v = v $3 ","} END {sub(/,$/, "", v);} NR==21 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=22 && NR<=23 {v = v $4 ","} END {sub(/,$/, "", v);} NR==24 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench1_apache/result_exec_$i.txt >> Ubuntu_Apache_Runc.csv

		fi
	else
		if [ $c -eq 0 ]; then
			echo "Execucao,Complete requests,Failed requests,Total transferred,HTML transferred,Requests per second,Time per request,Time per request concorrencia,Transfer rate" | awk '{print}' > Ubuntu_Apache_Runc.csv
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=21 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench1_apache/result_exec_$i.txt >> Ubuntu_Apache_Runc.csv
			c=1
		else
			awk -v var="$i," 'NR>=17 && NR<=18 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=21 && NR<=22 {v = v $3 ","} END {sub(/,$/, "", v);} NR>=23 && NR<=25 {v = v $4 ","} END {sub(/,$/, "", v);} NR>=26 && NR<=26 {v = v $3 ","} END {sub(/,$/, "", v); print var,v}' ~/Downloads/Apachebench1_apache/result_exec_$i.txt >> Ubuntu_Apache_Runc.csv
		fi
	fi
done

