install.packages("RCurl")
library("RCurl")
data <- read.table(textConnection(getURL("https://cgiardata.s3-us-west-2.amazonaws.com/ccafs/amzn.csv")))
head(data)