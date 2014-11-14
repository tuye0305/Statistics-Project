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
#- if datelp6 is 2002, make lpuryear 2002 (same for 1980)
#- convert single digit lpuryear to a concrete year (e.g., 0->2010, 3-> 2003 etc)

#First I replace the NA with 10 in lpuryear in case that it shows errors in the following steps
project$lpuryear[is.na(project$lpuryear)] <- 10

# You might need to wait for approximately 1 min for running the following for loop :P
# [S] Set n equal to the total number of rows in dataset
n <- nrow(project)
for (i in 1:n) {
  
  if(project$datelp6_year[i] == 2002) {
    project$lpuryear[i] = 2002
  }
  if(project$datelp6_year[i] == 1980) {
    project$lpuryear[i] = 1980
  }
   for (m in 3:9){
     if(project$lpuryear[i] == m) {
       project$lpuryear[i] = 2000 + m
     }
   }
   for (m in 1:2){
     if(project$lpuryear[i] == m) {
       project$lpuryear[i] = 2010 + m
     }
   }
  if(project$lpuryear[i] == 0) {
    project$lpuryear[i] = 2010
  }
}

#compare datelp6's year with lpuryear. Choose the latest year to be the updated lpuryear.
toDate <- as.Date("2012-09-01", "%Y-%m-%d")
for (i in 1:n){
  if(project$datelp6_year[i] > project$lpuryear[i]){
    project$lpuryear[i] =  project$datelp6_year[i]
  }
  
  # [S] Calculate recency:  number of months from Sep 1, 2012
  
  project$recencyyear[i] <- year(strptime(toDate, format = "%Y-%m-%d")) - year(strptime(project$datelp6[i], format = "%Y-%m-%d"))
  project$recencymon[i] <- (as.yearmon(strptime(toDate, format = "%Y-%m-%d")) - as.yearmon(strptime(project$datelp6[i], format = "%Y-%m-%d")))*12
  project$recencydays[i] <- as.numeric(toDate-project$datelp6[i])
}

#transform the year data to be numeric
project$lpuryear <- as.numeric(project$lpuryear)
project$datelp6_year <- as.numeric(project$datelp6_year)

##################################################################
