# Script assumes that the working directory is set to the location of data file to be read in and that it has been unzipped

# Read in data from text file and subset based upon the two days that we are interested in
power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert the data columns from a character to a numeric or integer type
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
power$Sub_metering_1 <- as.integer(power$Sub_metering_1)
power$Sub_metering_2 <- as.integer(power$Sub_metering_2)
power$Sub_metering_3 <- as.integer(power$Sub_metering_3)

# Concatenate the Date and Time columns then convert them to a POSIXlt date type
power$DateTime <- do.call(paste, c(power[c("Date", "Time")], sep=" "))
power$DateTime <- strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")

# Open a png device for writing
png("plot4.png", width=480, height=480)

# Set the graphic device to be a 2x2 grid of graphs
par(mfrow=c(2,2))

# Add the first graph of the frequency of Global active power
plot(power$DateTime, power$Global_active_power, xlab=NA, ylab="Global Active Power", type="l")

# Add the second graph of the Voltage over time
plot(power$DateTime, power$Voltage, xlab="datetime", ylab="Voltage", type="l")

# Add the third graph of the Sub metering series over time
plot(power$DateTime, power$Sub_metering_1, xlab=NA, ylab="Energy sub metering", type="l", col="black")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"), bty="n")

# Add the fourth graph of the Global reactive power over time
plot(power$DateTime, power$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()
