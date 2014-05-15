rankhospital <- function(s, o, n = "best") {
     ## Define the dataset
     dset <- read.csv("outcome-of-care-measures.csv",
                      colClasses = "character")
     
     ## Check if the state passed exists in the datase
     ## if not, throw an error and stop
     st <- dset$State
     if (sum(grepl(s, st)) == 0) { stop("invalid state") }
     
     ## Assign the desease to its respective column number
     ## if it doesn't exist, stop
     if (o == "heart attack") {o <- 11;}
     else if (o == "heart failure") {o <- 17;}
     else if (o == "pneumonia") {o <- 23;}
     else { stop("invalid outcome") }
     
     ## Split the data by states, and create lists
     ## then define hotels and outcome by state
     ## by subseting the data frame for that state "[[s]]"
     HBS <- split(dset$Hospital.Name, st)[[s]]
     OBS <- as.numeric(split(dset[,o], st)[[s]])
     
     ## Only get complete cases
     u <- complete.cases(HBS, OBS)
     
     ## Create a data frame with the data
     ## and order it
     HBS <- HBS[u]; OBS <- OBS[u]
     HBS <- HBS[order(OBS)]; OBS <- sort(OBS)
     
     ## Logic to understand "best" and "worst"
     if (n == "best"){n = 1}
     else if (n == "worst"){n = length(OBS)}
     else {n = n}
     
     ## Check for ties, and sort the tied
     ## hospitals alphabetically
     uu <- OBS == OBS[n]
     HBS <- sort(HBS[uu])
     
     ## Return the requested position
     ## or the first tied in alphabetical order
     return(HBS[1])
}