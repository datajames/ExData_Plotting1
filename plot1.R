plot1 <- function(){
  # read the data from downloaded data file into data.frame with headers
  # let the values in the file ? represent NA
  electricdata <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = F,na.strings = "?")
  
  # column names are defined in the dataset description are used as the headers in txt file so fine to keep
  
  # concat the date and time together and run through strptime to get a datetime object, overwrite in the Time column
  electricdata$Time <- strptime(paste(electricdata$Date, electricdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
  
  # convert the string date to date object
  electricdata[, 1] <- as.Date(electricdata$Date, format = "%d/%m/%Y")
  
  # extract subset for dates 2007-02-01 and 2007-02-02, discard the rest  cl
  startDate <- "2007-02-01" 
  endDate <- "2007-02-02"
  electricdata <- subset(electricdata, subset=(format(electricdata$Date, "%Y-%m-%d") == startDate | format(electricdata$Date, "%Y-%m-%d") == endDate))
    
  #open a png file handle and set the size of the png
  png(width = 480,height = 480,filename = "plot1.png")
  
  # now build the histogram
  with(electricdata,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))                                      
  
  #close the graphics device and write out file
  dev.off()
}