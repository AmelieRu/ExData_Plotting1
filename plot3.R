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

## Adapt the date and time format
# Convert the char date as a date date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
# Concatenate date and time in a char vector
date_time <- paste(data$Date, data$Time)
# Transform the char vector into a date-time variables and add it to the dataset
data$Date_time <- as.POSIXct(date_time)

## Define the graphic device
png("plot3.png",width=480,height=480)
## Create the plot (it will be added to the defined graphic device)
# In case your computer language is not english
Sys.setlocale("LC_TIME", "English")
# Create the plot
with(data,plot(Date_time,Sub_metering_1,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
with(data,lines(Date_time,Sub_metering_2,col='Red'))
with(data,lines(Date_time,Sub_metering_3,col='Blue'))
# Add the legend
legend("topright", lty=1, col = c("black", "red", "blue"),
legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()