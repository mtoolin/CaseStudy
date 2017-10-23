# Cleaned merged file
# Input: merged_final.csv
# Ouput: cleaned_merged_final.csv

merged_final <- read.csv("data/merged_final.csv", stringsAsFactors = FALSE)

cleaned_merged1 <- select(merged_final, "CountryCode", "Country", "Ranking", "Millions.US.Dollars", "Income.Group")

cleaned_merged_final <- arrange(cleaned_merged1, CountryCode)

write.csv(cleaned_merged_final, "data/cleaned_merged_final.csv", row.names = FALSE)
