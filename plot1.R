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
## Histogram of Global Active Power.  I set the canvas to print only
## one plot per page, Print the Histogram in Red, Set a header and an x axis label.

library(datasets)

par(1,1) ## only one plot per page

with(
    t_house, hist(
        Global_active_power,
        col = "red",                                   ## Set bars red
        main = "Global Active Power",                ## Set Header
        xlab = "Global Active Power (kilowatts)"
    )
)   ## Set x-axis label

## Print out the plot as a .PNG, placing it in my Project folder
dev.copy(png, file = "./Project Code/Exploratory Data Analysis/plot1.png", width =
             480, height = 480)
dev.off()
