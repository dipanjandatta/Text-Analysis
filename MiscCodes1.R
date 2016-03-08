rm(list=ls())

setwd("C:/Users/dipanjand/Desktop/Projects/08.03.2016/Training")

text= data.frame(readLines("mbox-short.txt"))

text = data.frame(text[which(grepl("From:",text$readLines..mbox.short.txt..,perl = T)),])

text$words = as.character(text$text.which.grepl..From....text.readLines..mbox.short.txt....perl...T....)

text$words = substr(text$words,7,nchar(text$words))

most_common_id = sort(table(text[,2]),decreasing=TRUE)[1:3]

text$dom = sapply(strsplit(text$words,"@"),"[",2)

most_common_domain = sort(table(text[,3]),decreasing=TRUE)[1:3]
  
most_common_id

most_common_domain
