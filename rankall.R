rankall <- function(outcome, num = "best") {
    ## Read outcome data
    dfm <- read.csv("outcome-of-care-measures.csv")
    
    ## Check column validity
    outcome <- gsub(" ", ".", outcome)
    outcome <- paste0("Hospital.30.Day.Death..Mortality..Rates.from.", outcome)
    
    cl <- colnames(dfm)
    cl <- cl[tolower(cl) == tolower(outcome)]
    if (length(cl) == 0)
    {
        stop("invalid outcome")    
    }
    
    ## Exclude "Not Available" rows
    dfm <- dfm[dfm[cl] != "Not Available", ]
    
    ## Convert column to numeric
    dfm[, cl] <- sapply(dfm[, cl], as.character)
    dfm[, cl] <- sapply(dfm[, cl], as.numeric)
    
    ## Trim data frame width
    dfm <- dfm[ ,c("Hospital.Name", "State", cl)]
    us_states <- as.character(dfm[!duplicated(dfm[,c("State")]), 2])
    us_states <- sort(us_states)
    dfr <- data.frame(hospital=character(), state=character())
    
    ## Loop through the US Stats and do some work
    for(us_state in us_states){
        num_loop <- num
        
        ## Trim data frame width
        df <- dfm[dfm[["State"]] == us_state, ]
        df <- df[ ,c("Hospital.Name", cl)]
        df <- df[complete.cases(df), ]
        
        ## Filter on Hospital Name alphabetically
        df <- df[order(df[cl], df["Hospital.Name"]),]
        
        if (num_loop == "best") num_loop = 1
        if (num_loop == "worst") num_loop = nrow(df)
        if (num_loop > nrow(df)) 
        {
            # return(NA)
            dfr <- rbind(dfr, data.frame(hospital=NA, state=us_state, row.names=us_state))
        }
        else
        {
            ## Find Hospital
            s <- as.character(df[num_loop,"Hospital.Name"])
            dfr <- rbind(dfr, data.frame(hospital=s, state=us_state, row.names=us_state))
        }
    }
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    dfr
}

## Just a bit of script to test if all is well
# print(head(rankall("heart attack", 20), 10))
# cat("\n")
# print(tail(rankall("pneumonia", "worst"), 3))
# cat("\n")
# print(tail(rankall("heart failure"), 10))