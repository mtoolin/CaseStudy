# Merge dfgdp_2012_final and edstats_final
# Input: dfgdp_2012_final.csv and edstats_final.csv
# Output: merged_final.csv

library(dplyr)
library(tidyr)
library(countrycode)

# Read in from the Data folder
dfgdp_2012_final <- read.csv("data/dfgdp_2012_final.csv", stringsAsFactors = FALSE)
edstats_final <- read.csv("data/edstats_final.csv", stringsAsFactors = FALSE)

# Check if any countries from GDP are not in EDSTATS by CountryCode
no_match <- which(!(dfgdp_2012_final$CountryCode %in% edstats_final$CountryCode))           # Holds line number of country code that doesn't match
add <- dfgdp_2012_final$CountryCode[no_match]                                               # Extracts value of country code that doesn't match
add_vector <- c(add,rep(c("NA"),30))                                                        # Create new vector in preparation to add to edstats
edstats_final <- rbind(edstats_final, add_vector)                                           # Bind the new vector to edstats
edstats_final$Long.Name[155] <- countrycode("SSD", origin="iso3c", destination = "country.name")  # Supply the country name for one that didn't match

# Merge the data sets, only keeping countries with a value for GDP
merged1 <- merge(dfgdp_2012_final, edstats_final, by="CountryCode")

merged_final <- merged1

write.csv(merged_final, "data/merged_final.csv", row.names = FALSE)
