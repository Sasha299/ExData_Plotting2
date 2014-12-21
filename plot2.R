## get data
source("getData.R")


## Plot 2
## Have total emissions from PM2.5 decreased in the 
## Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the
## base plotting system to make a plot answering this question.

## Choose only Baltimore City, Maryland (fips == "24510")

y<- ddply(NEI[NEI$fips=="24510",], c("year"), summarize, Emissions=sum(Emissions))

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(y$year, y$Emissions, type='l', xlab="Year", ylab="Emmissions from PM2.5", 
     main="Total PM2.5 Emmissions in Baltmore City, Maryland \n 1999 to 2008")
axis(side=1, at=1:3)
axis(side=2)
box()
dev.off()
