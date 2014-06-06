con<-file("./household_power_consumption/household_power_consumption.txt")
open(con)

allData <- read.table(con,sep=";",header=TRUE,na.strings = "?",stringsAsFactors=FALSE)
allData$Date <- as.Date(allData$Date,format="%d/%m/%Y")

useData <- subset(allData,allData$Date==as.Date("2007-02-01")|allData$Date==as.Date("2007-02-02"))
rm("allData")

useData<-within(useData, { timestamp=format(as.POSIXct(paste(useData$Date, useData$Time)), "%Y-%m-%dT%H:%M:%S") })
useData$timestamp<-strptime(useData$timestamp, "%Y-%m-%dT%H:%M:%S")
zdf <- zoo(useData$Global_active_power, order.by=useData$timestamp)

png("./figure/plot2.png")
plot(zdf,xlab="",ylab="Global Active Power (kilowatts)")
dev.off()