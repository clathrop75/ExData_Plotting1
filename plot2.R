power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

power$Global_active_power <- as.numeric(power$Global_active_power)

power$DateTime <- do.call(paste, c(power[c("Date", "Time")], sep=" "))
power$DateTime <- strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")

plot(power$DateTime, power$Global_active_power, xlab=NA, ylab="Global Active Power (kilowatts)", type="l")

dev.copy(png, file="plot2.png")
dev.off()