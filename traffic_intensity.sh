#!/bin/sh

#Input
IP="$1"
alg="$2" # noAQM, iRED, iRED_delay CoDel, PI2
speed="$3" #120Mbps, 200Mbps or 1Gbps
Total_duration=480
Duration_phase2=$(( Total_duration - 120 ))
Duration_phase3=$(( Total_duration - 240 ))
Duration_phase4=$(( Total_duration - 360 ))

#Starting experiment
echo "Starting the experiment ..."

echo "Running phase 1 ..."
timeout $Total_duration ./ping_csv.sh 10.0.0.7 > logs/$alg/$speed/log_ping-Total_duration.txt &
iperf -c $IP -t $Total_duration -i 1 -f m > logs/$alg/$speed/log_iperf-Total_duration.txt &

echo "Waiting for 120 secs ..."
sleep 120

echo "Running phase 2 ..."
iperf -c $IP -P 4 -t $Duration_phase2 -i 1 -f m > logs/$alg/$speed/log_iperf-Duration_phase2.txt &

echo "Waiting for 120 secs ..."
sleep 120

echo "Running phase 3 ..."
iperf -c $IP -P 20 -t $Duration_phase3 -i 1 -f m > logs/$alg/$speed/log_iperf-Duration_phase3.txt &

echo "Waiting for 120 secs ..."
sleep 120

echo "Running phase 4 ..."
iperf -c $IP -P 50 -t $Duration_phase4 -i 1 -f m > logs/$alg/$speed/log_iperf-Duration_phase4.txt &

echo "Waiting for 120 secs ..."
sleep 120

#End of experiment
echo "End of the experiment"