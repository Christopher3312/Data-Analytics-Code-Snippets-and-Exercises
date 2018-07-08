#Set the Working Directory
getwd() #already correct
#setwd("_")
#getwd()

#Import the csv dataset
data <- read.csv("Section5-Homework-Data.csv")

#Explore the data
data
head(data, n=6)      #check top 6 rows
tail(data, n=7) #check bottom 7 rows
str(data)      #check the structure of the data frame
summary(data)      #check the summary of the data

#Filter the dataframes
data1960 <- data[data$Year==1960,]
data2013 <- data[data$Year==2013,]

#Check row counts
nrow(data1960) #187 rows
nrow(data2013) #187 rows. Equal split.
head(data1960)

#Create the additional dataframes
add1960 <- data.frame(Code=Country_Code, Life.Exp=Life_Expectancy_At_Birth_1960)
add2013 <- data.frame(Code=Country_Code, Life.Exp=Life_Expectancy_At_Birth_2013)

#Check summaries
summary(add1960)
summary(add2013)

#Merge the pairs of dataframes  
merged1960 <- merge(data1960, add1960, by.x="Country.Code", by.y="Code")
merged2013 <- merge(data2013, add2013, by.x="Country.Code", by.y="Code")

#Check the new structures
str(merged1960)
str(merged2013)

#Remove obselete column in the dataframes
merged1960$Year <- NULL
merged2013$Year <- NULL

#Check structures again
str(merged1960)
str(merged2013)

#Visualization time
library(ggplot2)

#Visualize the 1960 dataset
qplot(data=merged1960, x=Fertility.Rate, y=Life.Exp,
      colour=Region,                               #colour
      size=I(5), 
      alpha=I(0.6),                               #transparency
      main="Life Expectancy vs Fertility (1960)" #title
   )

#Visualize the 2013 dataset
qplot(data=merged2013, x=Fertility.Rate, y=Life.Exp,
      colour=Region,                               #colour
      size=I(5), 
      alpha=I(0.6),                               #transparency
      main="Life Expectancy vs Fertility (2013)" #title
)





