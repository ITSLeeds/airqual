#install and load package | OPENAIR
#note: openair now relies on several packages, which if not available need to be installed
install.packages("openair")
library(openair)

# import data.frame i.e. read .csv file
aq16 <- read.csv("Putney_ENVdata_2016.csv", header=T, na.strings="NA")

# useful data.frame check command
summary(aq16)

# define date & time format, add to data.frame, rename headers
datetime <- as.POSIXct(strptime(aq16$datetext, format = "%d/%m/%Y %H:%M", "GMT"))
aq16 <- cbind(aq16, datetime)
names(aq16)[1:11] <- c("datetext","no2_PutneyBackground","nox_PutneyBackground","no2_PutneyHighStreet","nox_PutneyHighStreet",
                     "no2_PutneyHighStreetFacade","nox_PutneyHighStreetFacade","wd","ws","temp","date")

#timePlot function - time series plot of NO2 measurements
timePlot(aq16, pollutant = c("no2_PutneyBackground","no2_PutneyHighStreet","no2_PutneyHighStreetFacade"))

#summaryPlot - rapid summary of time series, distributions and summary stats
summaryPlot(aq16)

#calendarPlot function of NO2 concentratios and then wind speed
calendarPlot(aq16, pollutant = "no2_PutneyBackground", year = 2016)
calendarPlot(aq16, pollutant = "no2_PutneyHighStreet", year = 2016)
calendarPlot(aq16, pollutant = "no2_PutneyHighStreetFacade", year = 2016)
calendarPlot(aq16, pollutant = "ws", year = 2016)

#timeVariation in NO2 concentrations
timeVariation(aq16, pollutant = "no2_PutneyBackground")
timeVariation(aq16, pollutant = "no2_PutneyHighStreet")
timeVariation(aq16, pollutant = "no2_PutneyHighStreetFacade")

#polar plot for site ENV3 for each month of the year
polarPlot(aq16, pollutant = "no2_PutneyHighStreet")

##################################################################
# long term trend analysis
# import 2010-2016 data.frame
aqLONG <- read.csv("Putney_AQ_2010_2016.csv", header=T, na.strings="NA")

# useful data.frame check command
summary(aqLONG)

# define date & time format, add to data.frame, rename headers
datetime <- as.POSIXct(strptime(aqLONG$datetext, format = "%d/%m/%Y %H:%M", "GMT"))
aqLONG <- cbind(aqLONG, datetime)
names(aqLONG)[1:8] <- c("datetext","no2_PutneyBackround","nox_PutneyBackround","no2_PutneyHighStreet","nox_PutneyHiStreet","no2_PutneyHighStreetFacade","nox_PutneyHighStreetFacade","date")

# the smoothTrend function calculates trends in the monthly mean concentrations 
smoothTrend(aqLONG, pollutant = "no2_PutneyHighStreet", ylab = "NO2 (ug/m3)") 

# ascertain trends using the 'TheilSen function'
TheilSen(aqLONG, pollutant = "no2_PutneyHighStreet", ylab = "NO2 (ug/m3)", deseason = TRUE)

#END