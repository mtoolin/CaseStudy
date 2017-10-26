# Raw Analysis for Edstats Aata
# Input: edstats_country.csv and dfgdp_2012_final.csv
# Output: edstats_final.csv

#library(dplyr)

# working directory needs to be directory containing .csv to read in the data
edstats <- read.csv("data/edstats_country.csv", na.strings = c("","NA"), stringsAsFactors = FALSE)
dfgdp_edstats <- read.csv("data/dfgdp_2012_final.csv", stringsAsFactors = FALSE)

edstats <- tbl_df(edstats)
dfgdp_edstats <- tbl_df(dfgdp_edstats)    # Needed for country code comparison vector to get rid of countries no

matched.result <- match(edstats$CountryCode, dfgdp_edstats$CountryCode)     # Creates vector holding line number in edstats of match

edstats_final <- data.frame(stringsAsFactors = FALSE)     #initialize empty data frame
edstats_final <- tbl_df(edstats_final)
for (x in 1:length(matched.result)){
  ifelse (is.na(matched.result[x]),"NA" , edstats_final <-rbind(edstats_final, edstats[x,]))
}

# Working directory is Data folder
write.csv(edstats_final, "data/edstats_final.csv", row.names = FALSE)


