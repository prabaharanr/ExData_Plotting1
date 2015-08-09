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
png("plot4.png",width = 480,height = 480)

par(mfrow=c(2,2))

##Plot1
plot(x = ds$Time, y = as.numeric(ds$Global_active_power)/1000,xlab = "",ylab ="Global Active Power",yaxt="n",type="n")
##Getting the coordinates for the plotting region
usr <- par("usr")

##Giving the limits o y-axis
par(usr=c(usr[1:2],0,4))
## Giving the sequence of the ticks
axis(2,at = seq(0,4,1),labels = c("0","2","4","6",""))

lines(x = ds$Time, y = as.numeric(ds$Global_active_power)/1000)

##Plot2
plot(x = ds$Time, y = as.numeric(ds$Voltage),xlab = "datetime",ylab ="Voltage",yaxt="n",type="n")
usr <- par("usr")
par(usr=c(usr[1:2],232,246))
axis(2,at = seq(231,245,2),labels = c("","234","","238","","242","","246"))

lines(x = ds$Time, y = as.numeric(as.character(ds$Voltage)))

##Plot3
plot(x = ds$Time, y = as.numeric(ds$Sub_metering_1),xlab = "",ylab = "Energy Sub metering",type = "n",yaxt="n")

##Getting the coordinates for the plotting region
usr <- par("usr")

##Giving the limits o y-axis
par(usr=c(usr[1:2],0,35))
## Giving the sequence of the ticks
axis(2,at=seq(2,36,9),labels=c("0","10","20","30"))

lines(x = ds$Time, y = as.numeric(ds$Sub_metering_1))
lines(x = ds$Time, y = as.numeric(ds$Sub_metering_2),col="Red")
lines(x = ds$Time, y = as.numeric(ds$Sub_metering_3),col="Blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,lty=1,col=c("black","red","blue"),pch = c(NA,NA,NA),bty = "n",cex = 0.40)

##Plot4
plot(x = ds$Time, y = as.numeric(ds$Global_reactive_power)/1000,xlab = "datetime",ylab ="Global_reactive_power",type="n",yaxt="n")
usr <- par("usr")
par(usr=c(usr[1:2],0.0,0.25))
axis(2,at=seq(0.01,0.24,0.045),labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))
lines(x = ds$Time, y = as.numeric(ds$Global_reactive_power)/1000)

dev.off()