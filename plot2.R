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
png("plot2.png",width = 480,height = 480)

plot(x = ds$Time, y = as.numeric(ds$Global_active_power)/1000,xlab = "",ylab = "Global Active Power(Kilowatts)",yaxt="n",type = "n")

##Getting the coordinates for the plotting region
usr <- par("usr")

##Giving the limits o y-axis
par(usr=c(usr[1:2],0,4))
## Giving the sequence of the ticks
axis(2,at = seq(0,4,1),labels=c("0","2","4","6",""))

lines(x = ds$Time, y = as.numeric(ds$Global_active_power)/1000)

dev.off()