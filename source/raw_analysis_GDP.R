# Raw Analysis for GDP Data
# Jaime Villanueva
# 10/21/2017

# Read in and analyze the header to check how many rows to skip for a potential re-read
# Working directory needs to be directory containing .csv to read in the data
gdp_2012 <- read.csv("6306 case study getdata_data_GDP.csv")
tbl_df(gdp_2012)                              # create data frame and look at first 10 lines

gdp_2012 <- read.csv("6306 case study getdata_data_GDP.csv", skip=4, stringsAsFactors = FALSE)

dfgdp_2012 <- tbl_df(gdp_2012)                # create data frame and look at the first 10 lines
sapply(dfgdp_2012, function(x) all(is.na(x))) # check for columns with no data

# X.2, X.6, X.7, X.8, and X.9 are empty and X.5 looks suspicious
dfgdp_2012$X.5                                # displaying data for X.5

# X.5 data doesn't make sense, analysis of raw data shows it is not data but notations
# select and rename columns 1,2,4, and 5
dfgdp_2012_clean1 <- select(dfgdp_2012, "Country Short Code" = X, Ranking = X.1, Country = X.3, "Millions of US Dollars" = X.4)

                              
dfgdp_2012_clean1$Ranking <- as.numeric(dfgdp_2012_clean1$Ranking)
#dfgdp_2012_clean1$"Millions of US Dollars" <- as.numeric(dfgdp_2012_clean1$"Millions of US Dollars")
dfgdp_2012_final <- filter(dfgdp_2012_clean1, !is.na(Ranking))
dfgdp_2012_final


