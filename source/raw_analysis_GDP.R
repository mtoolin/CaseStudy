# Raw Analysis for GDP Data
# Input: GDP Data from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Output: dfgdp_2012_final.csv

library(dplyr)
library(tidyr)

# Read in and analyze the header to check how many rows to skip for a potential re-read
# Working directory needs to be directory containing .csv to read in the data
gdp_2012 <- read.csv("6306 case study getdata_data_GDP.csv")
tbl_df(gdp_2012)                              # create data frame and look at first 10 lines

gdp_2012 <- read.csv("6306 case study getdata_data_GDP.csv", skip=4, stringsAsFactors = FALSE, na.strings = c("", "NA"))

dfgdp_2012 <- tbl_df(gdp_2012)                # create data frame and look at the first 10 lines
sapply(dfgdp_2012, function(x) all(is.na(x))) # check for columns with no data

# X.2, X.6, X.7, X.8, and X.9 are empty and X.5 looks suspicious
dfgdp_2012$X.5                                # displaying data for X.5

# X.5 data doesn't make sense, analysis of raw data shows it is not data but notations
# select and rename columns 1,2,4, and 5
dfgdp_2012_clean1 <- select(dfgdp_2012, "CountryCode" = X, Ranking = X.1, Country = X.3, "Millions of US Dollars" = X.4)

# filter out any line without a country code and ranking
dfgdp_2012_clean2 <- filter(dfgdp_2012_clean1, !is.na(Ranking) & !is.na(CountryCode))
       
# get rid of the commas in the "Millions of US Dollars" column
dfgdp_2012_clean2$"Millions of US Dollars" <- gsub(",", "", dfgdp_2012_clean2$"Millions of US Dollars")
                              
# convert Ranking and Millions of US Dollars columns to numeric
dfgdp_2012_clean2$Ranking <- as.numeric(dfgdp_2012_clean2$Ranking)
dfgdp_2012_clean2$"Millions of US Dollars" <- as.numeric(dfgdp_2012_clean2$"Millions of US Dollars")

dfgdp_2012_final <- dfgdp_2012_clean2
       
# Working directory is Data folder
write.csv(dfgdp_2012_final, "dfgdp_2012_final.csv", row.names = FALSE)


