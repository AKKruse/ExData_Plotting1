
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
# Actually not required for plot() function
hd2$Sub_metering_1 <- as.numeric(hd2$Sub_metering_1)
hd2$Sub_metering_2 <- as.numeric(hd2$Sub_metering_2)
hd2$Sub_metering_3 <- as.numeric(hd2$Sub_metering_3)
# Format time for plotting
hd2$Full.Date <- as.POSIXct(strptime(hd2$Full.Date, 
					format="%d/%m/%Y %H:%M:%S"))

# Set font size
par(ps=12)      # Default = 16

# Initiate png file 
# stayed with default "white" background because plot is easier to read 
# to do transparency, bg="transparent"
png(file = "plot3.png", width=480, height=480, units="px", bg="white")

# Create plot
plot(hd2$Full.Date, hd2$Sub_metering_1, type="n", xlab="", 
	ylab="Energy sub metering")
lines(hd2$Full.Date, hd2$Sub_metering_1)
lines(hd2$Full.Date, hd2$Sub_metering_2, col="red")
lines(hd2$Full.Date, hd2$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), lty=c(1,1,1), 
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

