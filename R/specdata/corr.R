corr <- function(d, thr = 0) {
     
     wd <- paste("C:/Users/nanguiano/Documents/CODE/stat101/R/", d, sep = "")
     setwd(wd)
     
     ids <- 1:length(list.files(pattern = ".csv"))    
     gobs <- complete(d, ids)
     correlations <- NA
  
     for (n in ids) {
          if (gobs[n, "nobs"] > thr) {
               thrData <- read.csv(list.files()[n])
               goodobs <- complete.cases(thrData)
               ts <- thrData$sulfate[goodobs]
               tn <- thrData$nitrate[goodobs]
               polcorr <- cor(ts, tn)
               correlations <- c(correlations, polcorr)
          }
     }
     
     if (length(correlations) == 1) { correlations <- numeric(0) }
     
     return(correlations[!is.na(correlations)])
}