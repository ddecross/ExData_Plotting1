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

## Plot 1
## Line graph of time series.  I set the canvas to print only
## one plot per page, Print the line graph and border in black.  Pull the date
## and time and make a new variable that will include Date, hour, min and Seconds
## graph the frequency.

t_house$DateTime <- ymd_hms(paste(
    t_house$Date,
    hour(t_house$Time),
    minute(t_house$Time),
    second(t_house$Time)
))

library(datasets)

par(1,1) ## only one plot per page

with(
    t_house, plot(
        DateTime,              ## x-axis values
        Global_active_power,   ## y-axis
        type = "l",    ## Print a line graph
        main = "",                ## Set No Header
        ylab = "Global Active Power (kilowatts)",  ## set y-axis label
        xlab = ""
    )
)   ## Set x-axis off

## Print out the plot as a .PNG, placing it in my Project folder
dev.copy(png, file = "./Project Code/Exploratory Data Analysis/plot2.png", width =
             480, height = 480)
dev.off()
