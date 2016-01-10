#Load sqldf package
library(sqldf)

#read the subset of data from the file using read.csv.sql from sqldf package
f <- "./data/household_power_consumption.txt"
ftbl <- file(f)
data <- read.csv2.sql(f, sql = "select * from ftbl where date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
close(ftbl)

# Convert date and time's from charatcer to date/time format
data$Time <- strptime(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Set the device to PNG and open plot3.png
png(filename = "plot3.png")

# Plot Time Vs. Sub Meterings (Base system plot)
with(data, plot(Time, Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering"))
points(data$Time, data$Sub_metering_1, type = 's', col = "black")
points(data$Time, data$Sub_metering_2, type = 's', col = "red")
points(data$Time, data$Sub_metering_3, type = 's', col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)

# close the PNG device
dev.off()