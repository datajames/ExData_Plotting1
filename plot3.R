plot3 <- function(){
  # read the data from downloaded data file into data.frame with headers
  # let the values in the file ? represent NA
  electricdata <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = F,na.strings = "?")
  
  # column names are defined in the dataset description are used as the headers in txt file so fine to keep
  
  # concat the date and time together and run through strptime to get a datetime object, overwrite in the Time column
  electricdata$Time <- strptime(paste(electricdata$Date, electricdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
  
  # convert the string date to date object
  electricdata[, 1] <- as.Date(electricdata$Date, format = "%d/%m/%Y")
  
  # extract subset for dates 2007-02-01 and 2007-02-02, discard the rest  
  startDate <- "2007-02-01" 
  endDate <- "2007-02-02"
  electricdata <- subset(electricdata, subset=(format(electricdata$Date, "%Y-%m-%d") == startDate | format(electricdata$Date, "%Y-%m-%d") == endDate))
  
  #open a png file handle and set the size of the png
  png(width = 480,height = 480,filename = "plot3.png")
  
  #build a plot and then add extra data points for sub meter 2 and 3
  with(electricdata,plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
  with(electricdata,points(Time,Sub_metering_2,type="l",col="red"))
  with(electricdata,points(Time,Sub_metering_3,type="l",col="blue"))
  
  # add a legend
  legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"),
         cex=1, lty=1)
  
  #close the graphics device and write out file
  dev.off() 
}