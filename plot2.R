#Create a folder where put the data

dir.create("C:/Users/arubioca/Desktop/project")

#Change the working directory to this folder

setwd("./project")

#Download the zip data onto this folder
#I dropped the "s" on "https" in order to avoid the "curl" method (Windows version)

URL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip" 
download.file(URL,destfile = "./power.zip")

#Now I unzip the folder

unzip("./power.zip")

#Now we read the data from the .txt

datos <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec= ".", na.strings = "?", stringsAsFactors = FALSE)

#We change the format of the field Date
install.packages("date")
install.packages("lubridate")
library(date)
library(lubridate)

datos$Date <- as.Date(datos$Date, format = "%d/%m/%Y")


fechas <- as.Date(c("01/02/2007","02/02/2007"), format = "%d/%m/%Y")

#Select only the data having Date in fechas

datos <- datos[datos$Date %in% fechas,]

#Before drawing the second plot, we create the datetime field
# We concatenate the date strings of dates and time

datetime <- paste(as.character(datos$Date),as.character(datos$Time),sep = " ")

datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(datetime, datos$Global_active_power, type = "l", xlab = "" , ylab = "Global Active Power (kilowatts)")
dev.off()
