# Implementation

## Implementation Flow

There are 2 important concepts that you should know to understand our recommentation about how responses should be implemented in Looqbox.

1. Looqbox runs a R script for each question asked by the users. Each of those scripts access a datasource (e.g. MySQL), so the time that a users waits is mainly the response time from the query or API. The maximum recommended time for a response is 2 seconds.

2. Users usually need a bit of experience with the interface to start asking more complex questions, so starting with short and general questions help new users to navigate.

We discorage the implementation of complex dashboards in Looqbox, since it usually depends of multiple queries, which result in a long response time.

To guarantee the best user experience, responses should be implemented in a way that users can ask simple questions, and navigate to more specific information using features like drill down. Navigating between 4 tables of content waiting 2 seconds for each load in much better than waiting 8 seconds for a single dashboard.

Here is a sequence of questions to illustrate this scenario:

- sales $date
- sales $date by store
- sales $date by department
- sales $date by supplier

## Database Connection

## Creating a response

## Creating User

## Creating UserGroup 

## Creating ResponseGroup

## Entity

### Entity By Code

### Entity By Name

## Replacements