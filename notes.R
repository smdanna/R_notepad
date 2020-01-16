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
