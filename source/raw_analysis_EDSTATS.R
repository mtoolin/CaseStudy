# Raw Analysis for Edstats Aata
# Input: edstats_country.csv
# Output: edstats_final.csv

library(dplyr)
library(tidyr)
library(countrycode)

# working directory needs to be directory containing .csv to read in the data
edstats <- read.csv("data/edstats_country.csv", na.strings = c("","NA"), stringsAsFactors = FALSE)
edstats <- tbl_df(edstats)

edstats                                     # Checking nibble for dimensions and structure
names(edstats)
sapply(edstats, function(x) all(is.na(x)))  # check for columns with no data
View(edstats)                               # Because size from inspection is manageable

# Noticed invalid country codes so using the countrycode package to find lines with invalid countries
show_invalid_country <- countrycode(edstats$Long.Name, origin = "country.name", destination = "iso3c")

show_invalid_country <- which(is.na(show_invalid_country))    #holds line numbers of invalid countries

# It looks like lines without an income group are not valid countries, 
# but each line tagged invalid was manually inspected before deleting row 
# to be sure it wasn't just missing data. Some countries that countrycode() listed as invalid were valid.

# Create a dataframe with invalid countries and line number
dfshow_invalid_country <- data.frame(LineNo = show_invalid_country, edstats$Long.Name[show_invalid_country])
View(dfshow_invalid_country)

# Manually inspected invalid countries and removed valid countries from vector
dfshow_invalid_country <- dfshow_invalid_country[-c(1,8,10,11,13,19,26,31),]   

edstats_final <- edstats[-dfshow_invalid_country$LineNo,]                             # Removing invalid countries

which(is.na(edstats_final$Income.Group))                                              # Verify no NA in income.group           

View(edstats_final)

# Working directory is Data folder
write.csv(edstats_final, "data/edstats_final.csv", row.names = FALSE)


