# Exploratory Analysis Course Project 1
# To create four plots

# Step 1 : to download and unzip the data


temp<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp,mode="wb")
unzip(temp,"household_power_consumption.txt")
dd<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
unlink(temp)

#CONVERTING DATE FORMAT
dd$Date<-as.Date(dd$Date,"%d/%m/%Y") #format dd/mm/yyyy


#adding column with total date 
#since there is no pure time object this method has to be followed
dd$TotalDate<-paste(dd$Date,dd$Time)
dd$TotalDate<-strptime(dd$TotalDate,"%Y-%m-%d %H:%M:%S")

#dd<-cbind(dd,myTotalDate)

#now filter as per date
mynewdd<-subset(dd,dd$Date=="2007-02-01" | dd$Date=="2007-02-02")

mynewdd$Global_active_power<-as.numeric(levels(mynewdd$Global_active_power))[mynewdd$Global_active_power] #coerces ? to NA
mynewdd$Global_reactive_power<-as.numeric(levels(mynewdd$Global_reactive_power))[mynewdd$Global_reactive_power] #coerces ? to NA
mynewdd$Voltage<-as.numeric(levels(mynewdd$Voltage))[mynewdd$Voltage] #coerces ? to NA

mynewdd<-mynewdd[complete.cases(mynewdd),]




#plot3
windows(width=480,height=480,unit="px")

plot(mynewdd$TotalDate,mynewdd$Sub_metering_1, col='black',type='l',xlab="",ylab='Energy sub metering')
lines(mynewdd$TotalDate,mynewdd$Sub_metering_2, col='red',type='l')
lines(mynewdd$TotalDate,mynewdd$Sub_metering_3, col='blue',type='l')
legend("topright",c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
dev.copy(png,'plot3.png',width=480,height=480,units="px")
dev.off()
