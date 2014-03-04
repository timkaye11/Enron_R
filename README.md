Enron_R
=======

Analyzing the Enron email-data set. Part of math research circle at Pomona College. 

To be updated over the course of the year. 


###Database.r 

Uses sqldf to filter out the dataframe/csv file. Includes basic commands to filter based on date and keyword. 

***

###Heatmap.r

A heatmap based on the Heapmap Visualization on [flowingdata](www.flowingdata.com). Selects mailboxes from the Enron Email Corpus and creates a heatmap based on specified dates. Relies on sqldf to filter the dates and the `FromName`.

The line `source(calendarCustom.R)` refers to the [flowingdata](www.flowingdata.com) code, and is also in this repo. 

The figure below is an example of a heatmap, based on a mailbox chosen at random. In this case, the sender is Delainy, and the time frame is on the figure. The heatmap represents the number of emails sent per day by Delainy, and the darker spots represent a larger amount of emails sent in that day. Each column represents a week, and each chunck is equal to a month. 

![alt name](/http://tinypic.com/r/ay7jgo/8 "Heatmap example")

---
