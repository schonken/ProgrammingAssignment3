R Programming - Programming Assignment 3
========================================

Repository for Programming Assignment 3 for R Programming on Coursera

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