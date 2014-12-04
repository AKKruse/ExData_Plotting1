
# Load data.table package and Read in file
# Assumes data file is already unzipped and in the local directory
library(data.table)
house_data <- fread("household_power_consumption.txt",na.strings="?")

# Get only dates in February needed: Format dd/mm/yyyy
hd2 <- house_data[house_data$Date == "1/2/2007" | house_data$Date=="2/2/2007",]
rm("house_data")

# Combine Date and Time info into new column
hd2[,Full.Date:=paste(Date,Time)]

# Convert to numeric in order to plot 
hd2$Global_active_power <- as.numeric(hd2$Global_active_power)
# Format time for plotting
hd2$Full.Date <- as.POSIXct(strptime(hd2$Full.Date, format="%d/%m/%Y %H:%M:%S"))

# Set font size
par(ps=12)      # Default = 16

# Create plot
plot(hd2$Full.Date,hd2$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)") 

# Copy to a png file
# stayed with default "white" background because it makes the plot clearer
# to do transparency, bg="transparent"
dev.copy(png, file="plot2.png", width=480, height=480, units="px", bg="white")
dev.off()

