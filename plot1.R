## Retrieve data set
source("retrieve_data.R")

## Read data to global environment

# Read variable names
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

## Make plot 1
png("plot1.png", type = "cairo", width = 480, height = 480, bg = "transparent")
hist(x$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()