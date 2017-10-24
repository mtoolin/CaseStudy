# Group ProjectCase Study for MSDS 6306
# Revised on October 22, 2017
# Author: Michael Toolin

#
# Download the required tables from URL's given in the problem statement
# and save them in the data directory
#

URL1 <-"https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv"
URL2 <-"https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv"
destfile1 <-"data/gdp.csv"
destfile2 <-"data/edstats_country.csv"

dir.create("data")
download.file(URL1,destfile1)
download.file(URL2,destfile2)