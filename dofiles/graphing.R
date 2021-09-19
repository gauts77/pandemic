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
    filter(Index == indx) 
  
  my_plot <- ggplot(data = stock_to_plot, aes(x = Week, y = Closing.Price)) +
    geom_point(colour = "blue", size = 0.5) +
    geom_line(aes(group = 1), colour = "blue") +
    theme_minimal() +
    geom_vline(xintercept = as.numeric(stock$Week[9]), linetype = 4, colour = "red") +
    geom_vline(xintercept = as.numeric(stock$Week[10]), linetype = 4, colour = "red") +
    labs(title = paste(indx, "Time Series (highlighted area is week of WHO announcement)", sep = " "), x = "Month", y = "Closing Price") +
    geom_rect(xmin = as.numeric(stock$Week[9]), xmax = as.numeric(stock$Week[10]), ymin = 0, ymax = Inf, fill = "red", alpha = 0.01)
  
  ggsave(filename = paste(indx, "_time_series.png", sep = ""), plot = my_plot, path = "C:/Users/gauta/Documents/GitHub/pandemic/figures/stock_time_series")
  
}

##facet graph:
p <- ggplot(data = stock, aes(x = Week, y = Closing.Price)) +
  geom_point(size = 0.001) +
  facet_wrap(~ï..Country, nrow = 5, scale = "free_y") + 
  geom_line(aes(group = 1), colour = "blue") +
  theme_minimal() +
  labs(title = paste("Time Series (highlighted area is week of WHO announcement)"), x = "Month", y = "Closing Price") +
  theme(axis.text.y = element_blank()) +
  geom_vline(xintercept = as.numeric(stock$Week[9]), linetype = 4, colour = "red") +
  geom_vline(xintercept = as.numeric(stock$Week[10]), linetype = 4, colour = "red") +
  geom_rect(xmin = as.numeric(stock$Week[9]), xmax = as.numeric(stock$Week[10]), ymin = 0, ymax = Inf, fill = "red", alpha = 0.01)

ggsave(filename = "grouped_time_series.png", plot = p, path = "C:/Users/gauta/Documents/GitHub/pandemic/figures/stock_time_series")
  
  
##todo:
  ## adjust y-axis
  ## add a single graph with them all using facet wrap.
  