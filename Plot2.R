# Exploratory Data Analysis - Wk1- Proj1 
# This is the script is for Plot2.
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

# Read the file into R, but only for dates February 1, 2007 and February 2, 2007 instead of the full large file to save space and memory.
HPCdata <- read.csv("./Project1/Household_Power_Consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# take the subset of the full data to pull information only for the given dates
subdata <- subset(HPCdata, Date %in% c("1/2/2007","2/2/2007"))
# convert the date column using as.Date function
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
# concatenate data and time and convert that into a POSIXct date and add that as a new column of the subset data set
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

## Plot 2
with(subdata, {
        plot(Global_active_power~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
})
dev.copy(png, file = "./Project1/Plot2.png", height = 480, width = 480)
dev.off()
