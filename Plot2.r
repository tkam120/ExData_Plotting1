
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

## converting to numeric
pwrdata$Global_active_power <- as.numeric(pwrdata$Global_active_power)
pwrdata$datetime<- as.POSIXct(strptime(paste(pwrdata$Date,pwrdata$Time,sep = " "),format = "%Y-%m-%d %H:%M:%S"))

png("plot2.png", width=480, height=480, units="px")
with(pwrdata, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
