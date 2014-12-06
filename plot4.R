## 1) download & extract the data, if it doesn't already exist

## I then use the system() function to:
## 2) remove only the required data - header line, data lines
##  .. starting from 1/2/2007 ending at 2/2/2007 inclusive.
## 3) merge all into one dataset - data.txt

if(!file.exists("./household_power_consumption.txt")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, dest="./exdata%2Fdata%2Fhousehold_power_consumption.zip", method="curl")
        unzip("./exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

system("grep '^1/2/2007' ./household_power_consumption.txt > ./start.txt")
system("grep '^2/2/2007' ./household_power_consumption.txt > ./end.txt")
system("head -1 ./household_power_consumption.txt > ./head.txt")
system("cat ./head.txt ./start.txt ./end.txt > ./data.txt")

data <- read.table("./data.txt", sep=";", header=T)

dates <- data$Date
times <- data$Time
DT <- paste(dates,times)
data <- cbind(data,DT)
data$DT <- as.POSIXct(strptime(data$DT,format="%d/%m/%Y %H:%M:%S"))

png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow = c(2,2))
with(data, plot(Global_active_power ~ DT, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
with(data, plot(Voltage ~ DT, type="l", xlab="datetime", ylab="Voltage"))
with(data, plot(DT, Sub_metering_1, ylab = "Energy sub metering", xlab="",type="n"))
lines(data$DT, data$Sub_metering_1, type="l", col="black")
lines(data$DT, data$Sub_metering_2, type="l", col="red")
lines(data$DT, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(data, plot(Global_reactive_power ~ DT, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
