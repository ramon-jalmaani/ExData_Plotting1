ls()
rm(list=ls())

if (!file.exists("data")) {
  dir.create("data")
}

#Point and download zip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## change url accordingly
download.file(fileURL, destfile ="./data/household_power_consumption.zip")
#unzip file
unzip("./data/household_power_consumption.zip", exdir = "M4W1EPConsumption")
#check files
list.files("./M4W1EPConsumption")

#Reading the text file
ePower <- read.table("./M4W1EPConsumption/household_power_consumption.txt", sep = ";", header = TRUE)

#Discovering the dataset
head(ePower) #shows first 6 elements
tail(ePower) #shows last 6 elements
str(ePower) #shows all are factors except sub_metering_3
dim(ePower) #shows number of rows X number of columns
names(ePower) #shows variable/column names

#Checking on the first 6 elements of the variables 
#to be used in the plots
head(ePower$Date)
head(ePower$Time)
head(ePower$Global_active_power)
head(ePower$Sub_metering_1)
head(ePower$Sub_metering_2)
head(ePower$Sub_metering_3)
head(ePower$Voltage)

#Using paste function to join Date and Time;
#then strptime() to change factor Date and Time 
#into the format yyyy-mm-dd hh:mm:ss.

ePower$DateTime <- paste(ePower$Date, ePower$Time)
head(ePower$DateTime)
ePower$DateTime <- strptime(ePower$DateTime, "%d/%m/%Y %H:%M:%S")
head(ePower$DateTime)

#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#One alternative is to read the data from just those dates rather 
#than reading in the entire dataset and subsetting to those dates.

begin <- which(ePower$DateTime==strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
stop <- which(ePower$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
Epower <- ePower[begin:stop,]

#plot3.R
plot(Epower$DateTime, as.numeric(as.character(Epower$Sub_metering_1)),
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(Epower$DateTime, as.numeric(as.character(Epower$Sub_metering_2)),
      type = "l", 
      col = "red")
lines(Epower$DateTime, Epower$Sub_metering_3,type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black","red","blue"))
#plot3.png
dev.copy(png, file = "plot3.png")
dev.off()