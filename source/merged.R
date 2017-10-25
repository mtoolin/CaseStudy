# Merge dfgdp_2012_final and edstats_final
# Input: dfgdp_2012_final.csv and edstats_final.csv
# Output: merged_final.csv

library(tidyr)


# Read in from the Data folder
dfgdp_2012_prepmerge <- read.csv("data/dfgdp_2012_final.csv", stringsAsFactors = FALSE)
edstats_prepmerge <- read.csv("data/edstats_final.csv", stringsAsFactors = FALSE)

# Check if any countries from GDP are not in EDSTATS by CountryCode
no_match <- which(!(dfgdp_2012_prepmerge$CountryCode %in% edstats_prepmerge$CountryCode))           # Holds line number(s) of country code(s) with no match
add <- dfgdp_2012_prepmerge$CountryCode[no_match]                                                   # Extracts value(s) of country code(s) with no match
edstats_prepmerge_dup <- edstats_prepmerge                                                          # duplicate edstats_prepmerge prevents overwriting so no_match assignment on line 13 can be repeated reliably                              
add.nomatch.vectors <- matrix(add, nrow = length(add),ncol = length(edstats_prepmerge_dup))         # Create matrix with with each column being vector to be added to edstats_prepmerge_dup
for (x in 1:length(add)){                                                                           # For every country not matched
  add.nomatch.vectors[x, 2:length(edstats_prepmerge_dup)] <- "NA"                                   # Fill vector with "NA" after country code
  edstats_prepmerge_dup <- rbind(edstats_prepmerge_dup, add.nomatch.vectors[x,])                    # Bind the vector as new row on edstats_prepmerge_dup
}
                                              
# Merge the data sets, only keeping countries with a value for GDP
merged1 <- merge(dfgdp_2012_prepmerge, edstats_prepmerge_dup, by="CountryCode")

merged_final <- merged1

write.csv(merged_final, "data/merged_final.csv", row.names = FALSE)
