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

#Question 2- lowest average daily temperature difference- June
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

#Question3-State lowest average daily temperature difference
BOM_stations
Bom_station_ga <- gather(BOM_stations, key= 'Station_number', value = 'data', -info)
Bom_station_ga                                                                         
Bom_station_sp <- spread(Bom_station_ga, key='info', value= 'data')
Bom_station_sp
Bom_station_sp$Station_number <- as.numeric(Bom_station_sp$Station_number)
#Bring data from challenge 2
#Combined data 1 and 2
Bom_combined <- left_join(Bom_station_sp, Bom_data_temp, by= "Station_number")
Bom_combined
Bom_mean_combined <- Bom_combined %>% 
  group_by(state) %>% 
  mutate(Temp_diff=Temp_max- Temp_min) %>%   
  summarise(mean_state_min=mean(Temp_min), mean_state_max=mean(Temp_max))
 # filter(is.na(Temp_diff))
#Final answer Question 3 = QLD
Bom_Temp_diff_state <- mutate(Bom_mean_combined, Temp_diff= mean_state_max-mean_state_min) %>% 
  arrange(Temp_diff)

#Question4