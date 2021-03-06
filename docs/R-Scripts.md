# R Scripts 

> This tutorial assumes you don't have any previous knowledge in the Looqbox Package.

<!--
## Prerequisites

- R knowledge
-->

## Setup for the Tutorial

This documentation's objective is to introduce you to the guidelines for creating organized and efficient R scripts for Looqbox as well as to make you confortable with the looqbox package and with the tool's environment and workflow. In this section we will focus on the creation and editing of the R scripts, so we recomend using Rstudio as the development environment.

You can either write the code in your RStudio Serve, or you can set up a local development environment on your computer and use your local RStudio.

### Using Looqbox Dev Docker Container

This option is a docker running with a local RStudio linked with your Looqbox-dev folder.
First of all you need to install Docker in your local machine. More in [docker official site](https://www.docker.com/get-started).

After installing docker you need to have a looqbox-dev folder in your machine.

With the docker and the looqbox-dev folder installed you only need to execute these commands:
  - `docker pull looqboxrep/looqbox-dev` to pull the image, use the default looqbox login to pull.
  - `docker run -d --restart=always -v $HOME/looqbox-dev/config:/home/rstudio/looqbox -p 8787:8787 looqboxrep/looqbox-dev`. This command will set a local RStudio at port 8787 and will link to your config folder files in the _-v_ command. 

To open your local RStudio you only have to access localhost:8787 in your browser!

### RStudio Serve Setup

This is the quickest way to get started!

Open your looqbox instance on port 8787 (usually: [http://localhost:8787](http://localhost:8787)), enter **rstudio** as username and the **password** you created in the [installation](#installation) and you're almost ready to go.

Under addins, select Looqbox and enter your looqbox **username** and **host** (if they're not already there).

<br/>
<div align="center">
  <img src="../img/addin.png" width="500" style="box-shadow: inset 0 1px 0 rgba(255,255,255,0.6), 0 5px 15px 2px rgba(0,0,0,0.15), 0 0 0 1px rgba(0, 0, 0, 0.0);">
  <p></p>
</div> 
<br/>

It is also recomended to have Looqbox opened on another tab, as your tests will be published there.

You now have everything you need to begin, go ahead to the [basics section](#basics).

## Basics

### Script sctructure

In this section, you'll learn about the structure in which your script should be implemented.

#### Dependencies

In order to develop a script for Looqbox you should use our Looqbox Package as it allows you to interact with the interface and helps you structure your data to be displayed in our environment.

```looqbox
library("looqbox")
```

#### get_data

This user defined functions is the core of the script, we keep in it all of the data retrieval and manipulation. In it we also receive as parameters the entities collected from the parser and create the objects and vizualizations which will become our response. 
This function exists to keep the next block (looq.response) as clean and lean as possible.

```looqbox
get_data <- function(dateInt, parameter, value){

	sql <- "
	    SELECT
		EXAMPLE AS Col1,
		TEST AS Col2,
		FIELD AS Col3,
		DATE AS Date
	    FROM example.table
	    WHERE 1=1           
		AND Date >= DATE_ADD(`1`, INTERVAL +3 HOUR) 
		AND Date < DATE_ADD(`2`, INTERVAL +3 HOUR)
		AND PARAMETER = `3`
		AND VALUE = `4`
	    ORDER BY DATE DESC"

	r <- looq.sqlExecute("myDB", sql, list(dateInt[1], dateInt[2], parameter, value))
	if(r$rows == 0) return(paste("No data found from:\n", dateInt[1], "to", dateInt[2]))

	r$total <- list(
		"Col1" = "Total",
		"Col2" = sum(r$data$Col2)
	)

	r$searcheable <- T
	r$paginationSize <- 25

	r
}
```

Above we have a good example of a generic `get_data` function, it receives some parameters, executes a query that uses them and creates a Looqbox table with a total line, searchbar and pagination. In this case the return is simply *r*(the `looq.objectTable`) because we assume `looq.map` will be used to call `get_data` in the `looq.response` block.

Don't worry if you still can't understand what each of these functions do, we have a section dedicated entirely to their study.

#### looq.response

This block is where your script's execution will start, it's a S3 object and resembles the common main function. Inside it, you should use `looq.lookTag()`  to receive the value inside a looqbox tag from the parser.

In this sample, we are creating a looqbox standard message box and storing it in the `msg` variable. In the first parameter we `paste` a string and the `quotes` entity's value, which was received from the parser. The second parameter message's style type(we will present the options later. 

Finally, we are creating a looqbox frame with `looq.responseFrame()`, and so, creating a Looqbox intelligible board.

```looqbox
looq.response <- function(par) {
  
  # Receives the value inside a looqbox tag. In this case, we're looking for 
  # $quotes tag and storing it in quotes
  quotes <- looq.lookTag("$quotes", par)
  
  # Creates a looqbox standard message box and stores it in msg variable. In
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

#### Test Block

This block is a S3 object and is used to test your response from **RStudio**, allowing you to simulate our parser and test your script without saving it in Looqbox client. If you have configured your Looqbox addin correctly, you can run your script using **Ctrl + Shift + S** and it will be published to your client.

In this block you should assign test values to any entities that your script calls for.  

```looqbox
looq.testQuestion(
  list(
    "$quotes" = "My test sentence"
  )
)
```

### Essential functions

Now that you have a general understanding of how a script is properly constructed, let us go over a few of the package's most important functions. 

NOTE: In this material we'll be working with practical examples. If you wish to understand the full depth and parameters of each of these functions please refer to the package documentation.

#### looq.lookTag

Normally, the first thing your code will do once it enters your `looq.response()`(main) function, is receive information from the parser (in JSON format). From this, we have to extract information such as entities and tags, which will be used as parameters in `get_data()`. 

- `looq.lookTag()` acomplishes this task, searching for specific tags and returning their values.

```looqbox
company <- looq.lookTag("$company", par)
```
In the example above, `looq.lookTag` takes two parameters:

- `"$company"`: The entity or pattern it will search for. 
- `par`: the parser string, as received by `looq.response(par)` 

It will then, return the company value and assign it to the variable `company`.

If a certain value is an optional parameter for a question, `looq.lookTag()` also accepts a third parameter for setting a default value (should be a list). 

```looqbox
date <- looq.lookTag("$date", par, list(c('2018-01-01', '2019-01-01')))
```
In the code above, if no `$date` value is recognised by the parser it will choose the default, in this case, the period starting yesterday and ending today (whenever that is).

#### looq.map
This function is, perhaps, the core of the whole script.

```looqbox
looq.map(get_data, date, company)
```
What it does is fairly simple, the first argument is your `get_data()` function, and the remaining are  variables defined by `looq.lookTag()`. 

- `looq.map()` calls the function and passes the variables as arguments to it.
- Additionally, it wraps everything in a Looqbox response frame making `get_data`'s 
output intelligible by the interface. 

#### looq.sqlExecute
Now that we've got `looq.response` covered, we'll go inside `get_data`. Think of it as the backstage of your script, it's where everything is prepared so that your main function keeps neat.

Most of our scripts involve some kind of query to a database, `looq.sqlExecute()` is a funtion that makes this interaction extremely simple. 

```looqbox
# We generally store looq.sqlExecute's output in a variable called r
r <- looq.sqlExecute("mySQLDev", sql, list(dateInt[1], dateInt[2], company, value))

# A simple error test follows the query, checking for data absence
if(r$rows == 0) return(paste("No data found from:\n", dateInt[1], "to", dateInt[2]))
```
Normally it will take three arguments:

- `"mySQLDB"`: the database's name, as it was registered in the interface under connections.
- `sql`: a string containing the SQL query (we'll cover it in depth) 
- `...`: a list of parameters that will be inserted into the query.

In a simple manner, `looq.sqlExecute` does exatly what the name implies, it executes your query within the database, but more than that, it lets you insert values in the query. Take the following example string:

```looqbox
sql <- "
	SELECT
		EXAMPLE,
		TEST,
		FIELD,
		DATE
	FROM example.table
	WHERE 1=1			
		AND DATE >= DATE_ADD(`1`, INTERVAL +3 HOUR) 
		AND DATE < DATE_ADD(`2`, INTERVAL +3 HOUR)
		AND COMPANY = `3`
		AND VALUE = `4`
	ORDER BY DATE DESC
"
```

The values between backticks (`` ` ` ``)  are recognised by the function and substituted with the variables passed in the third argument of `looq.SQLExecute`, in order of appearance. 

Say that:

```looqbox
company <- 0
dateInt <- c('2018-07-09', '2018-08-09')
value <- 1120
```

The query sent to the database would be:

```looqbox
SELECT
	EXAMPLE,
	TEST,
	FIELD,
	DATE
FROM my.exampleDB
WHERE 1=1
	AND DATE >= DATE_ADD('2018-07-09', INTERVAL +3 HOUR) 
	AND DATE < DATE_ADD('2018-08-09', INTERVAL +3 HOUR)
	AND COMPANY = 0
	AND VALUE = 1120
ORDER BY DATE DESC
```

Easy right? And it gets better, `looq.sqlExecute` returns a `looq.objTable`, an object from the package that is ready to be imported to the interface.

#### looq.objTable and it's parameters

The most common answer to Looqbox questions comes in the form of tables, but rather than using comon objects as `data.frame` or `tbl` we have developed a special object, which is recognised by the interface and will help you create bespoke tables, as it has a number of built-in customization options.

Well go through it's most important parameters here, more advanced options will be treated in [Advanced Section](#advanced).

#### Data
 
```looqbox
r$data
```
All of the data retrieved from queries or imported from elsewhere will be available in this variable, which is a `tbl`. 

#### Title

You can create a title for your table with `r$title`, which will be visible as a header. Another style option is `r$framedTitle`. Go ahead and try it out!

The `r$title` format accepts multiple lines, creating subtitles or passing other info as a header, `r$framedTitle` accepts only a string, but you may combine them to create interesting headers.

```looqbox
# Simple title
r$title <- "Simple title"

# Example with framed title
r$framedTitle <- "Framed title"

# Title with date
r$title <- c(
	"My title",
	looq.titleWithDate("Períod:", dateInt)
)
```

#### Style

Add styling to single or multiple columns through `r$value$Style`. Good examples are values that turn red if negative but green if positive. The color can be defined as either hex(#fff) or rgb(255,255,255). 

```looqbox
# Styling single column
r$valueStyle$Column <- style

# Styling multiple columns at once
r$valueStyle <- list(
	"Column1" = style,
	"Column2" = style
)
```

#### Formating my data

`r$valueFormat` lets you format numbers and dates, adding percentages, defining number of decimal points son so on. You should write the names of each column followed by the format.

```looqbox
r$valueFormat <- list(
	"numeric column" = "number:2",
	"percent column" = "percent:2"
)
```

#### Total line

Add a total line to your table, it can be defined for each column. If a column is left blank it will be filled with `-` by default.

```looqbox
r$total <- list(
	`Column 1` = "total",
	`Column 2` = sum(r$data$`Column 2`)
)
```

#### Drill Down

To add drill down options that link to other scripts, you should use `r$ValueLink$[Your Column Here]`. The question text will be posted as a new question, efectively linking the scripts together. 

Using `paste` or `paste0` we can add variables or values to the link, or, as you can see below, even add values from within the table, by pasting the desired `r$data$column`. 

The `"text"` parameter will add a title to your link, which is essential when multiple drills are made from the same column.

```looqbox
# Simple drill
r$valueLink$Column <- "my question text here"

# Simple drill with variable
r$valueLink$Column <- paste("my question text here with this value", 203)

# Text box drill
r$valueLink$Column <- list(
	list("text" = "by User", "link" = paste("my question with this column", r$data$Column2)),
	list("text" = "by Company", "link" = paste("my other question with this column", r$data$Column2))
)
```

#### Pagination

Adds pagination of the specified size.

```looqbox
r$paginationSize <- 25
```

#### Searchbar

Boolean that adds a searchbar to the table(`FALSE` by default). 

```looqbox
r$searchable <- T
```

## Advanced

Now that you're already familiar with the basics for creating scripts, we'll begin exploring the full potential of looqbox responses. With more complex functions and different kinds of vizualizations you can bid farewell to the simple tables you learned to create and welcome a whole new range of possibilities. 

### Other Vizualizations

#### Plots

When someone thinks of vizualizing data the first thing that pops into mind is a graph. To allow graphs in our scripts we have created `looq.objPlotly()`, an object which accepts both [Plotly](https://plot.ly/r/) and `ggplot` graphs and histograms as input and adapts them to the interface.

```looqbox

```

#### Media

We also have similar objects that allow you to import media into your answers and compose them with other objects. It is all very straightforward:

 - `looq.objImage()`: 
 - `looq.objVideo()`: 
 - `looq.objAudio()`: 

### Advanced Package Functions

#### looq.findToken 

#### looq.sqlIn 

#### looq.sqlUpdate

#### Deeper into looq.objTable


<!-- #### looq.responseFrame --> 