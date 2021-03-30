# curl

curl is a utility and library which can be used to receive and send data between a client and a server or any two machines connected over the internet. 
Amongst others, it supports the HTTP, FTP, IMAP, LDAP, POP3, SMTP protocols.

- [Config](#config)
- 

## Common commands

In verbose mode `>` prefix indicates part of req, `<` denotes response.

+ `curl -v http://www.example.com/` verbose mode
+ `curl -v http://localhost:8082/ep1` get to port 8082 to endpoint1
+ `curl -L http://blah` follow a redirect
+ `curl -L -i http://blah` view the http response header
+ `curl -d "x=2&y=3" http://blah` send data as POST request
+ `curl -X POST ...` to explicitly set the request type (GET, POST etc)

## Useful sites

+ [httpbin.org](httpbin.org)
+ [URL encoding - special characters](https://en.wikipedia.org/wiki/Percent-encoding)

## Install

```
sudo apt update
sudo apt install curl
sudo apt install libcurl4-openssl-dev
```

`libcurl4-openssl-dev` for building apps against `libcurl`

## Note on http

curl is often used to send http requests.
http requests comprise the request method, url, header and data.
http response have a similar structure, but also contain a status code.
The most common requests are GET and POST with GET used to 'get' something from the server and 'post' used to submit data for processing.
http sits on top of tcp and https using ssl.

## Downloading files

Specify the `-o` (output) option

```sh
$ curl -o vlc.dmg http://.../vlc-3.dmg
```

resume with `-C`: `curl -o out.txt -C http://...`

## Headers

Use the `-H` option `curl -H 'My-Head: 123' http://blah`.
Use [httpbin.org](httpbin.org) to see the request you sent.

Override can also be used to replace default headers such as User-Agent and Host.

## Data

Data is sent using `-d` option with all fields as key/value pairs separated with `&`.
Special characters need to be URL encoded.

To send JSON data you need to update the header `-H 'Content-Type: application/json'`.

```json
{
  "x": 2,
  "y": 3
}
```

```sh
$ curl -d '{"x": 2, "y": 3}' -H 'Content-Type: application/json' http://blah
```

## Disable certificates

To avoid making requests with self-signed certs; `k` disable cert check.

```
$ curl -k https://blah
```


## Basic authentication

This is just username/passwd.



