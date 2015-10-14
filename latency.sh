#!/bin/bash

enable_latency() {
	iface=$1
	lat=$2
	tc qdisc add dev $iface root netem delay $lat
}

disable_latency() {
	iface=$1
	tc qdisc del dev $iface root 
}

com=$1
for i in `ls /sys/devices/virtual/net | grep veth`
do
	case $com in
	on)
		enable_latency $i 50ms
		;;
	off)
		disable_latency $i
		;;
	*)
		echo "options are on and off"
		exit 1
	esac
done
