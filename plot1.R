##Dedicated to Bill Gates.
##640 kB ought to be enough for anybody.  

if (!require(sqldf)) {
      install.packages("sqldf")
}

if (!require(ggplot2)) {
      install.packages("ggplot2")
}



if(!exists("household_power_data"))
{
      ## filter dataset to make bill happy
      household_power_data <- read.csv.sql("./household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",
                                           sep=";")
} else {
      print("household_power_data already exists, no need to read it again")
}  

gr<-qplot(household_power_data$Global_active_power,geom="histogram",main = "Global Active Power",
          fill=I("red"),col=I("black"),xlab = "Global Active Power (killowatts)",ylab="Frequency",
          binwidth=0.5,xlim=c(0,6))
gr<-gr  + theme_classic()
print(gr)
dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off() 
