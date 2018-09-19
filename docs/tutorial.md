# R Tutorial

> This tutorial assume you don't have existing Looqbox R Package previus knowledge.

<!--
## Prerequisites

- R knowledge
-->

## Setup for the Tutorial

You can either write the code in your RStudio Serve, or you can set up a local development environment on your computer and use your local RStudio.

### Setup 1: RStudio Serve

This is the quickest way to get started!

Open [http://localhost:8787](http://localhost:8787), enter your **username** and **password** and you're almost ready to go.

Go to your looqbox addin and set your admin user.

You can now skip the second setup option, and go to the [basics section](#basics) to get an overview of React.

### Setup 2: Local development environment

This is completely optional and not required for this tutorial!

## Basics

### Script sctructure

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


