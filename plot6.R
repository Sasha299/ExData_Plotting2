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


## Plot 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
## has seen greater changes over time in motor vehicle emissions?

## choose the data from Baltimore City Maryland and Los Angeles County, California
y<-c("24510", "06037")
taleoftwoCities<- ddply(NEI[NEI$fips %in% y & NEI$type=="ON-ROAD",], c("fips","year"), summarize, Emissions=sum(Emissions))

## plot 

ggplot(taleoftwoCities, aes(year, Emissions, color = fips)) + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Emission trends, \n Baltimore City vs Los Angeles") +scale_colour_discrete(name="Cities", labels=c("Los Angeles, CA","Baltimore City, MD")) 
ggsave(filename = "plot6.png", width = 5, height = 5)