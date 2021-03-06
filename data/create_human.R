###25.11.2018
## Susanna Jernberg
### This is data wrangling for next weeks dimensionality reduction techniques


### read two datasets "Human development" and "Gender inequality" in
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#check the dimensions, structure and summaries of the variables of the both datasets
dim(hd)
str(hd)
summary(hd)

dim(gii)
str(gii)
summary(gii)

### change the column names to shorter ones
colnames(hd)<-c("rank", "country", "HDI", "expected_age", "years_edu", "mean_years_edu","GNI","GNI_minus_rank")
summary(hd)

colnames(gii)<-c("ranks","country","GII","mortality","birth_rate","parlament_representation","second_edu_f","second_edu_m","work_rate_f","work_rate_m")
summary(gii)

library(dplyr)

# Combine the two datasets by using common columns as identifiers
#first define which columns will be used as identifiers
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus",
             "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")
join_by

# then join the columns based on those identifiers and keep only the students in the both datasets
math_por<-inner_join(data_math, data_por, by=join_by, suffix= c(".data_math", ".data_por"))

alc<-select(math_por, one_of(join_by))

## add the missing columns (ones not used in joining the dataset) to the data frame

notjoined_columns<-colnames(data_math)[!colnames(data_math) %in% join_by]

notjoined_columns

for(column_name in notjoined_columns){
  two_columns<-select(math_por, starts_with(column_name))
  first_column<-select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)){
    alc[column_name]<-round(rowMeans(two_columns))
  } else {
    alc[column_name]<-two_columns[,1]
  }
}


# check structure and dimensions of the new dataset
dim(alc)
str(alc)

library(ggplot2)

# now create a new column alc_use to the joined data
alc<- mutate(alc, alc_use =(Dalc + Walc)/2)

library(tidyr)

# create column high_use which is TRUE for studens for which "alc_use" is greater than 2

alc<-mutate(alc, high_use = alc_use>2)

glimpse(alc)

write.table(alc, "alc_data.csv", sep="\t")

