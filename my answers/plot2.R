##PLOT 2

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

#Subset table (2007-02-01 to 2007-02-02)
sampledates <- c(ymd_hms("2007-02-01 00:00:00", tz="UTC"), ymd_hms("2007-02-02 00:00:00", tz="UTC"))
data$sample <- data$date %in% sampledates
sample <- data[data$sample, ]

##CODE TO PLOT
par(cex=0.8, bg="transparent")
plot(sample$datetime, sample$globalactivepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()

