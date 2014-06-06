best <- function(state, outcome) {
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
    
    ## Filter on lowest score
    df <- df[df[cl] == min(df[cl], na.rm = TRUE), ]
    
    ## Filter on Hospital Name alphabetically
    df <- df[order(df$Hospital.Name),]
    s <- as.character(df[1,"Hospital.Name"])
    
    ## Return Hospital Name
    s
}

# ## Just a bit of script to test if all is well
# best("TX", "heart attack")
# #[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
# best("TX", "heart failure")
# #[1] "FORT DUNCAN MEDICAL CENTER"
# best("MD", "heart attack")
# #[1] "JOHNS HOPKINS HOSPITAL, THE"
# best("MD", "pneumonia")
# #[1] "GREATER BALTIMORE MEDICAL CENTER"
# best("BB", "heart attack")
# #Error in best("BB", "heart attack") : invalid state
# best("NY", "hert attack")
# #Error in best("NY", "hert attack") : invalid outcome
