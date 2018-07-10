library(tidyverse)

reported_state <- read_csv("data/table_12_agency_hate_crime_reporting_by_state_2016.csv")
reported_agency <- read_csv("data/Table_13_Hate_Crime_Incidents_per_Bias_Motivation_and_Quarter_by_State_and_Agency_2016.csv")

install.packages("ggmap")
library(ggmap)

reported_agency %>% 
  mutate(agency_with_state= paste(Agency_name, State, sep = ", ")) %>% #paste state names to agencies
  mutate_geocode(agency_with_state, sensor=F) -> reported_agency_geog