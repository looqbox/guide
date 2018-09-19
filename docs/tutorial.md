# R Tutorial

> This tutorial assume you don't have existing Looqbox R Package previus knowledge.

<!--
## Prerequisites

- R knowledge
-->

## Setup for the Tutorial

This documentation's objective is to introduce you to the guidelines for creating organized and efficient R scripts for Looqbox as well as to make you confortable with the looqbox package and with the tool's environment and workflow. In this section we will focus on the creation and editing of the R scripts, so we recomend using Rstudio as the development environment.

You can either write the code in your RStudio Serve, or you can set up a local development environment on your computer and use your local RStudio.


### Setup 1: RStudio Serve

This is the quickest way to get started!

Open [http://localhost:8787](http://localhost:8787), enter your **username** and **password** and you're almost ready to go.

Go to your looqbox addin and set your admin user.

You can now skip the second setup option, and go to the [basics section](#basics) to get an overview of React.

### Setup 2: Local development environment

This setup option requires a little more work at first glance, but it certainly pays off. 

[colocar guia de instalação dev]

## Basics

### Script sctructure


All Looqbox scripts follow a simple basic structure which you can see below:


```looqbox
library(looqbox)

#-----------------------------------------------------------------------------#
#----  sampleScript
#-----------------------------------------------------------------------------#
get.data <- function(dateInt, company, value){

	#Query

	sql <- paste0("
		SELECT
			EXAMPLE,
			TEST,
			FIELD,
			DATE
		FROM my.exampleDB
		WHERE 1=1
			AND DATE >= DATE_ADD(`1`, INTERVAL +3 HOUR) 
			AND DATE < DATE_ADD(`2`, INTERVAL +3 HOUR)
			AND COMPANY = `3`
			AND VALUE = `4`
		ORDER BY DATE DESC
		")
	
	r <- looq.sqlExecute("mySQLDev", sql, dateInt[1], dateInt[2], company, value)
	if(r$rows == 0) return(paste("No data found from:\n", dateInt[1], "a", dateInt[2]))
	r$data$OBJECT_VALUE <- as.integer(r$data$OBJECT_VALUE)
	
	#ObjTable

  	r$valueLink$`Object Name` <- list(
  		list("text" = "Dropdown", "link" = paste("another very interesting script")))
	
	
	target <- paste(action, target)
	r$title <- c(
		"Alterações - Analítico",
		looq.titleForList("Empresa: ", company),
		looq.titleWithDate("Período: ",dateInt)
	)
	
	r$data$Date <- strtrim(r$data$Date, 19)
	
	
	r$searchable <- TRUE
	r$paginationSize <- 25
	
	r
	}

#-----------------------------------------------------------------------------#
#---  Response
#-----------------------------------------------------------------------------#

looq.response <- function(par){
	
	date <- looq.lookTag(c("$date", "$datetime"), par, list(c(as.character(Sys.Date()), as.character(Sys.Date()))))
	date <- looq.mergeDateAndDatetime(date)
	company <- looq.lookTag("$company", par)
	target <- looq.lookTag("originalQuestion", par)
	target <- looq.findToken(target, "target", "string")
	action <- looq.lookTag("originalQuestion", par)
	action <- looq.findToken(action, "acao", "string")
	
	
	looq.map(get.data,date,company,target, action)
}

#-----------------------------------------------------------------------------#
#---  Test Block
#-----------------------------------------------------------------------------#
looq.testQuestion(
	list(
		"$date"=list(c('2018-08-01','2018-09-01')),
		"$company" = 44
	)
)

```

#### dependencies

#### get.data

#### looq.responseFrame

#### test block

### Essential functions

#### looq.lookTag

#### looq.responseFrame

#### looq.map

#### looq.sqlExecute

#### looq.objTable

### Improvements

#### Title

```looqbox
r$title <- "Simple title"
```

```looqbox
r$title <- c(
	"My title",
	looq.titleWithDate("Períod:", dateInt)
)
```

#### Style

```looqbox
r$valueStyle$Column <- style
```

```looqbox
r$valueStyle <- list(
	"Column" = style
)
```

#### Formating my data

```looqbox
r$valueFormat <- list(
	"numeric column" = "number:2",
	"percent column" = "percent:2"
)
```

#### Total line

```looqbox
r$total <- list(
	`Column 1` = "total",
	`Column 2` = sum(r$data$`Column 2`)
)
```

#### Drill Down

```looqbox
r$valueLink$Column <- "my question text here"
```

```looqbox
r$valueLink$Column <- paste("my question text here with this value", 203)
```

```looqbox
r$valueLink$Column <- list(
	list("text" = "by User", "link" = paste("my question with this column", r$data$Column2))
)
```

#### Pagination

```looqbox
r$paginationSize <- 25
```

#### Searchbar

```looqbox
r$searchable <- T
```

## Advanced


