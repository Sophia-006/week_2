library(tidyverse)

BOM_data <- read_csv('data/BOM_data.csv')
BOM_stations <- read_csv('data/BOM_stations.csv')
BOM_data
BOM_stations
select(BOM_data, Station_number,Temp_min_max)
Bom_data_temp <- select(BOM_data, Station_number,Temp_min_max, Rainfall, Day) %>% 
  separate(Temp_min_max,into= c('min', 'max'), sep='/') %>% filter(min!= '-', max!= '-',
                                                                   Rainfall> 0)
Bom_data_temp

Bom_data_minmax <-group_by(Bom_data_temp, Station_number)
Bom_data_minmax

