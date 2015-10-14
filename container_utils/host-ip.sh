#!/bin/bash
/sbin/ip route | awk '/default/ { print $3 }'
