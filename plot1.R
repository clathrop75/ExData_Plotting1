power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

power$Global_active_power <- as.numeric(power$Global_active_power)

hist(power$Global_active_power, freq=TRUE, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

dev.copy(png, file="plot1.png")
dev.off()