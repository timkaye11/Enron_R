library(plyr)
library(kohonen)

avgWordLength <- function(sentence) {
  newSentence <- gsub(' {2,}', ' ', sentence)
  words <- strsplit(newSentence, ' ')[[1]]
  wordSizes <- c()
  for (i in 1:length(words)) {
    wordSizes[i] <- nchar(words[i])
  }
  mean <- mean(wordSizes)
  var <- var(wordSizes)
  return (cbind('Mean'=mean, 'Var'=var))
}

#subset <- data[200:250, c(4,6,8,13)]

data <- read.csv("/Users/timkaye11/Downloads/enron_mail_20110402_csv/lay-k.csv")
dataset <- mutate(data, Message = as.character(Message), Subject = as.character(Subject), Cc = as.character(Cc), Bc = as.character(Bcc))
dataset <- mutate(dataset, MessageLength = nchar(Message))
dataset <- mutate(dataset, SubjectLength = nchar(Subject))
dataset <- mutate(dataset, AvgWordLength = avgWordLength(Message)[1])
dataset <- mutate(dataset, VarWordLength = avgWordLength(Message)[2])
dataset <- mutate(dataset, Date = strptime(as.character(Date), format = "%a, %d %b %Y %X"))

#uniquify function for incoming emails

unique(dataset$Subject)

uniquify <-function(dataset) {
  holder <- c()
  for (i in 1:nrow(dataset)) {
    element <- dataset[i,]
    if (!(element$Subject %in% holder$Subject)) {
      elmt <- c(element$AvgWordLength, element$Subject, element$VarWordLength, element$Date, element$MessageLength)
      rbind(holder, elmt) -> holder
    }
  }
  return (holder)
}

#uniquify fix

holder=NULL
index=NULL
for(i in 1:nrow(dataset)){
  if(!(dataset[i,]$Subject %in% holder)) {
    holder = c(holder,dataset[i,]$Subject)
    index = c(index,i)
  }
}



# the name of the uniquified list is 'r'. 

#Basic Textual Search (to come soon)
#finding the number of words in a message/subject
wordCount <- function(subset) {
  
  numWordsSubject <- c()
  numWordsMessage <- c()
  for (i in 1:nrow(subset)) {
    subject <- subset[i, 3] #extracts the subject from the subset of emails
    sub1 <- gsub('-', ' ', subject) #finds all occurences of '-' and replaces with a spdaace. 
    sub2 <- gsub(' {2,}', ' ', sub1) #finds all occurences of two or more spaces, and reduces to 1. 
    numWordsSubject[i] <- length(strsplit(sub2, ' ')[[1]]) #separates all words with spaces between them. 
    #and finds the number of words in the subject
    
    message <- subset[i, 4]
    mess1 <- gsub('-', ' ', message)
    mess2 <- gsub(' {2,}', ' ', mess1)
    numWordsMessage[i] <- length(strsplit(mess2, ' ')[[1]])
  }
    return (cbind(numWordsSubject, numWordsMessage))
}
x <- wordCount(subset)

#finding the average word length, and variance within sentence




filterEmails <- function(subset) {
  filtered <- subset
  count <- 1
  for (i in 1:nrow(subset)) {
    from <- subset[i,1]
    if (from =="ken.lay@enron.com") {
      filtered[count,] <- subset[i,]
      count <- count+1
    }
  }
    return (filtered)
}

timeSeries <- function(dataset) {
  ordered <- dataset[order(as.Date(dataset$Date, format="%d/%m/%Y")),]
  sent <- NULL
  for (i in 1:nrow(dataset)) {
    if (dataset[i,'From'] == 'rosalee.fleming@enron.com') {
      rbind(sent, dataset[i,]) -> sent
    }
  }
  plot.ts(sent['Date'], sent['AvgWordLength'])
  plot.ts(sent['Date'], sent['VarWordLength'])
}
  
kenLaySOM <- function(dataset) {
  received <- NULL
  for (i in 1:nrow(dataset)) {
    if (!(dataset[i, 'From'] == 'kenneth.lay@enron.com')) {
      rbind(received, dataset[i,]) -> received
    }
  }
  variables <- received[c("AvgWordLength", "VarWordLength", "MessageLength")]
  ken.SOM <- som(data = variables, som.grid(6,6, "hexagonal"))
  plot(ken.SOM, main="Ken Lay SOM")
}
