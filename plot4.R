con<-file("./household_power_consumption/household_power_consumption.txt")
open(con)

allData <- read.table(con,sep=";",header=TRUE,na.strings = "?",stringsAsFactors=FALSE)
allData$Date <- as.Date(allData$Date,format="%d/%m/%Y")

useData <- subset(allData,allData$Date==as.Date("2007-02-01")|allData$Date==as.Date("2007-02-02"))
rm("allData")

useData<-within(useData, { timestamp=format(as.POSIXct(paste(useData$Date, useData$Time)), "%Y-%m-%dT%H:%M:%S") })
useData$timestamp<-strptime(useData$timestamp, "%Y-%m-%dT%H:%M:%S")
zdfsub1 <- zoo(useData$Sub_metering_1, order.by=useData$timestamp)
zdfsub2 <- zoo(useData$Sub_metering_2, order.by=useData$timestamp)
zdfsub3 <- zoo(useData$Sub_metering_3, order.by=useData$timestamp)

png("./figure/plot3.png")
zdfAll <- cbind(zdfsub1,zdfsub2,zdfsub3)
plot(z, screens = 1, col = c("black","red","blue"),ylab="Energy sub metering",xlab="")
dev.off()


