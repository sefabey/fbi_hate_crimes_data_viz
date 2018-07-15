# wrangling data from agencies that do not report hate crimes

library(tidyverse)
library(ggmap)

non_report_agencies <- read_csv('data/table_14_agency_hate_crime_reporting_by_state_2016.csv') %>% 
  mutate(agency_with_state= paste(agency_name, state, sep = ", ")) #paste state names to agencies
  

table(non_report_agencies$agency_type) #cities, metropolitan counties, non metropolitan counties, other agencies, state police, tribal agencies, universities and colleged

city_over_10k <- non_report_agencies %>% 
  filter(agency_type=="Cities") %>% 
  filter(population>10000) #2260 observations

not_city_over_10k <- non_report_agencies %>% 
  filter(agency_type!="Cities") %>% 
  filter(population>10000) #177 observations


over_10K <- rbind(city_over_10k, not_city_over_10k) #2437 observations
geocodeQueryCheck() #2500 geocoding queries remaining.


over_10K_geo <- over_10K %>% 
  mutate_geocode(agency_with_state, sensor=F)

over_10K_geo %>% write_csv('data/table_14_geo_001.csv')
