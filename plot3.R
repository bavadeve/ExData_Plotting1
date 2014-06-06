con<-file("./household_power_consumption/household_power_consumption.txt")
open(con)

allData <- read.table(con,sep=";",header=TRUE,na.strings = "?",stringsAsFactors=FALSE)
allData$Date <- as.Date(allData$Date,format="%d/%m/%Y")

useData <- subset(allData,allData$Date==as.Date("2007-02-01")|allData$Date==as.Date("2007-02-02"))
rm("allData")

useData<-within(useData, { timestamp=format(as.POSIXct(paste(useData$Date, useData$Time)), "%Y-%m-%dT%H:%M:%S") })
useData$timestamp<-strptime(useData$timestamp, "%Y-%m-%dT%H:%M:%S")
sub1Timecourse <- zoo(useData$Sub_metering_1, order.by=useData$timestamp)
sub2Timecourse <- zoo(useData$Sub_metering_2, order.by=useData$timestamp)
sub3Timecourse <- zoo(useData$Sub_metering_3, order.by=useData$timestamp)
allSubTimecourse <- cbind(sub1Timecourse,sub2Timecourse,sub3Timecourse)

png("./figure/plot3.png")
plot(allSubTimecourse, screens = 1, col = c("black","red","blue"),ylab="Energy sub metering",xlab="")
legend("topright",col=c("Black","Red","Blue"), 
       legend=c("Sub_metering_power1","Sub_metering_power2","Sub_metering_power3"),
       lty=c(1,1))
dev.off()


