best <- function(s, o) {
     ## Define the dataset
     dset <- read.csv("outcome-of-care-measures.csv",
                      colClasses = "character")
     
     ## Check if the state passed exists in the datase
     ## if not, throw an error and stop
     st <- dset$State
     if (sum(grepl(s, st)) == 0) { message("Invalid State"); stop(); }
     
     ## Assign the desease passed to it's column
     ## if it doesn't exist, stop
     if (o == "heart attack") {o <- 11;}
     else if (o == "heart failure") {o <- 17;}
     else if (o == "pneumonia") {o <- 23;}
     else { message("Invalid Desease"); stop(); }
     
     ## Split the data by states, and create lists
     ## then define hotels and outcome by state
     ## by subseting the data frame for that state "[[s]]"
     HBS <- split(dset$Hospital.Name, st)
     OBS <- split(dset[,o], st)
     HBS <- HBS[[s]]; OBS <- OBS[[s]]
     
     ## Make a logic vector where the outcome
     ## is equal to the minimum observation
     ## and get the matching hotel(s)
     u <- OBS == min(OBS)
     best <- HBS[u]
     
     browser()
     ## Return the best hotel
     return(best[!is.na(best)])
}