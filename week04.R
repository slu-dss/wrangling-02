# ==========================================================================

# DATA SCIENCE SEMINAR, SPRING 2016, WEEK 04

# ==========================================================================

# opening options

rm(list = ls()) # clear workspace

# ==========================================================================

# file name - week04.R

# project name - data science seminar, spring 2016

# purpose - week 03 examples - working with numeric data

# created - 14 Mar 2016

# updated - 14 Mar 2016

# author - CHRIS

# ==========================================================================

# full description - this file contains the code for replicating the 
# examples described during the week 04 meeting

# updates - none

# ==========================================================================

# superordinates  - none

# subordinates - none

# ==========================================================================
# ==========================================================================

# Follow-up - Working Directory Operations

# get working directory
getwd() 

# to change your working directory
# setwd(dir)
setwd("/Users/herb/Documents")

# confirm change
getwd()

# ==========================================================================
# ==========================================================================

# Load Example Data

library(datasets) # open datasets package
df <- cars # load cars dataset into data frame named df
str(df)

# ==========================================================================
# ==========================================================================

# Review from Week 03
mean(df$speed) # mean
sd(df$speed) # standard deviation
median(df$speed) # median
range(df$speed) # range
hist(df$speed) # histogram

summary(df$speed) # can get median, range, 25th and 7th percentiles at once

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Saving Simple Plots
dev.copy(png,'df_speed.png') # create file from content of plot window
dev.off() # save file

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Review from Week 01
is.numeric(df$speed)
is.factor(df$speed)

# ==========================================================================
# ==========================================================================

# Create Factor from Numeric Variable
# may be required for some statistical applications if a numeric variable
# can only take on certain specific values
df$SpeedFactor <- as.factor(df$speed)
is.factor(df$SpeedFactor) # see Week 01
class(df$SpeedFactor) # view class of object
summary(df$SpeedFactor) # view frequencies for factor data

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Create Ordinal with 5 Breaks
df$speedOrdinal <- cut(df$speed,breaks=5) # create ordinal variable
is.factor(df$speedOrdinal) 
summary(df$speedOrdinal) 

# Tell R this is an ordinal variable
df$speedOrdinal <- cut(df$speed,breaks=5, ordered = TRUE)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Include Labels in Creation of Ordinal Variable
df$speedOrdinal2 <- cut(df$speed,breaks=5,labels=c("lowest group",
    "lower middle group", "middle group", "upper middle", "highest group"), 
    ordered = TRUE)
summary(df$speedOrdinal2) # view frequencies for factor data

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Specify break points
# intro to sequence function
seq(0, 25, by = 5)

# Create ordinal with specific values
df$speedOrdinal3 <- cut(df$speed,breaks=seq(0, 25, by = 5), ordered = TRUE)
summary(df$speedOrdinal3)

# Create ordinal with specific values (alternate method)
df$speedOrdinal4 <- cut(df$speed,breaks=c(0, 10, 25),labels=c("low","high"))
summary(df$speedOrdinal4)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Create binary variable
df$speedBin <- ifelse(df$speed > 20, c(1), c(0))

# ==========================================================================
# ==========================================================================

# Create Numeric from Factor Variable
df$SpeedNumeric <- as.numeric(df$SpeedFactor) # to go from Factor to Numeric
is.factor(df$SpeedNumeric)
is.numeric(df$SpeedNumeric)

# ==========================================================================
# ==========================================================================

# closing options

# {none}

# ==========================================================================

# exit

