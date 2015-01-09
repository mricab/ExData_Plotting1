##PLOT 4

##CODE TO DOWNLOAD AND UNZIP THE FILE
if (!file.exists("data")) {dir.create("data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./data/data.zip", method="curl")
dateDownloaded <- date() #Save downloaded date
unzip("./data/data.zip")

##READ DATA
data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

##CODE TO PREPARE DATA FOR ANALYSIS
#Change case and remove "_" from names
names(data) <- tolower(names(data))
names(data) <- gsub("_", "", names(data))

#Change date and times class's
library(lubridate)
data$datetime <- paste(data$date, data$time, sep=" ")
data$datetime <- dmy_hms(data$datetime)
data$date <- dmy(data$date)
#data$time <- hms(data$time)

#Subset table (2007-02-01 to 2007-02-02)
sampledates <- c(ymd_hms("2007-02-01 00:00:00", tz="UTC"), ymd_hms("2007-02-02 00:00:00", tz="UTC"))
data$sample <- data$date %in% sampledates
sample <- data[data$sample, ]

##CODE TO PLOT
par(mfrow=c(2,2), cex=0.6, bg="transparent")

#Plot 4-1
plot(sample$datetime, sample$globalactivepower, type="l", xlab="", ylab="Global Active Power")

#Plot 4-2
plot(sample$datetime, sample$voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot 4-3
plot(sample$datetime, sample$submetering1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(sample$datetime, sample$submetering2, type="l", xlab="", ylab="", col="red")
lines(sample$datetime, sample$submetering3, type="l", xlab="", ylab="", col="blue")
legend("topright", lwd=1, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot 4-4
plot(sample$datetime, sample$globalreactivepower, type="l", xlab="datetime", ylab="Global_reactive_power")

#Copy plot to png
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()

