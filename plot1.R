## Download and unzip the data if zip or txt file does not exist
filename <- "electric_power_consumption.zip"
if (!file.exists(filename)){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "electric_power_consumption.zip")
    unzip("electric_power_consumption.zip")
} 
if (!file.exists("household_power_consumption.txt")) { 
    unzip(filename) 
}

## Read the data
library("data.table")
full_data <- fread("household_power_consumption.txt", sep = ";",header = TRUE,na.strings="?")
# Subset data from 01/02/2007 and 02/02/2007
data <- full_data[(full_data$Date=="1/2/2007" | full_data$Date=="2/2/2007" ), ]

## Define the graphic device
png("plot1.png",width=480,height=480)
## Create the histogram (it will be added to the defined graphic device)
hist(data$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
