# Docker

Introductory docker.

- [Overview](#overview)
- [Common commands](#common-commands)
- [Installing Docker](#installing-docker)
- [Docker registries](#docker-registries)
- [Images and containers](#images-and-containers)
- [Running](#running)
- [Installing software on containers](#installing-software-on-containers)
- [Networking](#networking)
- [Volumes](#volumes)
- [Dockerfiles](#dockerfiles)
- [Multiple containers](#multiple-containers)
  * [docker-compose](#docker-compose)

## Overview

First, docker isn't a virtual machine.
A container is a self contained unit of software comprising:

+ code
+ config
+ processes
+ networking

A container can talk with other containers.
You might have one container that runs redhat with a db and another container that has a web server running on it etc.

Docker sets things up, listens for commands, manages containers.

## Common commands

+ `docker images` list docker images 
+ `docker rmi <image id>` remove image by image id (see `docker images`)
+ `docker build -t mycontr .` build container, tag it mycontr use Docker file in pwd
+ `docker ps -a` docker process status (gives assigned names)
+ `docker exec -ti youthful_kalam bash` attach to running container having assigned name youthful_kalam
+ `docker run -p 8000:8000 --rm mycontr` run mycontr, expose int/ext port 8000, remove on exit
+ `docker run -it -p 8000:8000 --rm mycontr bash` run mycontr interactive, expose int/ext port 8000, remove on exit
+ `docker run -ti -v /data/randr:/share ubuntu bash` permanent store volume (files retained after container exited)
+ `docker stop $(docker ps -a -q)` stop all running containers
+ `curl -X POST "http://127.0.0.1:8000/add?x=2&y=10" -H "accept: */*" -d ""` do a http post
+ `curl -X GET "http://127.0.0.1:8000/echo?msg1=a&msg2=b"` do a http get
+ `curl -X GET "http://127.0.0.1:8000/add?x=2&y=10"` do a http get
+ `curl -X GET "http://127.0.0.1:8000/completerand?numbertrt=3&samplesize=3"`  do a http get
+ `localhost:8000/completerand?numbertrt=3&samplesize=3` url for browser test
+ `localhost:8000/completerand?foo=3&foo=2&foo=1&samplesize=10` url for browser test (using arrays) ?
+ `localhost:8000/completerand?weights=%5B0.5%2C%200.5%5D&samplesize=10` url for browser test (using json str arrays) ?

NOTE: You must set a container's main process to bind to the special `0.0.0.0` (all interfaces) address, or it will be unreachable from outside the container.
Outside the container, on your local machine, you would use `http://localhost:8000/ep` or `http://127.0.0.1:8000/ep`, which should be equivalent.


## Installing Docker

Docker needs a linux server to manage where it allows you to start and stop containers on this server as required.
On a linux platform, docker is just like any other program. 
The latest version of docker is docker-ce.

```
> sudo apt update
// and upgrade as req
> sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

// indicate that my comp can trust software from the docker org
// gets the key and pipes it into the keyring
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

// adds an official source of software for my machine
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
// and upgrade as req
sudo apt-get install docker-ce docker-ce-cli containerd.io

// status
sudo systemctl status docker

// test permissions (should fail)
docker ps -a 

// manage docker as non-root user
// https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker ${USER}
```

Now, you either need to restart/logout and then log back in or do:

```sh
$ su - $USER
$ clear
$ groups
should include docker
// should now work without having to sudo
// status of all the docker processes that are running
$ docker ps -a 

// test by running the hello-world container
$ docker run hello-world
```

## Docker registries

Registries manage and distribute images.
You can do `docker search ubuntu` to search for images with the word ubuntu.

```
> docker search ubuntu | head
NAME               DESCRIPTION                                STARS  OFFICIAL AUTOMATED
ubuntu             Ubuntu is a Debian-based Linux operating   11979  [OK]    
dorowu/ubuntu-d... Docker image to provide HTML5 VNC inter    509             [OK]
...
```

The top search result has the official flag verifying that this image is from ubuntu.
Generally it is better to use official images if you can.

If you have an account with docker, you can login from the command line with:

```
> docker login
Username: <username> 
Password: <passwd>
```

this will give a warning that your passwd is stored unecrypted at ~/.docker/config.json.

Use `docker logout` to logout.

After logging in, you can pull and push images, e.g.

```
// pull down an existing image
docker pull ubuntu
// create a copy
docker tag ubuntu <username>/<new_image_name>
// push your copied image up to the repo
docker push <username>/<new image name>
```

NOTE!! Do NOT push images that have your passwords in them!!!!

Example:

```
> docker pull ubuntu 
Using default tag: latest
latest: Pulling from library/ubuntu
5d3b2c2d21bb: Pull complete 
3fc2062ea667: Pull complete 
75adf526d75b: Pull complete 
Digest: sha256:b4f9e18267eb98998f6130342baacaeb9553f136142d40959a1b46d6401f0f2b
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest


> docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    d1165f221234   2 weeks ago   13.3kB
ubuntu        latest    4dd97cefde62   2 weeks ago   72.9MB
```

To remove an image just do 

```
> docker rmi f3897a3842e9
```

## Images and containers

Start with an image with just enough of an OS to do what you want to do.
To see the images are available on the machine do:

```
> docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    d1165f221234   2 weeks ago   13.3kB
ubuntu        latest    4dd97cefde62   2 weeks ago   72.9MB
```

to refer to a docker container you can use the image id.

`docker run` takes an image and turns it into a running container with some processes running in it.
Once started, the docker container will have its own id.
Hypothetical example:

```
<!-- ti indicates we want an interactive terminal -->
> docker run -ti ubuntu:latest bash
```

to exit, type `exit` or ctl-d.

We might do a bunch of stuff in a given container.
Then you can do a `docker commit` which writes the container as a new image.

For example, you might start up a container:

```
> docker run -to ubuntu bash
> cd \home
> touch MY-FILE
> exit
```

Now do:

```
> docker commit <id>
<!-- more complete is to do: -->
> docker commit <id> <my_image_name>:<ver_no>
```

where the <id> is the container id (not the image id).
You can tag with: 

```
> docker tag <sha hash> my_new_image
```

you can give your new image a name.

To remove an image do 

```
> docker rmi f3897a3842e9
```


## Running


`docker run` starts a container by giving an image name and a process to run in that container.
The container stops when the process stops.
Containers have one main process.

Example: start up ubuntu and kick off sleep for 2 secs.
Once the sleep is done, the container exits.

```
<!-- don't want to keep the container afterwards -->
> docker run --rm  -ti ubuntu bash -c "sleep 2; echo done"
```

If you want to leave things running, use a detached container.

```
// the -d starts it running in the background
> docker run -d -ti ubuntu bash
c03c3dfda099c8b3b84e1cc8a74525598575af05404ddaaf66c1514acaaf5bb0
// list the background process
> docker ps 
CONTAINER ID   IMAGE     COMMAND   CREATED          STATUS          PORTS     NAMES
c03c3dfda099   ubuntu    "bash"    27 seconds ago   Up 26 seconds             trusting_shaw
> docker attach trusting_shaw
// now you are back in the container...
// also put into background
// ctl p, ctl q
```

Adding another process to a running container for the purposes of debuggint etc.

```
// puts you in the same container but in another window
docker exec -ti trusting_shaw
```

Logging 

```
// this will crash
> docker run --name example -d ubuntu bash -c "lose /etc/password"
// what happened?
> docker logs example
bash: lose command not found
```

Make sure you clean up your containers!

```
> docker run -ti ubuntu bash
> docker kill fervent_mclean
> docker rm fervent_mclean
```

Limiting docker constraints.

```
> docker run --memory <max mem> <image-name> command
> docker run --cpu-shares 
> docker run --cpu-quota <limit>
```

Don't let your containers fetch dependencies when they start because at some point the dependencies will be lost -> build your dependencies in the image.


## Installing software on containers

```
> docker run ubuntu bash -c "apt-get -y update"
// run a terminal in container
> docker run -it ubuntu bash
// Next bit IMPORTANT!!! From container bash:
root> apt update
root> apt upgrade
root> apt install -y netcat && which nc
```

You now have netcat installed.
To run it just type `nc`.

Back on your machine's terminal, commit your changes:

```
> docker ps
CONTAINER ID   IMAGE     COMMAND   PORTS                                  NAMES
29611371e79e   ubuntu    "bash"    0.0.0.0:45678-45679->45678-45679/tcp   echoserv
# use the container id to create a new image:
> docker commit 29611371e79e
> docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
<none>        <none>    186b0ed52241   5 seconds ago   103MB
hello-world   latest    d1165f221234   2 weeks ago     13.3kB
ubuntu        latest    4dd97cefde62   2 weeks ago     72.9MB

> docker tag 186b0ed52241 ubuntu_nc
> docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
ubuntu_nc     latest    186b0ed52241   34 seconds ago   103MB
hello-world   latest    d1165f221234   2 weeks ago      13.3kB
ubuntu        latest    4dd97cefde62   2 weeks ago      72.9MB
```

## Networking

NOTE: You must set a container's main process to bind to the special `0.0.0.0` (all interfaces) address, or it will be unreachable from outside the container.
This means that when running an R `plumber` application, you need to 

Connecting containers together such that they can talk together and talk to the internet.
You can isolate some containers from others if you want.
You can publish ports to let docker containers be accessible from outside.

Example:

```
// -p internal port:external port, setting up two ports and run bash in container:
> docker run --rm -ti -p 45678:45678 -p 45679:45679 --name echoserv ubuntu bash
// Previously you installed netcat, if your container was already running then you won't have to reinstall
// Use nc to take in data and push it back
// Moving bits from one place to another - super simple
// Receive something and send it to another port and spit it out:
root> nc -lp 45678 | nc -lp 45679

// Go to a new terminal on your machine with nc installed
// Kick off a couple of clients
> netcat  127.0.0.1 45678
// In yet another shell
> netcat  127.0.0.1 45679
```

Now if you enter "testtest" into the first netcat client 45678, you will see it echoed at the 45679.

I can do the same thing from another container:

```
> docker run --rm -ti ubuntu_nc bash
// special localhost for docker.
root> nc host.docker.internal 45678
root> nc host.docker.internal 45679

// then you can do the same thing as we did before
```

Docker has networking options for controlling how containers connect to one another.

```
> docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
193df51a0536   bridge    bridge    local
7c413eca4f9f   host      host      local
5ee4dc9dcafc   none      null      local
```

The bridge is the network that is used by containers when they are not configured to use a specific network. 
Host is when you want no networking security (BAD IDEA).
And none is when you want to isolate the container from all networks.

```
\\ create new network
> docker network create learning
\\ we can use the name to communicate between containers
\\ spin up a couple of docker containers:
> docker run --rm -ti --net learning --name catserver ubuntu bash
> docker run --rm -ti --net learning --name dogserver ubuntu bash
\\ after installing inetutils-ping
> ping catserver
PING catserver (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: icmp_seq=0 ttl=64 time=0.073 ms
> ping dogserver
PING dogserver (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: icmp_seq=0 ttl=64 time=0.196 ms
```


## Volumes


Volumes are virtual disks where you can share data between containers.
You can set up a volume to be persistent or ephemeral.
Volumes are not part of an image; they are for your local data.

```
> mkdir test
/Documents/home/j/test
> docker run -ti -v /Documents/home/j/test:/share ubuntu bash
root> touch /share/testing.txt
root> exit
> ls test
testing.txt
```

The testing.txt file was retained after the container exited.

To create a shared folder dynamically that is ephemeral.

```
// container 1
> docker run -ti -v /share ubuntu bash
root> echo hi > /share/data1.txt
// container 2 - first get the name of container 1
> docker ps -l
> docker run -ti --volumes-from sick_hopper ubuntu bash
// can access the shared data
root> ls /share
root> echo helllo > /share/data2.txt
```

When you exit all the containers, the /share folder and all its data go away.


## Dockerfiles


A Dockerfile is a small program that will create an image.
To build the image:

```
> docker build -t <name of tag for image> <path to docker file> 
> docker build -t fred /home/j/dockertest/.
```

The next time you build, docker will look for cache and only update the build if the files have been updated.

Dockerfiles are not shell scripts.
Processes you start on one line, will not be running on the next line.
Environment variables do persist if you use the ENV command to set them.

A basic docker file has the name Dockerfile and looks like this:

```
FROM busybox
RUN echo "building simple docker image"
CMD echo "hello container"
```

build with:

```
> docker build -t hello .
Step 1/3 : FROM busybox
latest: Pulling from library/busybox
8b3d7e226fab: Pull complete 
Digest: sha256:ce2360d5189a033012fbad1635e037be86f23b65cfd676b436d0931af390a2ac
Status: Downloaded newer image for busybox:latest
 ---> a9d583973f65
Step 2/3 : RUN echo "building simple docker image"
 ---> Running in ee2551441083
building simple docker image
Removing intermediate container ee2551441083
 ---> c47afb9164f1
Step 3/3 : CMD echo "hello container"
 ---> Running in 0c27c99b594e
Removing intermediate container 0c27c99b594e
 ---> b2b7d13667c6
Successfully built b2b7d13667c6
Successfully tagged hello:latest
```

Now we have a new image:

```
docker images
REPOSITORY    TAG       IMAGE ID       CREATED              SIZE
hello         latest    b2b7d13667c6   About a minute ago   1.23MB
```

Run it with 

```
> docker run --rm hello
hello container
```

Now, let's create a dockerfile that installs some software then kicks of the application.

```
> vim Dockerfile
FROM debian:sid
RUN apt-get -y update
RUN apt-get -y install nano
CMD ["bin/nano", "/tmp/notes.txt"]
> docker build -t nanoer .
<!-- run the container -->
<!-- you do not need to append the bash because the command is baked into the image-->
> docker run --rm -ti nanoer
```

You can chain docker files to work incrementally.
This starts from the nanoer image created above.
When this container starts we open our a notes.txt file that was setup on the local machine prior to building the docker image.

```
> vim Dockerfile
FROM nanoer
ADD notes.txt /notes.txt
CMD ["/bin/nano", "/tmp/notes"]
```

Other docker keywords include (also see Dockerfile ref page):

+ MAINTAINER firstname lastname email
+ RUN unzip install.zip /opt/install
+ ADD run.sh /run.sh
+ ADD project.tar.gz /install/   <!-- uncompress tar file -->
+ ENV DBHOST=db.prod.example.com <!-- set env vars for build and image -->
+ ENTRYPOINT <!-- start of the command to run -->
+ CMD <!-- whole command to run. this is what you should use -->
+ CMD nano notes.txt
+ CMD ["/bin/nano", "nano.txt"] <!-- slightly more efficient -->
+ EXPOSE 8080 <!-- maps a port into the container -->
+ VOLUME ["/share"] <!-- shared or ephem vols as shown earlier -->
+ WORKDIR <!-- sets the dir that the container starts in -->
+ WORKDIR /install/ <!-- all the rest of the run statements will run in /install like cd -->
+ USER arthur <!-- for specifying a fixed username -->


We want docker images to be complete but small. 
Docker recently added a feature that lets you have multi-stage builds.

## Multiple containers

When you have a heap of containers, orchestration can become unwieldy.
Docker compose helps you manage by allowing you to coordinate multi-container environments based on a YAML config file.

### docker-compose

Get it from github and update file flags to executable.

```
> sudo curl -L "https://github.com/docker/compose/releases/download/<current stable version>/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
> sudo chmod +x /usr/local/bin/docker-compose
> docker-compose --version
```

Example: YAML file `docker-compose.yml` 

```
version: '3.7'
services:
  web:
    image: nginx:alpine
    ports:
      - "8000:80"
    volumes:
      - ./app:/usr/share/nginx/html
```

Note that the indentation is important.
The `services` block to define all the various components/containers.
Build an bring up the service:

```
docker-compose build
docker-compose up
```

Similar to the `docker` command you have 

```
docker-compose ps
docker-compose logs
docker-compose stop
docker-compose down   - remove all containers, networks, vols
```



