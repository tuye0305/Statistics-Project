#######################################
#                                     #
#       MSiA 401 Group Project        #
#                                     #
#######################################                                   
library(zoo)
library(lubridate)

project <- read.csv("project_data.csv")

#I named the dataset as "project"

#Convert all dates to date format
project$datead6 <- as.Date(project$datead6, "%m/%d/%Y")
project$datelp6 <- as.Date(project$datelp6, "%m/%d/%Y")

#- extract "year" from datelp6, add a new column called datelp6_year
project$datelp6_year <- format(project$datelp6, "%Y")

#lpuryear:

#First I replace the NA with 10 in lpuryear in case that it shows errors in the following steps
project$lpuryear[is.na(project$lpuryear)] <- 10

n <- nrow(project)

# Replace year numbers with actual years
project$lpuryear[project$lpuryear==3]<- 2003
project$lpuryear[project$lpuryear==4]<- 2004
project$lpuryear[project$lpuryear==5]<- 2005
project$lpuryear[project$lpuryear==6]<- 2006
project$lpuryear[project$lpuryear==7]<- 2007
project$lpuryear[project$lpuryear==8]<- 2008
project$lpuryear[project$lpuryear==9]<- 2009
project$lpuryear[project$lpuryear==0]<- 2010
project$lpuryear[project$lpuryear==1]<- 2011
project$lpuryear[project$lpuryear==2]<- 2012


# Compare datelp6's year with lpuryear. Choose the latest year to be the updated lpuryear.
# Also takes care of lpuryear = 1980 or 2002. 
toDate <- as.Date("2012-09-01", "%Y-%m-%d")
for (i in 1:n){
  if(project$datelp6_year[i] > project$lpuryear[i]){
    project$lpuryear[i] =  project$datelp6_year[i]
  }
}

# Adding recency columns (in years, months, and days)
project$recencyyear <- year(strptime(toDate, format = "%Y-%m-%d")) - year(strptime(project$datelp6, format = "%Y-%m-%d"))
project$recencymon <- (as.yearmon(strptime(toDate, format = "%Y-%m-%d")) - as.yearmon(strptime(project$datelp6, format = "%Y-%m-%d")))*12
project$recencydays <- as.numeric(toDate-project$datelp6)
  

#transform the year data to be numeric
project$lpuryear <- as.numeric(project$lpuryear)
project$datelp6_year <- as.numeric(project$datelp6_year)

##################################################################



