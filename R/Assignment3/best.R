best <- function(s, o) {
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
     else { stop("Invalid Desease") }
     
     ## Split the data by states, and create lists
     ## then define hotels and outcome by state
     ## by subseting the data frame for that state "[[s]]"
     HBS <- split(dset$Hospital.Name, st)[[s]]
     OBS <- as.numeric(split(dset[,o], st)[[s]])
     
     ## Make a logic vector where the outcome
     ## is equal to the minimum observation
     ## and get the matching hotel(s)
     u <- OBS == min(OBS, na.rm = TRUE)
     v <- is.na(u)
     best <- HBS[!v][u[!v]]
     
     ## If there are severak tied sort them
     ## alphabetically and return the best/first hotel
     b <- sort(best[!is.na(best)])
     return(b[1])
}