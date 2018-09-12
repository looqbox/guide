# In order to develop a script for Looqbox you should use our Looqbox Package.
# The package allows you to interact with the interface and help you structure
# your data to be displayed in our client.
library(looqbox)

#-----------------------------------------------------------------------------#
#---  Response
#---
#--- This block is where your script will start the execution, simullating a 
#--- main function. Inside it, you should set your parameters got from parser
#-----------------------------------------------------------------------------#
looq.response <- function(par) {
  
  # Receives the value inside a looqbox tag. In this case, we're looking for 
  # $date tag and storing it in dateInt
  dateInt <- looq.lookTag("$date", par)
  
  # Creates a looqbox standard message box and store it in msg variable. In
  # the first parameter we're passing a paste with the date collected above
  # the second parameter is the style type to display the box. 
  msg <- looq.objMessage(
    paste("Hello World !!\n", dateInt[[1]][1], "and", dateInt[[1]][2]),
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
#--- script using ctrl + shift + s and it will be displayed in your client.
#-----------------------------------------------------------------------------#
looq.testQuestion(
  list(
    "$date" = list(c(Sys.Date() - 1, Sys.Date()))
  )
)