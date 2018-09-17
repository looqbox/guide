# Home

<p align="center">
  <img src="https://s3-sa-east-1.amazonaws.com/looqbox/github-images/question.gif" width="500">
</p>

## Introduction

## Installation

Looqbox must be installed in a Linux distribution that supports docker (e.g. Ubuntu 18.04 LTS).

To start the container, run:
```
docker run -d --restart=always --name=looqbox-instance -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```

### Available parameters

| Parameter | Description |
|------|------|
| ```-e XMX="-Xmx512m"``` | change maximum heap |
| ```-e XMS="-Xms512m"``` | change minimum heap |
| ```-e PORT``` | change Looqbox's port (default 80) |
| ```-e PROXY_HOST="<ip>"``` | when parameter exists, use host as proxy (must define proxy_port as well) |
| ```-e PROXY_PORT="<port>"``` | when parameter exists, use port as proxy (must define proxy_host as well) |

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

### Libraries

In order to develop a script for Looqbox you should use our Looqbox Package. The package allows you to interact with the interface and help you structure your data to be displayed in our client.

```R
library(looqbox)
```

### Looq Response

This block is where your script will start the execution, simulating a main function. Inside it, you should use `looq.lookTag()`  to receive the value inside a looqbox tag from parser

In this case, we are creating a looqbox standard message box and storing it in msg variable. In the first parameter we're passing a `paste` with the string collected above. The second parameter is the style type to display the box. 

Finally, we are creating a looqbox frame to be placed inside a board with `looq.responseFrame()`

```R
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
```

### Testing

This block is used to test your response from **RStudio**, allowing you to simulate our parser and test your script without saving it in Looqbox client. If you have configured your Looqbox addin correctly, you can run your script using **Ctrl + Shift + S** and it will be displayed in your client.

```R
looq.testQuestion(
  list(
    "$quotes" = "My test sentence"
  )
)
```

### Add to your client

<!-- Write about responses with a good image -->

You can find the complete script in our [Github](/templates/helloWorld.R) or copy the code below. 

```R
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

Are you ready to learn more about Looqbox? Click [here](/implementation) to continue.
