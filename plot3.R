###########################################################
##
## Coursera Exploratory Data Analysis Project 1
## Reproduce graphs
## Doug DeCross
## 20151008
##
###########################################################

## Read in the data set, only get data for 2 dates in scope of project
t_house <-
    subset(
        read.csv(
            "./data/household_power_consumption.txt",
            sep = ";",
            na.strings = "?",
            header = TRUE
        ),
        Date %in% c("1/2/2007","2/2/2007")
    )

## Convert Date and Time
library(lubridate)
t_house$Date <- dmy(t_house$Date)
t_house$Time <- hms(t_house$Time)

## Convert character numbers to real numbers
t_house[,3:9] <- sapply(t_house[,3:9], as.numeric)

## Create a new column that has the date and time together
t_house$DateTime <- ymd_hms(paste(
    t_house$Date,
    hour(t_house$Time),
    minute(t_house$Time),
    second(t_house$Time)
))

## Plot 3
## Put the information from 3 columns on one graph

library(datasets)

## I am sending the output to the png while I build it instead of
## doing a copy at the end.  I found that doing the copy at the
## end caused the legend to be distorted.  Doing it this way
## printed the Legend clearly.
png(file = "./Project Code/Exploratory Data Analysis/plot3.png",
    width = 480,
    height = 480)
par(mfrow = c(1,1)) ## only one plot per page
with(
    t_house, plot(
        DateTime,                      ## x-axis values
        Sub_metering_1,                ## y-axis
        type = "l",                    ## Print a line graph
        col = "black",
        main = "",                     ## Set No Header
        ylab = "Energy sub metering",  ## set y-axis label
        xlab = ""
    )
)            ## Set x-axis off
with(t_house, lines(DateTime,              ## x-axis values
                    Sub_metering_2,        ## y-axis
                    col = "red"))          ## Set x-axis off
with(t_house, lines(DateTime,              ## x-axis values
                    Sub_metering_3,        ## y-axis
                    col = "blue"))         ## Set x-axis off
## Add the Legend in the top right corner of the plot
legend(
    "topright",
    col = c("black","red", "blue"),
    lty = 1,
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)


## Close the device

dev.off()
