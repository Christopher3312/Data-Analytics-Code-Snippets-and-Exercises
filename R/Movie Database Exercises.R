#Exercise R Script - Analysing Movie Database

#Import the Data
getwd()
#setwd("")
mov <- read.csv("Section6-Homework-Data.csv")

#Data Exploration
head(mov) #top rows
summary(mov) #column summaries
str(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library(ggplot2)

#bar chart showing days of week movies were released
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()

#filter data to keep only some Genres
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#filter again by Studio
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio ==  "WB") | (mov$Studio ==  "Fox") | (mov$Studio ==  "Universal") | (mov$Studio ==  "Sony") | (mov$Studio ==  "Paramount Pictures")
  
#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]

#Prepare the plot's data and aes layers
#Use str() or summary() to find out the correct column names
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))

#use the jitter and boxplot, removing outliers from the visualisation
p +
  geom_jitter(aes(size=Budget...mill., colour=Studio)) + 
  geom_boxplot(alpha=0.7, outlier.colour = NA) 

#save progress by placing it into a new object:
q <- p + 
  geom_jitter(aes(size=Budget...mill., colour=Studio)) + 
  geom_boxplot(alpha=0.7, outlier.colour = NA) 

#Non-data ink
q <- q +
  xlab("Genre") + #x axis title
  ylab("Gross % US") + #y axis title
  ggtitle("Domestic Gross % by Genre") #plot title

#use theme to alter visualisation
q <- q + 
  theme(
    #this is a shortcut to alter ALL text elements at once:
    text = element_text(family="Comic Sans MS"),
    
    #Axes titles:
    axis.title.x = element_text(colour="Blue", size=30),
    axis.title.y = element_text(colour="Blue", size=30),
    
    #Axes texts:
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),  
    
    #Plot title:
    title = element_text(colour="Black",
                              size=40),
    
    #Legend title:
    legend.title = element_text(size=20),
    
    #Legend text
    legend.text = element_text(size=12)
  )
q

#change legend titles
q$labels$size = "Budget $M"

#final visualisation
q
