power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
power$Sub_metering_1 <- as.integer(power$Sub_metering_1)
power$Sub_metering_2 <- as.integer(power$Sub_metering_2)
power$Sub_metering_3 <- as.integer(power$Sub_metering_3)

power$DateTime <- do.call(paste, c(power[c("Date", "Time")], sep=" "))
power$DateTime <- strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(power$DateTime, power$Global_active_power, xlab=NA, ylab="Global Active Power", type="l")

plot(power$DateTime, power$Voltage, xlab="datetime", ylab="Voltage", type="l")

plot(power$DateTime, power$Sub_metering_1, xlab=NA, ylab="Energy sub metering", type="l", col="black")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"), bty="n")

plot(power$DateTime, power$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

#dev.copy(png, file="plot4.png")
dev.off()