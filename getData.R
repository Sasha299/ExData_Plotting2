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
