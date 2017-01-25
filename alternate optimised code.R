library(readr)
library(dplyr)
library(tidyr)
library(magrittr)
tb<-tbl_df(read.csv("titanic_original_1.csv",na.strings=c("","na")))
#tb<-tbl_df(read.csv("titanic_original.csv"))
# finding missing values in "embarked" column and replace with S
tb$embarked<-sub("^$", "S", tb$embarked)
tb 
# Missing values in age column replace with mean or median
M<-mean(tb$age,na.rm = TRUE)
median(tb$age,na.rm=TRUE)
tb$age<-ifelse(is.na(tb$age),M,tb$age)
#tb$age[which(is.na(tb$age))]<-M # alternare way
#mean and median are close to each other...no outliers in data...so using mean.
tb
# Life boat column replace empty slots with a dummy value e.g. the string 'None' or 'NA' 
#tb$boat<- sub(na.strings=c("", "NA"),tb$boat)#alternate way
tb$boat<-ifelse(is.na(tb$boat),"NA",tb$boat)
#Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
tb <- mutate(tb,has_cabin_number=ifelse(is.na(tb$cabin), 0,1)) 
View(tb)
install.packages("rio")
library("rio")
export(tb,"titanic_clean_optimised.csv")

