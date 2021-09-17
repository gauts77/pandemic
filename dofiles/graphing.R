## GRAPHING DATASTREAM TIME SERIES OF EACH INDEX.
rm(list = ls())
setwd('C:/Users/gauta/Documents/GitHub/pandemic/Data/stockdata/DataStream/data')

library(tidyverse)
library(pandas)
library(lubridate)
library(ggplot2)
stock <- read.csv('stock_ts.csv')

stock$Week <- as.Date(stock$Week, format = "%d/%m/%y")

indx_list <- unique(stock$Index)

for(indx in indx_list){
  
  stock_to_plot <- stock %>%
    filter(Index == indx) ##issue with data here - just coming up with one value. Haven't assigned stock returns as the data.
  
  my_plot <- ggplot(data = stock_to_plot, aes(x = Week, y = Closing.Price)) +
    geom_point() +
    geom_line(aes(group = 1)) +
    geom_vline(xintercept = as.numeric(stock$Week[9]), linetype = 4, colour = "red")+
    labs(title = paste(indx, "Time Series", sep = " "), x = "Month", y = "Closing Price") ## will be good to add a horizontal line at 12/03/21. Also just make the graphs look better in general.
  
  ggsave(filename = paste(indx, "_time_series.png", sep = ""), plot = my_plot, path = "C:/Users/gauta/Documents/GitHub/pandemic/figures/stock_time_series")
  
}
##todo:
  ## adjust y-axis
  ## add a single graph with them all using facet wrap.
  