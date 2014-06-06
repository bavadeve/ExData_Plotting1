con<-file("./household_power_consumption/household_power_consumption.txt")
open(con)

allData <- read.table(con,sep=";",header=TRUE,na.strings = "?",stringsAsFactors=FALSE)
allData$Date <- as.Date(allData$Date,format="%d/%m/%Y")

useData <- subset(allData,allData$Date==as.Date("2007-02-01")|allData$Date==as.Date("2007-02-02"))
rm("allData")

png("./figure/plot1.png")
with(useData,hist(useData$Global_active_power,col="red",
                  main="Global Active Power",
                  xlab="Global Active Power (kilowatts)",
                  ylab="Frequency"))
dev.off()