## downloading data
if(!file.exists("data")){
      dir.create("data")
}
if(!file.exists("data/data.zip")){
      download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/data.zip") 
}

## unzip the ./data/data.zip
unzip(zipfile="./data/data.zip",exdir="./data")

## reading dataset
df <- read.table("data/household_power_consumption.txt", sep = ";", na.strings = "?", nrows = 2075259, header = T, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), comment.char = "")

## extracting data for analysis
df <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

## formating date and time
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

## plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
