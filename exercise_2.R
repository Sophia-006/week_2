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

#Question 2- June
Bom_data_temp <- select(BOM_data, Station_number,Month,Temp_min_max) %>% 
  separate(Temp_min_max, into = c("Temp_min", "Temp_max"), 
                         sep="/", remove= FALSE) %>% 
  filter(Temp_min!= '-',Temp_max!='-') 

Bom_data_temp
Bom_data_temp$Temp_min<-as.numeric(Bom_data_temp$Temp_min)
Bom_data_temp$Temp_max<-as.numeric(Bom_data_temp$Temp_max)
mutate (Bom_data_temp, dif_temp= Temp_max-Temp_min) %>% group_by(Month) %>% 
  summarise(n_dif_temp= mean(dif_temp)) %>% arrange(n_dif_temp)
Bom_data_temp

#Question 3
BOM_stations
Bom_station_ga <- gather(BOM_stations, key= 'Station_number', value = 'data', -info)
Bom_station_ga                                                                         
Bom_station_sp <- spread(Bom_station_ga, key='info', value= 'data')
Bom_station_sp
