# Cleaned merged file
# Input: cleaned_merged_final.csv
# Ouput: 

Cleaned.Merged.Analysis <- read.csv("data/cleaned_merged_final.csv", stringsAsFactors = FALSE)

#Question 1
#The first question presented was how many ID's in the two data sets matched
dfgdp_2012_final <- read.csv('../data/dfgdp_2012_final.csv', stringsAsFactors = FALSE)
edstats_final <- read.csv('../data/edstats_final.csv', stringsAsFactors = FALSE)
NumMatches <- inner_join(dfgdp_2012_final,edstats_final)%>% summarise(cnt=n())%>% as.numeric()
cat("There were",NumMatches,"found to be the same in the data sets \n")

#Question 2
#The second question is find out the 13th Country when order by GDP in ascending order
cleaned_merged1 <- read.csv('../data/cleaned_merged_final.csv')
arrangByUSD <- arrange(cleaned_merged1, Millions.US.Dollars)
cat("The 13th country in the ascending GDP rankings is",arrangByUSD$Country[13]%>%as.character(),"\n")

#Question 3
# average GDP rankings for the "High income: OECD" and "High income: nonOECD" 
cleaned_merged1 %>% filter(Income.Group %in% c("High income: OECD" , "High income: nonOECD")) %>% group_by(Income.Group) %>% summarise( average = mean(Ranking)) %>% mutate_if(is.factor, as.character) %>% as.data.frame(as.matrix(),stringsAsFactors=F)

#Question 4
#GGPlot for **GDP of all countries** by Income Group:
colgrp <- cleaned_merged1$Income.Group
ggplot(cleaned_merged1, aes(x=CountryCode, y=log(Millions.US.Dollars), group=colgrp,shape=colgrp)) + geom_point(aes(colour=colgrp)) + scale_shape_manual(values=c(19,20,21,22,23))+scale_colour_manual(values=c("blue", "red","gray","black","purple"))

ggplot(cleaned_merged1, aes(x=CountryCode, y=log(Millions.US.Dollars), group=colgrp,shape=colgrp)) + geom_bar(stat="identity",aes(colour=colgrp)) + scale_shape_manual(values=c(19,20,21,22,23))+ scale_colour_manual(values=c("blue", "red","gray","black","purple"))

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
