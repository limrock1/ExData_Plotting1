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

png(filename="plot1.png", width=480, height=480, units="px")
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")
dev.off()
