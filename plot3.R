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

if (!require(reshape)) {
      install.packages("reshape")
}


if(!exists("household_power_data3")) {
      ## filter dataset to make bill happy
      household_power_data3 <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",
                                           sep=";")
      
      household_power_data3$DateTime<-as.POSIXct(paste(household_power_data3$Date,household_power_data3$Time), format="%d/%m/%Y %H:%M:%S")
      household_power_data3<-melt(household_power_data3[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3","DateTime")], id="DateTime")
      
} else {
      print("household_power_data3 already exists, no need to read it again")
}  

gr<-ggplot(household_power_data3, 
      aes(household_power_data3$DateTime,value, col=variable)) + 
      geom_line(xlab="") + theme_classic() + theme(axis.title.x = element_blank()) +   
      ylab("Energy sub metering") +  theme(legend.title = element_blank()) + theme(legend.position=c(0.7,.8))


gr<-gr + scale_x_datetime(breaks = date_breaks("1 day"),labels=function(x) format(x,"%a")) 
print(gr)
dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file
dev.off() 
