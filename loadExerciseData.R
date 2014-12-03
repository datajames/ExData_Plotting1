loadExerciseData <- function (){
  temp <- tempfile()
  URL <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
  download.file(URL, destfile = "./data/household_power_consumption.zip", method="curl",quiet=TRUE)
  unzip("./data/household_power_consumption.zip",exdir="./data")
  write(format(Sys.time(), "%a %b %d %X %Y %Z"), file = "./data/datedownloaded.txt")  
}
