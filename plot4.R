## Retrieve data set
source("retrieve_data.R")

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

## Make plot 4

# Backup default par settings
old.par <- par()

# Create plot 4
png("plot4.png", type = "cairo", width = 480, height = 480, bg = "transparent")
par(mfcol = c(2, 2))
with(x, {
  plot(datetime, Global_active_power, type = "l", xlab = "",
       ylab = "Global Active Power")
  plot(datetime, Sub_metering_1, type = "l", xlab = "",
       ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, Voltage, type = "l")
  plot(datetime, Global_reactive_power, type = "l")
})
dev.off()

# Restore default par settings
suppressWarnings(par(old.par))