# Script assumes that the working directory is set to the location of data file to be read in and that it has been unzipped

# Read in data from text file and subset based upon the two days that we are interested in
power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert the Global active power column from a character to a numeric type
power$Global_active_power <- as.numeric(power$Global_active_power)

# Concatenate the Date and Time columns then convert them to a POSIXlt date type
power$DateTime <- do.call(paste, c(power[c("Date", "Time")], sep=" "))
power$DateTime <- strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")

# Create the graph
plot(power$DateTime, power$Global_active_power, xlab=NA, ylab="Global Active Power (kilowatts)", type="l")

# Write out the graph to a png device
dev.copy(png, file="plot2.png")
dev.off()
