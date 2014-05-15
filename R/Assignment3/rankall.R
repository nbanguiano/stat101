rankall <- function(out, num = "best") {
     ## Define the dataset
     dset <- read.csv("outcome-of-care-measures.csv",
                      colClasses = "character")
     
     ## Get all states
     st <- levels(factor(sort(dset$State)))
          
     ## Logic to understand "best" and "worst"
     if (n == "best"){n = 1}
     else if (n == "worst"){n = length(OBS)}
     else {n = n}
     
     ## Get the ranked hotel by state
     HRank <- lapply(st, rankhospital, o = out, n = num)
     HRank <- unlist(HRank)
     
     ## Create the required data.frame
     df <- data.frame("hospital" = HRank, 
                      "state" = st)
     
     ## Return the data.frame
     return(df)
}