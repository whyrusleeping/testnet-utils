#testnet-utils

Right now, this is just a set of shell scripts to control network conditions
between docker containers. In the future, I might make this an actual binary
or something.

## Installation
Requires permissions to write to `/usr/bin`
```
$ make install
```

## Usage
Note: all commands require root permission. I use this tool in a VM and have
setuid on the `tc` tool.

```
$ ctrlnet lat 150ms
$ ctrlnet lat off
$ ctrlnet lat 150ms 10ms # adds a 10ms jitter, normally distributed
$ ctrlnet rate 10mbit  # set 5mbit bandwidth cap
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
$ ctrlnet lat 40ms
```

You should see the rtt of the pings spike to 100ms

Then try:
```
$ ctrlnet lat off
```

And it will return to normal. 

You can also specify your own (as seen above):
```
$ ctrlnet lat 20ms
```
This will set a 20ms delay on *each* link, meaning the total RTT will be 40ms.

Having the same exact latency constantly isnt really how real network work, so
if you like, you can throw in some jitter:
```
$ ctrlnet lat 50ms 5ms
```

This will add a 5ms jitter to each link, based on a normal distribution, meaning
that the total RTT between the nodes should be from 90ms to 110ms
