# Fetch the file, read it and assign it to fulldata
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
fulldata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

# To get the days in the right language
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# Restrict the data to only 1-2 Feb 2007
data <- subset(fulldata, Date == '1/2/2007' | Date == '2/2/2007')

# Set data with the right formats
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Install lubridate if not installed
if("lubridate" %in% rownames(installed.packages()) == FALSE){
  install.packages("lubridate")
}
library("lubridate")
data$Date <- dmy_hms(paste(data$Date, data$Time))

# Prepare for png output
png(filename = "plot4.png",
    width = 480, height = 480,
    units = "px")

# Set the canvas for 2 x 2 plots
# X X
# X X
par(mfrow = c(2,2))

# X -
# - -
plot(data$Date,
     data$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# - X
# - -
plot(data$Date,
     data$Voltage,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage")

# - -
# X -
plot(data$Date,
     data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")

lines(data$Date,
     data$Sub_metering_2,
     type="l",
     col="red")

lines(data$Date,
     data$Sub_metering_3,
     type="l",
     col="blue")

legend("topright",
       lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       bty="n")

# - -
# - X
plot(data$Date,
     data$Global_reactive_power,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power")


dev.off()
