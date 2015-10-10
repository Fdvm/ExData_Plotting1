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


# Constructing 4 graphs

png(file = "plot4.png")
par(mfcol = c(2,2), cex = 0.8, mar = c(4,4,4,2)+0.1)
plot(dt$date.time,dt[,3], type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
with(dt,{plot(date.time, Sub_metering_1, type = "l",  
              ylab = "Energy sub metering",
              xlab = "", col = 1)
        lines(date.time,Sub_metering_2, col = 2)
        lines(date.time,Sub_metering_3, col = 4)
        legend("topright", lty = 1, col = c(1,2,4), 
               legend = c(paste("Sub_metering",1:3)), bty = "n")
})
plot(dt$date.time,dt$Voltage, type = "l", 
     ylab = "Voltage",
     xlab = "datetime")
plot(dt$date.time,dt$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power",
     xlab = "datetime")
dev.off()


