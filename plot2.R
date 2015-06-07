##Dedicated to Bill Gates.
##640 kB ought to be enough for anybody.  

if (!require(sqldf)) {
      install.packages("sqldf")
}

if (!require(ggplot2)) {
      install.packages("ggplot2")
}

if (!require(scales)) {
      install.packages("scales")
}


if(!exists("household_power_data2")) {
      ## filter dataset to make bill happy
      household_power_data2 <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",
                                           sep=";")
      household_power_data2$DateTime<-as.POSIXct(paste(household_power_data2$Date,household_power_data2$Time), format="%d/%m/%Y %H:%M:%S")
} else {
      print("household_power_data already exists, no need to read it again")
}  


gr<-qplot(household_power_data2$DateTime,household_power_data2$Global_active_power,geom="line",
          ylab = "Global Active Power (killowatts)",group = 1, xlab="")
gr<-gr + scale_x_datetime(breaks = date_breaks("1 day"),labels=function(x) format(x,"%a"))  + theme_classic()
print(gr)
dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off() 
