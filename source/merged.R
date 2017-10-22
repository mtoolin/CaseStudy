#Merge dfgdp_2012_final and edstats_final

library(dyplr)
library(tidyr)
library(countrycode)

###################################################################################################
# Read in and clean GDP data

gdp_2012 <- read.csv("6306 case study getdata_data_GDP.csv", skip=4, na.strings = c("","NA"), stringsAsFactors = FALSE)

dfgdp_2012 <- tbl_df(gdp_2012)                # create data frame and look at the first 10 lines

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
###############################################################################################################

###############################################################################################################
# Read in and clean EDSTATS

# working directory needs to be directory containing .csv to read in the data
edstats <- read.csv("6306 case study getdata_data_EDSTATS_Country.csv", na.strings = c("","NA"), stringsAsFactors = FALSE)
edstats <- tbl_df(edstats)

# Noticed invalid country codes so using the countrycode package to find lines with invalid countries
show_invalid_country <- countrycode(edstats$Long.Name, origin = "country.name", destination = "iso3c")

show_invalid_country <- which(is.na(show_invalid_country))    #holds line numbers of invalid countries

# Create a dataframe with invalid countries and line number
dfshow_invalid_country <- data.frame(LineNo = show_invalid_country, edstats$Long.Name[show_invalid_country])

# Manually inspected invalid countries and removed valid countries from vector
dfshow_invalid_country <- dfshow_invalid_country[-c(1,8,10,11,13,19,26,31),]   

edstats_final <- edstats[-dfshow_invalid_country$LineNo,]                 # Removing invalid countries
###############################################################################################################

# Check if any countries from GDP are not in EDSTATS by CountryCode
no_match <- which(!(dfgdp_2012_final$CountryCode %in% edstats_final$CountryCode))           # Holds line number of country code that doesn't match
add <- dfgdp_2012_final$CountryCode[no_match]                                               # Extracts value of country code that doesn't match
add_vector <- c(add,rep(c("NA"),30))                                                        # Create new vector in preparation to add to edstats
edstats_final <- rbind(edstats_final, add_vector)                                           # Bind the new vector to edstats
edstats_final$Long.Name[155] <- countrycode("SSD", origin="iso3c", destination = "country.name")  # Supply the country name for one that didn't match

# Merge the data sets, only keeping countries with a value for GDP
merged1 <- merge(dfgdp_2012_final, edstats_final, by="CountryCode")

merged2 <- select(merged1, -Country)    # Eliminate Country column because it is duplicated by table.Name

merged_final <- merged2
