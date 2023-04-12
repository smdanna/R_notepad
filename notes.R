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

# order columns alphabetically
data23b <- data23b[,order(colnames(data23b))]



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



#### Rmarkdown, text in colour ####
<span style="color: red;">Should I restrict population to people with a cervix?</span>


#### Moffitt tutorial on data manipulation

library(tidyverse)

#### Joining ----
clinical <- read_csv("data.txt")


clinical <- read.csv("~/[path]/clinical.txt")

gene_exp <- read.csv("~/[path]/gene_exp.txt")

clinical <- as_tibble(clinical)
gene_exp <- as_tibble(gene_exp)

clinical_kirc <- clinical %>%
  filter(acronym == "KIRC")

View(clinical_kirc)

# matches gene_exp columns and data to all rows and columns from clinical_kirc
left_data <- clinical_kirc %>%
  left_join(gene_exp)

# matches all gene-exp data to clinical_kirc columns and rows
# to clinical_kirc, matches all of gene-exp, and matches gene_exp columns and  from clinical_kirc columns 
right_data <- clinical_kirc %>%
  right_join(gene_exp)

View(right_data)

inner_data <- clinical_kirc %>%
  inner_join(gene_exp %>%
               select(bcr_patient_barcode, AAMP_exp))

inner_data <- clinical_kirc %>%
  inner_join(gene_exp %>%
               select(bcr_patient_barcode, AAMP_exp)) %>%
  select(bcr_patient_barcode, AAMP_exp, height)

colnames(gene_exp)

full_data <- clinical_kirc %>%
  full_join(gene_exp)

# returns only cols from clinic_kirc and only rows that are in gene_exp but no gene_exp data
semi_data <- clinical_kirc %>% # within your clinical dataset, only the IDs in this other data (gene_exp)
  semi_join(gene_exp)

# returns clincial_kirc columns with the patient rows that are not in gene-exp (O in this case)
anti_data <- clinical_kirc %>%
  anti_join(gene_exp)

#### Transposing ----

pivot_longer(tibble, cols = "vars")

pivot_wider()

gene_long <- gene_exp %>%
  pivot_longer(cols = contains("_exp"), names_to = "gene", values_to = "expression")

# you can specify multiple id_cols to match
gene_wide <- gene_long %>%
  pivot_wider(id_cols = "bcr_patient_barcode", names_from = gene, values_from = expression)

twogenes_wide <- gene_long %>%
  filter(gene %in% c("DNAH12_exp", "BUB1_exp")) %>%
  pivot_wider(id_cols = "bcr_patient_barcode", names_from = gene, values_from = expression)

#   filter(gene %in% c("DNAH12_exp", "BUB1_exp")) %>%  --- this is how you do OR function for strings

#### Missing values ----

filter(data, is.na(variable))
filter(full_data, is.na(acronym))

summary(as.factor(full_data$acronym))

# drop_na(variable2)  -- removes rows with NAs for that column
# fill(variable2) - fills in missing values with the previous value (up or down)
# replace_na(list(variable2 = "replacement value")) - replaces NAs with a specified value

table(clinical$race)

clinical %>%
  drop_na(race)

clinical %>%
  drop_na(race) %>%
  fill(radiation_therapy) # fill radiation NAs with previous value -- not sure why would use

clinical %>%
  replace_na(list(race = "unknown",
                  tobacco_smoking_history = "most likely no"))

#### Basics of working with strings ----

# separate(), extract(), and unite()

# separate(tibble_name, var1, into = c("new_var1", "new_var2"), sep = "-")
# extract(tibble_name, var1, regex="[[:alnum:]]+)")
#    extract() uses regex which is outside the scope of this course
# unite(tibble_name, "combined_var_name", var1, var2, sep = ":")

clinical %>%
  unite("race_ethnicity", race, ethnicity, sep = ":") %>%
  select(bcr_patient_barcode,race_ethnicity)

clinical %>%
  unite("race_ethnicity", race, ethnicity, sep = ":") %>%
  separate(race_ethnicity, into = c("race", "ethnicity"), sep = ":")

#### how to connect RStudio project to GitHub repository ####
# https://www.youtube.com/watch?v=bUoN85QvC10

#### use gsub to edit column names ####
# Clear workspace
rm(list=ls())

library(readxl)

# Import data
df <- read_excel("Downloads/df.xlsx")
View(df) 

# Pop out column names of the dataframe to a vector
df.cols <- colnames(df)
df.cols

# Substitute pattern with nothing, save in df.cols
# ^ = beginning of string
# . = any character
# * = as many times as it appears, including zero
# \\( = open parenthesis
df.cols <- gsub('^.*\\(', '', df.cols)
df.cols

# Substitute pattern with nothing, save in df.cols
# \\) = close parenthesis
df.cols <- gsub('\\)', '', df.cols)
df.cols

# Replace column names of dataframe with freshly edited vector
colnames(df) <- df.cols

#Check your work
View(df)

# Info on gsub; it's from base R!
?gsub

# References
# gsub explanation
# https://stackoverflow.com/questions/9704213/remove-part-of-a-string
# Stringr cheatsheets
# https://github.com/rstudio/cheatsheets/blob/main/strings.pdf

# how to specify column types when reading in data from Excel
# https://readxl.tidyverse.org/articles/cell-and-column-types.html
read_excel("yo.xlsx", col_types = c("date", "skip", "guess", "numeric"))

# date formats
# https://www.statmethods.net/input/dates.html
