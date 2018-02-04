# Exploratory Data Analysis - Wk1- Proj1 
# This is the script is for Plot4.
# Check and create a new directory called Project1

if (!file.exists("./Project1")){
        dir.create("./Project1")
}

#Download from the website and unzip the data file into the newly created directory 

zipfileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfileURL,destfile = "./Project1/Household_Power_Consumption.zip")

if (!file.exists("./Project1/Household_Power_Consumption")) {
        unzip("./Project1/Household_Power_Consumption.zip", exdir="./Project1")
}


HPCdata <- read.table("./Project1/Household_Power_Consumption.txt", header = T, 
                      sep = ";", na.strings = "?")
# convert the date variable to Date class
HPCdata$Date <- as.Date(HPCdata$Date, format = "%d/%m/%Y")

# Subset the data
subdata <- subset(HPCdata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
subdata$datetime <- strptime(paste(subdata$Date, subdata$Time), "%Y-%m-%d %H:%M:%S")

# Plot 4
subdata$datetime <- as.POSIXct(subdata$datetime)
par(mfrow = c(2,2))
attach(subdata)
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", 
     xlab = "")
plot(Voltage ~ datetime, type = "l")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", 
     xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(Global_reactive_power ~ datetime, type = "l")

dev.copy(png, file = "./Project1/Plot4.png", height = 480, width = 480)
dev.off()
detach(subdata)
