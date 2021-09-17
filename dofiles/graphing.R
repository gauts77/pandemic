## GRAPHING DATASTREAM TIME SERIES OF EACH INDEX.
rm(list = ls())
setwd('C:/Users/gauta/Documents/GitHub/pandemic/Data/stockdata/DataStream/Stock indices raw data')

library(tidyverse)
library(ggplot2)
stock <- read.csv('stock_ts.csv')

indx_list <- c("AEX", "ASX", "ATX") ##using unique values returned an indx_list of NULL. Why?

for(indx in indx_list){
  
  stock_to_plot <- stock %>%
    filter(Index == indx) ##issue with data here - just coming up with one value. Haven't assigned stock returns as the data.
  
  my_plot <- ggplot(data = stock_to_plot, aes(x = "week", y = "stock_ts")) +
    geom_point() +
    labs(title = paste(indx, "Time Series", sep = " ")) ## will be good to add a horizontal line at 12/03/21. Also just make the graphs look better in general.
  
  ggsave(filename = paste(indx, "_time_series.png", sep = ""), plot = my_plot, path = "C:/Users/gauta/Documents/GitHub/pandemic/figures/stock_time_series")
  
}
