con<-file("./household_power_consumption.txt")
open(con)

allData <- read.table(con,sep=";",header=TRUE,na.strings = "?",stringsAsFactors=FALSE)
close(con)
allData$Date <- as.Date(allData$Date,format="%d/%m/%Y")

useData <- subset(allData,allData$Date==as.Date("2007-02-01")|allData$Date==as.Date("2007-02-02"))
rm("allData")

useData<-within(useData, { timestamp=format(as.POSIXct(paste(useData$Date, useData$Time)), "%Y-%m-%dT%H:%M:%S") })
useData$timestamp<-strptime(useData$timestamp, "%Y-%m-%dT%H:%M:%S")

library(timeDate)
library(zoo)
gapTimecourse <- zoo(useData$Global_active_power, order.by=useData$timestamp)

sub1Timecourse <- zoo(useData$Sub_metering_1, order.by=useData$timestamp)
sub2Timecourse <- zoo(useData$Sub_metering_2, order.by=useData$timestamp)
sub3Timecourse <- zoo(useData$Sub_metering_3, order.by=useData$timestamp)
allSubTimecourse <- cbind(sub1Timecourse,sub2Timecourse,sub3Timecourse)

voltTimecourse <- zoo(useData$Voltage, order.by=useData$timestamp)

grpTimecourse <- zoo(useData$Global_reactive_power, order.by=useData$timestamp)

png("./figure/plot4.png")
par(mfcol=c(2,2))
plot(gapTimecourse,xlab="",ylab="Global Active Power")
plot(allSubTimecourse, screens = 1, col = c("black","red","blue"),ylab="Energy sub metering",xlab="")
legend("topright",col=c("Black","Red","Blue"), 
       legend=c("Sub_metering_power1","Sub_metering_power2","Sub_metering_power3"),
       lty=c(1,1),cex=0.75,bty="n")
plot(voltTimecourse,xlab="",ylab="Voltage")
plot(grpTimecourse,xlab="",ylab="Global_reactive_power")
dev.off()


