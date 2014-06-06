rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv")
    
    ## Check that state and outcome are valid
    outcome <- gsub(" ", ".", outcome)
    outcome <- paste0("Hospital.30.Day.Death..Mortality..Rates.from.", outcome)
    
    df <- df[df$State == state, ]
    if (nrow(df) == 0)
    {
        stop("invalid state")    
    }
    
    ## Check column validity
    cl <- colnames(df)
    cl <- cl[tolower(cl) == tolower(outcome)]
    if (length(cl) == 0)
    {
        stop("invalid outcome")    
    }
    
    ## Exclude "Not Available" rows
    df <- df[df[cl] != "Not Available", ]
    
    ## Convert column to numeric
    df[, cl] <- sapply(df[, cl], as.character)
    df[, cl] <- sapply(df[, cl], as.numeric)
    
    ## Trim data frame width
    df <- df[ ,c("Hospital.Name", cl)]
    df <- df[complete.cases(df), ]
    
    ## Filter on Hospital Name alphabetically
    df <- df[order(df[cl], df["Hospital.Name"]),]
    
    if (num == "best") num = 1
    if (num == "worst") num = nrow(df)
    if (num > nrow(df)) return(NA)
    
    ## Find Hospital
    s <- as.character(df[num,"Hospital.Name"])
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    s
}

## Just a bit of script to test if all is well
# print(rankhospital("TX", "heart failure", 4))
# #[1] "DETAR HOSPITAL NAVARRO"
# print(rankhospital("MD", "heart attack", "worst"))
# #[1] "HARFORD MEMORIAL HOSPITAL"
# print(rankhospital("MN", "heart attack", 5000))
# #[1] NA