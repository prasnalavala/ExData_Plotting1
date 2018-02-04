# Exploratory Data Analysis - Wk1- Proj1 

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
subsetdata <- subset(read.csv2("./Project1/Household_Power_Consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = TRUE), Date %in% c("2/1/2007","2/2/2007"))
# Convert factor variable into character and then into numeric
subsetdata$Global_active_power <- as.numeric(as.character(subsetdata$Global_active_power))
png("./Project1/Plot1.png")
hist(subsetdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", ylab = "Frequency" )
dev.copy(device = png, filename = 'Plot1.png', width = 480, height = 480) 
dev.off()

