## get data
source("getData.R")

## Plot 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## choose "On-Road" and baltimore city from NEI and plot and summarize by year
## assuming "motor vehicle sources" mean on-road sources and  not all motorized vihicles (on and off road)
vehData<- ddply(NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",], c("year"), summarize, Emissions=sum(Emissions))

## Plot data
ggplot(vehData, aes(year, Emissions)) + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Motor Vehicle Emission Trend") 
ggsave(filename = "plot5.png", width = 3.5, height = 3.5)
