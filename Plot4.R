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

## plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), mar = c(4,4,1,1), oma = c(1,1,0,0))
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(df$DateTime, df$Sub_metering_1, type = "n",xlab = "", ylab = "Energy sub metering")
lines(df$DateTime, df$Sub_metering_1, type = "l", col = "darkgrey")
lines(df$DateTime, df$Sub_metering_2, type = "l", col = "red")
lines(df$DateTime, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = "solid", col = c("darkgrey", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
