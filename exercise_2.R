library(tidyverse)

BOM_data <- read_csv('data/BOM_data.csv')
BOM_stations <- read_csv('data/BOM_stations.csv')
BOM_data
BOM_stations
#Question 1
select(BOM_data, Station_number,Temp_min_max)
Bom_data_temp <- select(BOM_data, Station_number,Temp_min_max, Rainfall) %>% 
  separate(Temp_min_max,into= c('min', 'max'), sep='/') %>% filter(min!= '-', max!= '-',
                                                                   Rainfall != '-')
Bom_data_temp

Bom_data_minmax <-group_by(Bom_data_temp, Station_number) %>% 
  summarise(n_days= n())
Bom_data_minmax

#Question 2
Bom_data_temp
mutate (Bom_data_temp, dif_temp= 'max' - 'min')
?mutate
