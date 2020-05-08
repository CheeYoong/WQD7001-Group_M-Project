library('dplyr')
library('tidyr')
library('stringr')
#library('corrplot')
#library('plotly')
#library('memisc')
#library('MASS')
#library('lattice')
#library('ggplot2')
#library('caret')
#library('shiny')


setwd("C:/Users/royku/Sem I Modules/WQD7001-Principles of DS/Project")

KL<-read.csv("data_KL_House Pricinig.csv",na.strings=c(""," ","NA")) #Missed stringAsFactor

#glimpse(KL)
str(KL)

summary(KL)

#Price Factor/Parameter
#Split Operation on Price
#KL$Price <- str_split_fixed(KL$Price, " ", 2)
#Index splitting possible but need to handle currency splits separately

KL %>% separate(Price, c("RM", "Value"), "RM") -> KL

KL$Value <- gsub(" ", "", KL$Value, fixed = TRUE)
KL$Value <- gsub(",", "", KL$Value, fixed = TRUE)
KL$Value <- as.numeric(KL$Value)
options(scipen = 999) #turning of scientific notation

summary(KL$Value)

#Furnishing Factor/Parameter

KL$Furnishing <- as.factor(KL$Furnishing)
summary(KL$Furnishing) #Should we combine Unknown(608) & NA's(6930)?

#Size Factor/Parameter
#Split Size into its component.

KL %>% separate(Size, c("Size_Cat", "Size"), ":") -> KL
KL %>% separate(Size, c("Size", "Unit"), "s") ->  KL
KL$Size <- gsub(",", "", KL$Size, fixed = TRUE)
KL$Size_Cat <- as.factor(KL$Size_Cat)

#KL<-KL1

KL$Unit <- as.factor(KL$Unit)
KL$Unit <- gsub("q. ft.","sq. ft.",KL$Unit, fixed = TRUE)
KL$Unit <- as.factor(KL$Unit)
KL$Unit <- gsub("q ft","sq. ft.",KL$Unit, fixed = TRUE) #There are two factors of sq. ft. which are not merging
KL$Unit <- as.factor(KL$Unit)
KL$Unit <- gsub("q.ft.","sq. ft.",KL$Unit, fixed = TRUE)
KL$Unit <- as.factor(KL$Unit)
KL$Unit <- gsub("qft","sq. ft.",KL$Unit, fixed = TRUE)
KL$Unit <- as.factor(KL$Unit)

summary(KL$Unit)

#for(i in KL$Unit){
#  if(i == "q. ft."){
#    KL$Unit <- "sq. ft."
#  }
#}


KL$Size <- as.numeric(KL$Size) #Non-Numeric formats will be changed to NA 

summary(KL$Value)


#Removing blank rows

dim(subset(KL, is.na(KL$Furnishing) & is.na(KL$Value) & is.na(KL$Property.Type))) #Need to remove all these values

