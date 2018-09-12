```
  _                       _                 _   _                 _____       _     _      
 | |                     | |               | | | |               |  __ \     (_)   | |     
 | |     ___   ___   __ _| |__   _____  __ | | | |___  ___ _ __  | |  \/_   _ _  __| | ___ 
 | |    / _ \ / _ \ / _` | '_ \ / _ \ \/ / | | | / __|/ _ \ '__| | | __| | | | |/ _` |/ _ \
 | |___| (_) | (_) | (_| | |_) | (_) >  <  | |_| \__ \  __/ |    | |_\ \ |_| | | (_| |  __/
 \_____/\___/ \___/ \__, |_.__/ \___/_/\_\  \___/|___/\___|_|     \____/\__,_|_|\__,_|\___|
                       | |                                                                 
                       |_| 
```

<p align="center">
  <img src="https://s3-sa-east-1.amazonaws.com/looqbox/github-images/question.gif" width="500">
</p>


## Table of content
- [Introduction](#introduction)
- [Installation](#installation)
- [First steps](#first-steps)
- [Implementation](/implementation/README.md)

## Introduction

## Installation

Looqbox must be installed in a Linux distribution that supports docker (e.g. Ubuntu 18.04 LTS).

To start the container, run:
```
docker run -d --restart=always --name=looqbox-instance -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```

Other available parameters:

|parameter|description|
|------|------|
|```-e XMX="-Xmx512m"```|change maximum heap|
|```-e XMS="-Xms512m"```|change minimum heap|
|```-e PORT```|change Looqbox's port (default 80)|
|```-e PROXY_HOST="<ip>"```|when parameter exists, use host as proxy (must define proxy_port as well)|
|```-e PROXY_PORT="<port>"```|when parameter exists, use port as proxy (must define proxy_host as well)|

All script files and configurations are backed up in Looqbox's Cloud. To transfer all your work between your local machine and a server, all you need to do is rerun the docker command above. It will automatically download all files to the new instance.

To check if looqbox started correctly, run: 
```
docker logs -f --tail 200 looqbox-instance
```
Expected result:
<p align="center">
  <img src="https://s3-sa-east-1.amazonaws.com/looqbox/github-images/logs-successful-start.png" width="469">
</p>



To update Looqbox and Looqbox's R package, pull the image's newest version and start a new container.


## First steps

After completing this section you'll be able to run your first script inside Looqbox.

<!--

- Admin panel 
- Response panel
- Create response
- copy hello world template and add there
- test scripts
- there you have it, hurray

-->

Are you ready to learn more about Looqbox? Click [here](/implementation/README.md) to continue.
