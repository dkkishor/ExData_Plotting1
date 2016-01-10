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

# Set the device to PNG and open plot2.png
png(filename = "plot2.png")

# Plot Time Vs. Global Active Power (Base system plot)
with(data, plot(Time, Global_active_power, type = "s", xlab="", ylab="Global Active Power (kilowatts)"))

# close the PNG device
dev.off()