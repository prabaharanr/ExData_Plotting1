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
png("plot1.png",width = 480,height = 480)

hist(x = as.numeric(ds$Global_active_power)/1000,col = "Red",xlab = "Global Active Power (Kilowatts)",main = "Global Active Power",yaxt="n",xaxt="n")
axis(1,at=seq(0,3,1),labels = c("0","2","4","6"))
axis(2,at=seq(0,1200,195),labels = c("0","200","400","600","800","1000","1200"))

dev.off()