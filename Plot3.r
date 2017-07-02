#download household_power_consumption.txt
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile = "exdata_data_household_power_consumption.zip", method = "curl")

unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt")

pwrdata <-read.table("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     colClasses = rep("character",9))

pwrdata[pwrdata == "?"] <- NA
pwrdata$Date <- as.Date(pwrdata$Date, format="%d/%m/%Y")

## subset data between 2007-02-01 and 2007-02-02
pwrdata<- pwrdata[pwrdata$Date >= as.Date("2007-02-01") & pwrdata$Date <= as.Date("2007-02-02"),]
pwrdata$datetime<- as.POSIXct(strptime(paste(pwrdata$Date,pwrdata$Time,sep = " "),format = "%Y-%m-%d %H:%M:%S"))

## converting to numeric
pwrdata$Sub_metering_1 <- as.numeric(pwrdata$Sub_metering_1)
pwrdata$Sub_metering_2 <- as.numeric(pwrdata$Sub_metering_2)
pwrdata$Sub_metering_3<- as.numeric(pwrdata$Sub_metering_3)

png("plot3.png", width=480, height=480, units="px")
with(pwrdata, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(pwrdata, points(datetime, Sub_metering_2, type="l",col="red"))
with(pwrdata, points(datetime, Sub_metering_3, type="l",col="blue"))

legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()     
