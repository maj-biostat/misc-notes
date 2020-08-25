# Network (Ubuntu centric)

## IP lookup

```
dig facebook.com

; <<>> DiG 9.16.1-Ubuntu <<>> facebook.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2453
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;facebook.com.			IN	A

;; ANSWER SECTION:
facebook.com.		246	IN	A	157.240.8.35

;; Query time: 19 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Tue Aug 25 14:34:26 AWST 2020
;; MSG SIZE  rcvd: 57

```

Enter `157.240.8.35` in chrome to head to facebook.

## Packet tracing

`tcpdump` prints out a description of the contents of packets on network interfaces.
It is useful for diagnostics.

Find out which interfaces are available (`any` allows capture in any active interface):

```
sudo tcpdump -D
1.wlp112s0 [Up, Running]
2.lo [Up, Running, Loopback]
3.any (Pseudo-device that captures on all interfaces) [Up, Running]
4.eno1 [Up]
5.bluetooth-monitor (Bluetooth Linux Monitor) [none]
6.nflog (Linux netfilter log (NFLOG) interface) [none]
7.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
8.bluetooth0 (Bluetooth adapter number 0) [none]
```

Start tracing with `tcpdump -i any` (stop with `ctl-c`).

To look at traffic headers to a designated host, first identify the host IP with `dig` (see above). 
Next, do:

```
sudo tcpdump -i any -nn host 157.240.8.35
```
and then navigate to facebook in your browser, which will result in a whole bunch of outout from tcpdump.

You can use the `-A` option to get the full packet in ascii format (`-x` for hex) and `-w filename.txt` will save the output to a file instead of displaying to screen.


## Wireshark (Packet tracing)

Wireshark is a GUI based app that also lets you trace network traffic.







