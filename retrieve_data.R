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