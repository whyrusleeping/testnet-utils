#!/bin/bash

enable_latency() {
	iface=$1
	lat=$2
	opts=
	if [ -z $lat ]
	then
		lat=100ms
	fi
	if [ -n $3 ]
	then
		opts="$3 distribution normal"
	fi

	echo setting latency on $iface to $lat, opts = $opts
	tc qdisc add dev $iface root netem delay $lat $opts
}

disable_latency() {
	iface=$1
	tc qdisc del dev $iface root 
}

com=$1
shift
args=$@
for i in `ls /sys/devices/virtual/net | grep veth`
do
	case $com in
	on)
		enable_latency $i $args
		;;
	off)
		disable_latency $i
		;;
	*)
		echo "options are on and off"
		exit 1
	esac
done
