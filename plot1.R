# Script assumes that the working directory is set to the location of data file to be read in and that it has been unzipped

# Read in data from text file and subset based upon the two days that we are interested in
power <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert the Global active power column from a character to a numeric type
power$Global_active_power <- as.numeric(power$Global_active_power)

# Create the histogram
hist(power$Global_active_power, freq=TRUE, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Write out the graph to a png device
dev.copy(png, file="plot1.png")
dev.off()
