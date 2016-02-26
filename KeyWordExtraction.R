# KeyWord Extraction Code
# For: Wells Fargo Knowledge Search Tool
# By: Dipanjan Datta
# Started: 15th Feb 2016
# Current Input: file.txt file

# Clear Environment
rm(list=ls())

# This part is for first time usage
# Needed= c("tm","stringr")   

# install.packages(Needed, dependencies=TRUE)

# Set working directory
setwd("C:/Users/dipanjand/Desktop/Projects/26.02.2016/WellsFargo")

# Load library tm for text mining
library(tm)

# Input data
text= readLines("file.txt")

# Do not worry about the Warning message incomplete final line
docs = Corpus(VectorSource(text))

# Remove Punctuations
docs = tm_map(docs, removePunctuation)   

# Removing numbers:
docs = tm_map(docs, removeNumbers)  

# Converting to lowercase:
docs = tm_map(docs, content_transformer(tolower)) 

# Removing "stopwords" (common words)
docs = tm_map(docs, removeWords,stopwords("SMART"))

# Create the term document matrix
myTDM= TermDocumentMatrix(docs,control = list(minWordLength = 1))

# Organize terms by their frequency:
m = as.matrix(myTDM)

# Get all words
allwords = data.frame(rownames(m),rowSums(m))

# Change the name of the columns
names(allwords) = c("KeyWords","WordCount")

# Remove non-alphanumeric characters and whitespaces

StringClean= function(x)gsub("^\\s+|\\s+$|[^[:alnum:]]","",x)

allwords$KeyWords = StringClean(allwords$KeyWords)

allwords =aggregate(allwords$WordCount, by=list(allwords$KeyWords),
                    FUN=sum,na.rm=TRUE)

names(allwords) = c("KeyWords","WordCount")

allwords = allwords[order(allwords$KeyWords),]


for(i in 2:nrow(allwords))
  {

  allwords$KeyWords[i]= ifelse(
    allwords$KeyWords[i-1] == gsub('.{1}$','',allwords$KeyWords[i]),
                gsub('.{1}$','',allwords$KeyWords[i]),
                      allwords$KeyWords[i]
                )
  }


allwords =aggregate(allwords$WordCount, by=list(allwords$KeyWords),
                    FUN=sum,na.rm=TRUE)

names(allwords) = c("KeyWords","WordCount")

allwords = allwords[order(-allwords$WordCount),]

TopWords= head(allwords,10)

View(TopWords)


