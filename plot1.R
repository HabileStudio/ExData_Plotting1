# Fetch the file, read it and assign it to fulldata
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
fulldata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

# Restrict the data to only 1-2 Feb 2007
data <- subset(fulldata, Date == '1/2/2007' | Date == '2/2/2007')

# Set data with the right format
data$Global_active_power <- as.numeric(data$Global_active_power)

# Prepare for png output
png(filename = "plot1.png",
    width = 480, height = 480,
    units = "px")

hist(data$Global_active_power,
     freq=TRUE,
     main="Global Active Power",
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

dev.off()