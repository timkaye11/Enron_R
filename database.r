library(plyr)
options(gsubfn.engine = "R")
library(sqldf)

setwd('/Users/timkaye/Documents/Spring_2014/Math_Research')
data <- read.csv("enron_mail_20110402_csv/allen-p.csv")
dataset <- mutate(data, Message = as.character(Message), Subject = as.character(Subject), Cc = as.character(Cc), FromName = as.character(FromName), Bc = as.character(Bcc))
dataset <- mutate(dataset, MessageLength = nchar(Message), SubjectLength = nchar(Subject))
dataset <- mutate(dataset, Date = as.Date(as.character(Date), format = "%a, %d %b %Y"))

dataset2 <- transform(dataset, Date=as.character(Date))

contain <- sqldf('SELECT FromName, ToName, Subject, Date FROM data WHERE Subject LIKE "%California%" GROUP BY Date')
dat <- sqldf('SELECT DISTINCT FromName, Count(FromName) FROM data GROUP BY "FromName"')

heatGrid <- function() {
  
  months <- seq(as.Date("2000-06-01"), as.Date("2002-07-01"), by="1 month")
  matrix <- NULL
  for (month in months) {
    for (data in datasets) {
      start <- month
      end <- month+30
      num <- sqldf("select * from data where Date > $start and Date < $end")
      length(num)
      entry <- cbind(length, month, directory)
    }
  }
}

mongoimport -h troup.mongohq.com --port 10085 -d Enron -c sample-run -u timkaye -p sagehen47 --type csv --file ~/Users/timkaye/Documents/Spring_2014/Math Research/enron_mail_20110402_csv/allen-p.csv 




