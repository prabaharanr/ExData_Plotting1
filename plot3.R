##Read all data from the text file
ds_All <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")
ds_All$Date <- as.Date(ds_All$Date,"%d/%m/%Y")

##Date range to filter the data for the analysis
range <- as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d")

##Filter the data between the date range
ds <- rbind(ds_All[ds_All$Date >= range[1] & ds_All$Date <= range[2],])

##COnverting the timestamp 
ds$Time <- strptime(paste0(ds$Date,ds$Time),"%Y-%m-%d %H:%M:%S")

##Plotting the data
png("plot3.png",width = 480,height = 480)

plot(x = ds$Time, y = as.numeric(ds$Sub_metering_1),xlab = "",ylab = "Energy Sub metering",type = "n",yaxt="n")

##Getting the coordinates for the plotting region
usr <- par("usr")

##Giving the limits o y-axis
par(usr=c(usr[1:2],0,35))
## Giving the sequence of the ticks
axis(2,at=seq(2,36,9),labels=c("0","10","20","30"))

lines(x = ds$Time, y = as.numeric(ds$Sub_metering_1))
lines(x = ds$Time, y = as.numeric(ds$Sub_metering_2),col="Red")
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)
ds$Sub_metering_3[ds$Sub_metering_3 < 2] <- 2
lines(x = ds$Time, y = ds$Sub_metering_3,col="Blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,lty=1,col=c("black","red","blue"),pch = c(NA,NA,NA))

dev.off()