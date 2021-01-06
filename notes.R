# turn a section of text into a comment
# on Mac: Shift + Command + C
# [I think on on Windows it's Control + Shift + C]

# count of non-NAs in dataframe "cog"
colSums(!is.na(cog))

# write first 50 rows of dataset to csv file 
# w2ktn <- w2[c(1:50),]
View(w2ktn)
write.csv(w2ktn, "w2ktn.csv", row.names=TRUE)

# get column index from dataframe
which(colnames(w2ktn)=="TDIABET")

# drop column from dataframe
w2ktn$diab <- NULL

# rename columns
View(ghq_elsa)
ghq_elsa <- setNames(ghq_elsa, c("ghqconc", "ghqsleep", "ghquse", "ghqdecis", "ghqstrai", "ghqover",
                                 "ghqenjoy", "ghqface", "ghqunhap", "ghqconfi", "ghqworth", "ghqha"))

# export to .txt file
write.table(ghq_elsa, "c:/[path]/data.txt", sep="\t") 

# find and replace a variable name everywhere in a document (courtesy of https://github.com/mckillshark/!)
# on Windows: Control + Alt + Shift + M
# this message brought to you by: good things come to those who Google with perseverance




#### notes on dplyr from a Roger Peng tutorial ####
# https://www.youtube.com/watch?v=aywFompr1F4

select(chicago, city:dptp)  # selects columns city through dptp
select(chicago, -(city:dptp))  # selects all columns except city through dptp

chic.f <- filter(chicago, pm25tmean2 >30)  # only rows where pm >30
chic.f <- filter(chicago, pm25tmean2 >30 & tmpd >80)

arrange(chicago, date)  # arrange rows in ascending order of "date"
arrange(chicago, desc(date))  # in descending order

rename(chicago, newname1 = oldname1, newname2 = oldname2)

mutate(chicago, newvar = oldvar-mean(oldvar, na.rm=T))

head(select(chicago, vars, you, want, to, see))  # first 5 observations
tail(select(chicago, vars, you, want, to, see))  # last 5

hotcold <- group_by(chicago, tempcat)  # splits df into tempcat values
summarise(hotcold, pm25=mean(pm25, na.rm=T))  # reports mean by tempcat values
#     tempcat     pm25
#     cold        15.97
#     hot         26.48
#     NA          47.73

years <- group_by(chicago, year)
summarise(years, pm25 = mean(pm25))

chicago %>% 
  mutate(month) %>% 
  group_by(month) %>% 
  summarise(pm25=mean(pm25))  # create summary of means of pm25 in each month




#### own notes on dplyr ####

# drop column from dataframe
ORs <- ORs %>%
  mutate(
    X = NULL,
    X.1 = NULL,
    X.2 = NULL
    )
