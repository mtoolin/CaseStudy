# Cleaned merged file
# Input: merged_final.csv
# Ouput: cleaned_merged_final.csv

merged_final <- read.csv("data/merged_final.csv", stringsAsFactors = FALSE)

cleaned_merged_final <- select(merged_final, "CountryCode", "Country", "Ranking", "Millions of US Dollars" = "Millions.of.US.Dollars", "Income Group" = "Income.Group")

write.csv(cleaned_merged_final, "data/cleaned_merged_final.csv", row.names = FALSE)
