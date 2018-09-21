# Home

<p align="center">
  <img src="https://s3-sa-east-1.amazonaws.com/looqbox/github-images/question.gif" width="500">
</p>

## Introduction

## Installation

Looqbox must be installed in a Linux distribution that supports docker (e.g. Ubuntu 18.04 LTS).

After <a href="https://docs.docker.com/install/" target="_blank">installing docker</a>, start Looqbox's container:


```bash
docker run -d --restart=always --name=looqbox-instance -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```
To check if looqbox started correctly, run: 
```
docker logs -f --tail 200 looqbox-instance
```
Expected result:
<p align="center">
  <img src="https://s3-sa-east-1.amazonaws.com/looqbox/github-images/logs-successful-start.png" width="469">
</p>

You can now access looqbox in port 80 (if it's a local instalation: <a href="http://localhost:80/" target="_blank">localhost</a>)

### Available parameters

| Parameter | Description |
|------|------|
| ```-e XMX="-Xmx512m"``` | change maximum heap |
| ```-e XMS="-Xms512m"``` | change minimum heap |
| ```-e PORT``` | change Looqbox's port (default 80) |
| ```-e PROXY_HOST="<ip>"``` | when parameter exists, use host as proxy (must define proxy_port as well) |
| ```-e PROXY_PORT="<port>"``` | when parameter exists, use port as proxy (must define proxy_host as well) |

All script files and configurations are backed up in Looqbox's Cloud. To transfer all your work between your local machine and a server, all you need to do is rerun the docker command above. It will automatically download all files to the new instance.



To update Looqbox and Looqbox's R package, pull the image's newest version and start a new container.

## Your first script

1. Click in settings in the right upper corner and then in Admin.
2. Find Responses and click it.
3. Press `New +` button and fill it with the following fields:
    - **Response Name:** helloWorld
    - **Response Group:** admin
    - **Language:** pt-br
    - **Keyword:**
        - hello
        - world
        - script
        - $quotes
    - **Example:** hello world script "this is my first script"
4. Press the green button `Create new` at the botton.
5. Find `Response Files` and press `new` in `main file missing (new)`.
6. Press `+ show editor` button.
7. Copy the complete script in our [Github](/templates/helloWorld.R) or copy the code below, paste it and press `save` button. 
8. Click at Looqbox image and type **hello world script "any message that you want"**. If the return was a message green box with the message *Hurray, my installation is working!!* in the first line and the message you wrote in the second line, your installation is complete.

```looqbox
# In order to develop a script for Looqbox you should use our Looqbox Package.
# The package allows you to interact with the interface and help you structure
# your data to be displayed in our client.
library(looqbox)

#-----------------------------------------------------------------------------#
#---  Response
#---
#--- This block is where your script will start the execution, simulating a 
#--- main function. Inside it, you should set your parameters got from parser
#-----------------------------------------------------------------------------#
looq.response <- function(par) {
  
  # Receives the value inside a looqbox tag. In this case, we're looking for 
  # $quotes tag and storing it in quotes
  quotes <- looq.lookTag("$quotes", par)
  
  # Creates a looqbox standard message box and store it in msg variable. In
  # the first parameter we're passing a paste with the string collected above
  # the second parameter is the style type to display the box. 
  msg <- looq.objMessage(
    paste("Hurray, my installation is working!!\n", quotes),
    "alert-success"
  )
  
  # Creates a looqbox frame to be placed inside a board
  looq.responseFrame(msg)
}

#-----------------------------------------------------------------------------#
#--- Test Block
#
#--- This block is used to test your response, allowing you to simulate our
#--- parser and test your script without saving it in Looqbox client.
#---
#--- If you have configured your Looqbox addin correctly, you can run your 
#--- script using Ctrl + Shift + S and it will be displayed in your client.
#-----------------------------------------------------------------------------#
looq.testQuestion(
  list(
    "$quotes" = "My test sentence"
  )
)
```
<br>
#### Are you ready to learn more about Looqbox? Click [here](/implementation) to continue.
