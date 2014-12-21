## get data
## load the dataset
## set global variables 
setglobalVariable <- function(){
        NEI<<-NULL
        SCC<<-NULL
        ## setting global variables to null
        
}   

getVariables<- function(){
        NEI <<- readRDS("summarySCC_PM25.rds")
        SCC <<- readRDS("Source_Classification_Code.rds")
        ## reading file into global variables
}


## retreive data and load into global variable
getfile<- function(){
        if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")){
                temp <- tempfile()
                ## Create a temp file to hold the Zipped file
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
                ## Download the zipped file to temp
                temp<-unzip(temp)
        }
        getVariables()
        
}

## check if global variable exists, if does not, retrieve file
if(!exists("NEI") & !exists("SCC")){
        setglobalVariable() 
        getfile()
        print("NEI and SCC do not exist")
} 


##  Plot 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999-2008 
## for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
## ggplot2 plotting system to make a plot answer this question.

## choose only the data from Baltimore City Maryland
balCity<- ddply(NEI[NEI$fips=="24510",], c("type","year"), summarize, Emissions=sum(Emissions))

## plot 

ggplot(balCity, aes(year, Emissions, color = type)) + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Emission trends by source") 
ggsave(filename = "plot3.png", width = 4, height = 4)
