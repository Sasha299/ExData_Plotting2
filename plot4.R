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



## Across the United States, how have emissions from coal combustion-related sources changed
## from 1999-2008?
## choose from SCC, "Short.Name" all the rows coal
## choose from SCC, "SCC.Level.One" all the rows that have Combustion
y<- SCC[grep("coal", SCC$Short.Name, ignore.case=TRUE),]
y<- y[grep("combustion", y$SCC.Level.One, ignore.case=TRUE),]
comcoalData<- ddply(NEI[NEI$SCC %in% y$SCC,], c("year"), summarize, Emissions=sum(Emissions))
## select from NEI the scc codes matching the isolated scc from the scc data frame

ggplot(comcoalData, aes(year, Emissions)) + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Coal Based Emission Trend") 
ggsave(filename = "plot4.png", width = 3.5, height = 3.5)

