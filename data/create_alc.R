###18.11.2018
## Susanna Jernberg
### This is a logistic regression exercise
### data available at: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/ 

## set 
##read data in IODS course as working directory
data_math<-read.table("student-mat.csv", sep=";", header=TRUE)
data_por<-read.table("student-por.csv", sep=";", header=TRUE)


#check the dimensions and structure of both datasets
dim(data_math)
str(data_math)

dim(data_por)
str(data_por)


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

