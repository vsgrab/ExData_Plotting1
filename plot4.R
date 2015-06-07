if (!require(sqldf)) {
      install.packages("sqldf")
}


if (!require(scales)) {
      install.packages("scales")
}

if (!require(reshape)) {
      install.packages("reshape")
}

if (!require(grid)) {
      install.packages("grid")
}

vp.BottomLeft <- viewport(height=unit(.5, "npc"), width=unit(0.5, "npc"), 
                           just=c("left","top"), 
                           y=0.5, x=0.0)

par(mfrow=c(2,2))
if(!exists("household_power_data4")) {
household_power_data4 <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",
                                            sep=";")
household_power_data4$DateTime<-as.POSIXct(paste(household_power_data4$Date,household_power_data4$Time), format="%d/%m/%Y %H:%M:%S")      
} else {
      print("household_power_data4 already exists, no need to read it again")
}  
##Graph1
gr1<-plot(household_power_data4$DateTime,household_power_data4$Global_active_power,geom="line",
           ylab = "Global Active Power",group = 1, xlab="" , type="l")
gr2<-plot(household_power_data4$DateTime,household_power_data4$Voltage,geom="line",
          ylab = "Voltage",group = 1, xlab="datetime" , type="l")

household_power_data3<-melt(household_power_data4[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3","DateTime")], id="DateTime")

gr3<-plot.new()

gr3<-ggplot(household_power_data3, 
            aes(household_power_data3$DateTime,value, col=variable)) + 
      geom_line(xlab="") + theme_classic() + theme(axis.title.x = element_blank()) +   
      ylab("Energy sub metering") + theme(legend.position=c(0.7,.8)) +  theme(legend.title = element_blank())

gr3<-gr3 + scale_x_datetime(breaks = date_breaks("1 day"),labels=function(x) format(x,"%a")) 
print(gr3, vp=vp.BottomLeft)
gr4<-plot(household_power_data4$DateTime,household_power_data4$Global_reactive_power,geom="line",
          ylab = "Global Reactive Power",group = 1, xlab="datetime" , type="l")



dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off() 
