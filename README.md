R Programming - Programming Assignment 3
========================================

Repository for Programming Assignment 3 for R Programming on Coursera

### best.R
Question 2 - Finding the best hospital in a state.
```{r}
best <- function(state, outcome){
    #Some magic
}
```

### rankhospital.R
Question 3 - Ranking hospitals by outcome in a state.
```{r}
rankhospital <- function(state, outcome, num = "best") {
    #Some magic
}
```

### rankall.R
Question 4 - Ranking hospitals in all states.
```{r}
rankall <- function(outcome, num = "best") {
    #Some magic
}
```

### scratch.R
A place to _play and test_ without being __judged__.
The type of code one might expect here is:

```{r}
## 1 Plot the 30-day mortality rates for heart attack
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
```