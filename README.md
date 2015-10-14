#testnet-utils

Right now, this is just a set of shell scripts to control network conditions
between docker containers. In the future, I might make this an actual binary
or something.

## Usage
```
$ sudo ./latency on # defaults to 50ms delay per link -> 100ms rtt
$ sudo ./latency off
$ sudo ./latency on 150ms
$ sudo ./latency on 150ms 10ms # adds a 10ms jitter, normally distributed
```

## Try it out
Clone the script down, and make sure docker is running, then:
```
$ docker pull ubuntu
```

Now, run this twice, in two separate terminals:
```
$ docker run -ti ubuntu /bin/bash
```

In one of them, use `ip addr` to find its ip, and then ping that ip from the
other container. It should be quite low, less than 0.1ms.

Now, on the host, run:
```
$ sudo ./latency.sh on
```

You should see the rtt of the pings spike to 100ms

Then try:
```
$ sudo ./latency off
```

And it will return to normal.

You can also specify your own (as seen above):
```
$ sudo ./latency on 20ms
```
This will set a 20ms delay on *each* link, meaning the total RTT will be 40ms.

Having the same exact latency constantly isnt really how real network work, so
if you like, you can throw in some jitter:
```
$ sudo ./latency on 50ms 5ms
```

This will add a 5ms jitter to each link, based on a normal distribution, meaning
that the total RTT between the nodes should be from 90ms to 110ms

