# Script assumes that the working directory is set to the location of data file to be read in and that it has been unzipped

# Read in data from text file and subset based upon the two days that we are interested in
power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert the Sub metering columns from a character to an integer type
power$Sub_metering_1 <- as.integer(power$Sub_metering_1)
power$Sub_metering_2 <- as.integer(power$Sub_metering_2)
power$Sub_metering_3 <- as.integer(power$Sub_metering_3)

# Concatenate the Date and Time columns then convert them to a POSIXlt date type
power$DateTime <- do.call(paste, c(power[c("Date", "Time")], sep=" "))
power$DateTime <- strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")

# Open a png device for writing
png("plot3.png", width=480, height=480)

# Create the graph, add the additional two Sub metering series and add a legend
plot(power$DateTime, power$Sub_metering_1, xlab=NA, ylab="Energy sub metering", type="l", col="black")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"))

# Close the png device
dev.off()
