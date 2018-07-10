library(tidyverse)

reported_state <- read_csv("data/table_12_agency_hate_crime_reporting_by_state_2016.csv")
reported_agency <- read_csv("data/Table_13_Hate_Crime_Incidents_per_Bias_Motivation_and_Quarter_by_State_and_Agency_2016.csv")

install.packages("ggmap")
library(ggmap)

reported_agency %>% 
  mutate(agency_with_state= paste(Agency_name, State, sep = ", ")) %>% #paste state names to agencies
  mutate_geocode(agency_with_state, sensor=F) -> reported_agency_geog


reported_agency_geog$lat %>% is.na() %>% table()

reported_agency_geog %>% 
  filter(is.na(lat)) %>% 
  mutate_geocode(agency_with_state, sensor=F)-> reported_agency_geog_2

reported_agency_geog_2 <- reported_agency_geog_2 %>% 
  mutate(lon=lon.1) %>% 
  mutate(lat=lat.1) %>% 
  select(-lon.1, -lat.1)

reported_agency_geog_2 %>% 
  filter(is.na(lat)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)-> reported_agency_geog_3

reported_agency_geog_3 %>% 
  filter(is.na(lat)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) -> reported_agency_geog_4

reported_agency_geog %>%
  left_join(reported_agency_geog_2) %>%
  left_join(reported_agency_geog_3)%>%
  left_join(reported_agency_geog_4)-> reported_agency_geo_complete

reported_agency_geo_complete %>% write_csv("data/Table_13_geo_002.csv")

