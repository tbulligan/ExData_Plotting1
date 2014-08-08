## Define file name variables
original.data.file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
local.data.file.zipped <- "exdata-data-household_power_consumption.zip"
local.data.file.unzipped <- "household_power_consumption.txt"

## Check if local copy of data set exists, else download and unpack

# Start data retrieval
print("Retrieving data...")

# Check if starting data exists, else download
if (!file.exists(local.data.file.zipped)) {
  download.file(original.data.file, local.data.file.zipped, method = "curl")
}

# Check if data retrieval successful, else stop
if (!file.exists(local.data.file.zipped)) {
  stop(paste("Could not retrieve", local.data.file.zipped))
}

# Check if starting data is uncompressed, else uncompress
if (!file.exists(local.data.file.unzipped)) {
  unzip(local.data.file.zipped)
}

# Check if uncompression successful, else stop
if (!file.exists(local.data.file.unzipped)) {
  stop(paste("Could not extract data from", local.data.file.zipped))
}

# End data retrieval
print("Data retrieved and ready for processing.")

## Read data to global environment

# Read column names
x.names <- names(read.table("household_power_consumption.txt", header = T,
                            sep = ";", nrows = 1))

# Read subset of data set (2007-02-01 to 2007-02-02)
x <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",
                skip = 66637, nrows = 2880, col.names = x.names,
                colClasses = c(rep("character", 2), rep("numeric", 7)))

# Replace columns 1 and 2 with a POSIX timestamp
x$datetime <- strptime(with(x, paste(Date, Time)),
                        format = "%d/%m/%Y %H:%M:%S")
x <- x[c(10,3:9)]

## Make and save plots

# Backup default par settings
old.par <- par()

# Make plot 1
png("plot1.png", width = 480, height = 480)
hist(x$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

# Make plot 2
png("plot2.png", width = 480, height = 480)
plot(x$datetime, x$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

# Make plot 3
png("plot3.png", width = 480, height = 480)
plot(x$datetime, x$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(x$datetime, x$Sub_metering_2, col = "red")
lines(x$datetime, x$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

# Make plot 4
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
with(x, {
  plot(datetime, Global_active_power, type = "l", xlab = "",
       ylab = "Global Active Power (kilowatts")
  plot(datetime, Sub_metering_1, type = "l", xlab = "",
       ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, Voltage, type = "l")
  plot(datetime, Global_reactive_power, type = "c", lwd = 0.5)
})
dev.off()

## Restore default par settings
suppressWarnings(par(old.par))