# Cleaned merged file
# Input: cleaned_merged_final.csv
# Ouput: 

cleaned_merged_final <- read.csv("data/merged_final.csv", stringsAsFactors = FALSE)

# average GDP rankings for the "High income: OECD" and "High income: nonOECD" 
cleaned_merged_final %>% filter(Income.Group %in% c("High income: OECD" , "High income: nonOECD")) %>% group_by(Income.Group) %>% summarise( average = mean(Ranking))
