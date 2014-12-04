
# Load data.table package and Read in file
# Assumes data file is already unzipped and in the local directory
library(data.table)
house_data <- fread("household_power_consumption.txt",na.strings="?")

# Get only dates in February needed: Format dd/mm/yyyy
hd2 <- house_data[house_data$Date == "1/2/2007" | house_data$Date=="2/2/2007",]
rm("house_data")

# Convert to numeric in order to plot 
hd2$Global_active_power <- as.numeric(hd2$Global_active_power)

# Plot histogram
hist(hd2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)",yaxt='n',xaxt='n')
axis(side=1, at=seq(0,6,2))
axis(side=2, at=seq(0,1200,200))

# Copy to a png file
# stayed with default "white" background because it makes the plot clearer
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()


