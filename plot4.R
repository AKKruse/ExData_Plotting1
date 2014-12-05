
# Load data.table package and Read in file
# Assumes data file is already unzipped and in the local directory
library(data.table)
house_data <- fread("household_power_consumption.txt",na.strings="?")

# Get only dates in February needed: Format dd/mm/yyyy
hd2 <- house_data[house_data$Date == "1/2/2007" 
		    | house_data$Date=="2/2/2007",]
rm("house_data")

# Combine Date and Time info into new column
hd2[,Full.Date:=paste(Date,Time)]

# Convert to numeric in order to plot 
# Actually not necessary for plot()
hd2$Sub_metering_1 <- as.numeric(hd2$Sub_metering_1)
hd2$Sub_metering_2 <- as.numeric(hd2$Sub_metering_2)
hd2$Sub_metering_3 <- as.numeric(hd2$Sub_metering_3)
hd2$Global_active_power <- as.numeric(hd2$Global_active_power)
hd2$Global_reactive_power <- as.numeric(hd2$Global_reactive_power)
hd2$Voltage <- as.numeric(hd2$Voltage)
# Format time for plotting
hd2$Full.Date <- as.POSIXct(strptime(hd2$Full.Date, 
					format="%d/%m/%Y %H:%M:%S"))

# Set font size
par(ps=12)      # Default = 16

# Initiate a png file 
# stayed with default "white" background because plot is easier to read 
# to do transparency, bg="transparent"
png(file = "plot4.png", width=480, height=480, units="px", bg="white")

# Partition graphics
par(mfrow=c(2,2))

# Create plots
plot(hd2$Full.Date, hd2$Global_active_power, type="l", 
	ylab="Global Active Power", xlab="")

plot(hd2$Full.Date, hd2$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(hd2$Full.Date, hd2$Sub_metering_1, type="n", xlab="", 
	ylab="Energy sub metering")
lines(hd2$Full.Date, hd2$Sub_metering_1)
lines(hd2$Full.Date, hd2$Sub_metering_2, col="red")
lines(hd2$Full.Date, hd2$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), lty=c(1,1,1), bty="n", 
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(hd2$Full.Date, hd2$Global_reactive_power, type="l", 
	ylab="Global_reactive_power", xlab="datetime")

dev.off()

