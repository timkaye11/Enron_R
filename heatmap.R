library(plyr)
options(gsubfn.engine = "R")
library(sqldf)
source("calendarCustom.R")

setwd('/Users/timkaye/Documents/Spring_2014/Math_Research')
filesnames <- list.files(path = "enron_mail_20110402_csv")
files <- paste("enron_mail_20110402_csv/", filesnames, sep="")
#numMailbox <- 2 #set to five mailboxes initially. Took around 2 minutes => Used to combine datasets
#subset <- do.call("rbind", lapply(sample(files, numMailbox), read.csv, header = TRUE))


numHeatMaps <- 1
colors <- c("red", "bluegray", "blue", "green")
names <- sample(files, numHeatMaps)
for (i in 1:numHeatMaps) {
  name <- names[i]
  data <- read.csv(name)
  sender <- unlist(strsplit(name, '/'))
  sender <- unlist(strsplit(sender[2], '[.]'))
  sender <- unlist(strsplit(sender[1], '-'))
  sender <- paste('%',toupper(substring(sender[1], 1,1)), substring(sender[1], 2), '%', sep="", collapse="")
  
  #data <- read.csv("enron_mail_20110402_csv/allen-p.csv") #individual case 
  dataset <- mutate(data, Message = as.character(Message), Subject = as.character(Subject), Cc = as.character(Cc), FromName = as.character(FromName), Bc = as.character(Bcc))
  dataset <- mutate(dataset, MessageLength = nchar(Message), SubjectLength = nchar(Subject))
  dataset <- mutate(dataset, Date = as.Date(as.character(Date), format = "%a, %d %b %Y"))
  dataset <- transform(dataset, Date=as.character(Date))
  
  d <- fn$sqldf("SELECT * FROM dataset WHERE Date > '2000-01-01' AND Date < '2001-01-01' AND FromName LIKE '$sender' ORDER BY Date")
  
  if(length(d) == 0) {
    break
  }
  res <- fn$sqldf("SELECT Date,Count(*) FROM d GROUP BY Date")
  colnames(res) <- c("Date", "Count")
  color <- sample(colors, 1)
  calendarFlow(res$Date, res$Count, palette="red")
  title(main=sender)
  dayLabels <- c('S', 'M', 'T', 'W', 'R', 'F', 'S')
  for (i in 1:7) {
    text(0, i-1/2, dayLabels[i], cex=0.5)
  }
  
  startDate <- strptime(res$Date[1], format = "%Y-%m-%d")
  endDate <- strptime(res$Date[length(res$Date)], format="%Y-%m-%d")
  text(0, 8, paste("From", startDate, "to", endDate), pos=4, cex=0.7)
}

