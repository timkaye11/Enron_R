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

---
