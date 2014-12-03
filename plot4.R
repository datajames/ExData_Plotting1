plot4 <- function(){
  
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
  png(width = 480,height = 480,filename = "plot4.png")
  
  # create a 2 x 2 grid to add plots to
  # reduce the font size to match png's from exercise
  par(mfrow = c(2,2),cex=0.7)
  
  # change y axis on plot 1 to match plot4.png
  # removes the box from legend on plot 3
  # add new plot type for plot 4 
  with(electricdata,{
    plot(Time,Global_active_power,type="l",ylab="Global Active Power",xlab="")
    plot(Time,Voltage,type="l",xlab="")
    plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
    points(Time,Sub_metering_2,type="l",col="red")
    points(Time,Sub_metering_3,type="l",col="blue")
    legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"),
           cex=1, lty=1, bty = "n")
    plot(Time,Global_reactive_power,type="l",xlab="datetime")}
  )
  
  #close the graphics device and write out file
  dev.off() 
  
  
}