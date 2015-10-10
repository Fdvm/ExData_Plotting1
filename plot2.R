setwd("working_directory")


file <- "household_power_consumption.txt"
get.data <- function(file) {
        z <- read.table(file, header = T, sep = ";",na.strings = "?")
        z$date.time <- strptime(paste(z$Date,z$Time), "%d/%m/%Y %H:%M:%S")
        z$Date <- as.Date(z$Date, "%d/%m/%Y")
        dt <- z[z$Date %in% as.Date(c("2007-02-01","2007-02-02")),]
        write.table(dt, "new.txt", sep = ";", row.names = F, col.names = T)
        
}

get.data(file)
dt <- read.table("new.txt", header = T,  sep = ";")
dt$date.time <- strptime(paste(dt$Date,dt$Time), "%Y-%m-%d %H:%M:%S")
dt$Date <- as.Date(dt$Date, "%Y-%m-%d")


# Constructing Line chart

png(file = "plot2.png")
plot(dt$date.time,dt[,3], type = "l", main = "Global Active Power", 
             ylab = "Global Active Power (kilowatts)",
             xlab = "")
dev.off()
