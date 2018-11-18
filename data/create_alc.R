###18.11.2018
## Susanna Jernberg
### This is a logistic regression exercise
### data available at: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/ 

##read data in
data.mat<-read.table("student-mat.csv", sep=";", header=TRUE)
data.por<-read.table("student-por.csv", sep=";", header=TRUE)


#check the dimensions and structure of both datasets
dim(data.mat)
str(data.mat)

dim(data.por)
str(data.por)




















summary(data)

#the data has 183 rows, 60 columns. It is in a format of data frame, with 183 observations and 60 variables 
#(59 integer variables and 1 factor variable)

##Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
#by combining questions in the data


install.packages(dplyr)
library(dplyr)
library(GGally)

# questions related to specific topics
deep_questions<-c("D03","D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <-c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
strategic_questions<-c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")

#selecting questions related to topics and creating new columns by averiging
deep_columns<-select(data, one_of(deep_questions))
data$deep<-rowMeans(deep_columns)

surface_columns<-select(data, one_of(surface_questions))
data$surf<-rowMeans(surface_columns)

strategic_columns<-select(data, one_of(strategic_questions))
data$stra<-rowMeans(strategic_columns)

#choosing the columns to keep
keep_columns<-c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")

#creating new dataset
learning_data<-select(data, one_of(keep_columns))
str(analysis_dataset)

#select rows where Points is greater that zero
learning_data<-subset(analysis_dataset, Points>0)
str(learning_data)

#At the moment, the data includes 166 observations and 7 variables
#writing a table and reading the data in
write.table(learning_data, file="D:/Users/E1002220/Opinnot/Data science/IODS-project/data/learning2014_data.csv", sep="\t")
learning_data<-read.csv(file="D:/Users/E1002220/Opinnot/Data science/IODS-project/data/learning2014_data.csv", sep="\t")
str(learning_data)
