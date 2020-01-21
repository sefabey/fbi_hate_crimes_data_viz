# geolocating dataset====
# CAUTION: the code is not replicable at all! This is due to unpredicted query returns form google maps API. 
# the logic is the same but had to re-run the same code over and over to get all agency geocodes.
# Output csv should works allright, though.

library(tidyverse)
library(ggplot2)
library(ggmap)
library(hrbrthemes)

reported_state <- read_csv("data/data_2016/table_12_agency_hate_crime_reporting_by_state_2016.csv")
reported_agency <- read_csv("data/data_2016/Table_13_Hate_Crime_Incidents_per_Bias_Motivation_and_Quarter_by_State_and_Agency_2016.csv")

# install.packages("ggmap")



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

reported_agency_geo_complete <- read_csv('data/Table_13_geo_002.csv')
reported_agency_geo_complete %>% filter(is.na(lon)) %>% nrow() # apprently, not very complete. still 229 rows are missing geocode

reported_agency_geo_complete %>% 
  filter(is.na(lat)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) ->reported_agency_geog_5

reported_agency_geog_5%>% filter(is.na(lon)) %>% nrow() #84 NAs

temp <- reported_agency_geo_complete %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_5) %>% 
  arrange(State)

reported_agency_geog_6 <- temp %>% 
  filter(is.na(lat)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)

reported_agency_geog_6%>% filter(is.na(lon)) %>% nrow() #34 NAs, getting there

temp2 <- temp %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_6) %>% 
  arrange(State)


temp2%>% filter(is.na(lon)) %>% nrow() #34 NAs, getting there

reported_agency_geog_7 <- temp2 %>% 
  filter(is.na(lon)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)


temp3 <- temp2 %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_7) %>% 
  arrange(State)

temp3%>% filter(is.na(lon)) %>% nrow() #20 NAs, getting there


reported_agency_geog_8 <- temp3 %>% 
  filter(is.na(lon)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)

temp4 <- temp3 %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_8) %>% 
  arrange(State)

temp4%>% filter(is.na(lon)) %>% nrow() #14 NAs, lets check them out

temp4%>% filter(is.na(lon)) %>% View()

reported_agency_geog_9 <- temp4 %>% 
  filter(is.na(lon)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)

temp5 <- temp4 %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_9) %>% 
  arrange(State)

temp5%>% filter(is.na(lon)) %>% nrow() #9 NAs, lets check them out
ggmap::geocodeQueryCheck() #2119 queries remaining

reported_agency_geog_10 <- temp5 %>% 
  filter(is.na(lon)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)

temp6 <- temp5 %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_10) %>% 
  arrange(State)

temp6%>% filter(is.na(lon)) %>% nrow() #9 NAs, lets check them out

reported_agency_geog_11 <- temp6 %>% 
  filter(is.na(lon)) %>% 
  select(-lon, -lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)

temp7 <- temp6 %>% 
  filter(!is.na(lon)) %>% 
  bind_rows(reported_agency_geog_11) %>% 
  arrange(State)

temp7%>% filter(is.na(lon)) %>% nrow() #1
temp7%>% filter(is.na(lon))

# edit  Pierce, Washington and  Island, Washington manually

write_csv(temp7, 'data/Table_13_geo_003.csv')

reported_agency_geo_complete <- read_csv('data/Table_13_geo_003.csv') 
  

# geolocations look alright now. however, populations are weird.

reported_agency_geo_complete %>% 
  filter(is.na(Population)) # 394 agencies are mising population information
#not a big issue here but will be an issue for missing data
