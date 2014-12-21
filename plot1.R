## get data
source("getData.R")

## Plot1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
## for each of the years 1999, 2002, 2005, and 2008.

## summarize data from NEI by year
y<- ddply(NEI, c("year"), summarize, Emissions=sum(Emissions))
 
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(y$year, y$Emissions, type='l', xlab="Year", ylab="Emmissions", main="Total Emmissions Trend \n 1999 thru 2008")
axis(side=1, at=1:3)
axis(side=2)
box()
dev.off()

