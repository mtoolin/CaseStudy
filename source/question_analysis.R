# Cleaned merged file
# Input: cleaned_merged_final.csv
# Ouput: 

Cleaned.Merged.Analysis <- read.csv("data/cleaned_merged_final.csv", stringsAsFactors = FALSE)

#Question 3
# average GDP rankings for the "High income: OECD" and "High income: nonOECD" 
Cleaned.Merged.Analysis %>% filter(Income.Group %in% c("High income: OECD" , "High income: nonOECD")) %>% 
  group_by(Income.Group) %>% 
  summarise( average = mean(Ranking))


#Question 5

quantile(Cleaned.Merged.Analysis$Ranking, seq(0, 1, length=6))

Income.Group_table <- Cleaned.Merged.Analysis
Income.Group_table <- Income.Group_table[c("Income.Group", "CountryCode", "Country", "Ranking", "Millions.US.Dollars")]


for (x in 1:length(Income.Group_table$Income.Group)){
ifelse(is.na(Income.Group_table$Income.Group[x]),Income.Group_table<-Income.Group_table[-x,],"NA")
ifelse(Income.Group_table$Income.Group[x]=="Lower middle income", Income.Group_table$newcolumn[x]<-4,"NA")
ifelse(Income.Group_table$Income.Group[x]=="Upper middle income", Income.Group_table$newcolumn[x]<-3,"NA")
ifelse(Income.Group_table$Income.Group[x]=="Low income", Income.Group_table$newcolumn[x]<-5,"NA")
ifelse(Income.Group_table$Income.Group[x]=="High income: OECD", Income.Group_table$newcolumn[x]<-1,"NA")
ifelse(Income.Group_table$Income.Group[x]=="High income: nonOECD", Income.Group_table$newcolumn[x]<-2,"NA")
}

sorted.Income.Group_table <- arrange(Income.Group_table, newcolumn, desc(Millions.US.Dollars))
sorted.Income.Group_table <- sorted.Income.Group_table[-6]

filter(sort.Income.Group_table,sort.Income.Group_table$Income.Group == "Lower middle income", Ranking < 39)
