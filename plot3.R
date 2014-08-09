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

## Make plot 3
png("plot3.png", type = "cairo-png", width = 480, height = 480, bg = "transparent")
plot(x$datetime, x$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(x$datetime, x$Sub_metering_2, col = "red")
lines(x$datetime, x$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()