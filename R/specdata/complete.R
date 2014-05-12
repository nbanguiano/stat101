complete <- function(d, id = 1:332) {
     wd <- paste("D:/Users/nanguiano/Documents/Personal/Coursera/stat101/R/", d, sep = "")
     setwd(wd)
     
     gobs <- data.frame(id=numeric(length(id)), nobs=numeric(length(id)))
     i <- 1
     for(j in id) {
          allData <- read.csv(list.files()[j])
          gobs[i,] <- c(j, sum(complete.cases(allData)))
          i <- i + 1
     }
     return(gobs)
}