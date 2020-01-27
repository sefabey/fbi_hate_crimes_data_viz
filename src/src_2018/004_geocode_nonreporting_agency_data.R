# wrangling data from agencies that do not report hate crimes

library(tidyverse)
library(ggmap)

# data IO----------

# read data
non_report_agencies <- read_csv('data/data_2018/processed_data/Table_14_Hate_Crime_Zero_Data_Submitted_per_Quarter_by_State_and_Agency_2018_processed.csv') %>% 
  janitor::clean_names() %>% 
  mutate(agency_with_state= paste(agency_name, state, sep = ", ")) #paste state 

# check data
table(non_report_agencies$agency_type) #cities, metropolitan counties, non metropolitan counties, other agencies, state police, tribal agencies, universities and colleges

# filter cities and other agencies with population over 10K
city_over_10k <- non_report_agencies %>% 
  filter(agency_type=="Cities") %>% 
  filter(population>10000) #2367 observations

not_city_over_10k <- non_report_agencies %>% 
  filter(agency_type!="Cities") %>% 
  filter(population>10000) #274 observations

over_10K <- rbind(city_over_10k, not_city_over_10k) #2641 observations

over_10K %>% 
  skimr::skim()
# geocode--------
geocode("1600 Amphitheatre Parkway, Mountain View, CA")

over_10K_geo <- over_10K %>% 
  mutate_geocode(agency_with_state, sensor=F)

over_10K_geo %>% 
  skimr::skim()

over_10K_geo %>% write_csv('data/data_2018/processed_data/table_14_over10K_geocoded.csv') #export the data

# iteration 2
over_10K_002 <- read_csv('data/table_14_geo_001.csv') %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) # query 991 rows where lon,lat is NA

over_10K_geo_001 <-  read_csv('data/table_14_geo_001.csv') %>% 
  filter(!is.na(lon))

over_10K_geo_002 <- rbind(over_10K_geo_001,over_10K_002 )

over_10K_geo_002 %>% filter(is.na(lon)) #362 Nas still

over_10K_geo_002 %>% write_csv("data/table_14_geo_002.csv") #save for the future


# iteration 3
over_10K_003 <- read_csv('data/table_14_geo_002.csv') %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) #query remaining 362 rows where lon,lat is NA

over_10K_geo_003 <- read_csv('data/table_14_geo_002.csv') %>% 
  filter(!is.na(lon))

over_10K_003 %>% nrow() #362
over_10K_geo_003 %>% nrow #2075

over_10K_geo_004 <- rbind(over_10K_003,over_10K_geo_003 )
over_10K_geo_004 %>% write_csv("data/table_14_geo_003.csv")


# iteration 4
over_10K_004 <- read_csv("data/table_14_geo_003.csv") %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) #query remaining 110 rows

over_10K_geo_005 <- read_csv('data/table_14_geo_003.csv') %>% 
  filter(!is.na(lon))

over_10K_004 %>% nrow() #110
over_10K_geo_005 %>% nrow #2327

over_10K_geo_006 <- rbind(over_10K_004,over_10K_geo_005 )

over_10K_geo_006 %>% write_csv("data/table_14_geo_004.csv")

# iteration 5

over_10K_005 <- read_csv("data/table_14_geo_004.csv") %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F) #query remaining 36 rows

over_10K_geo_007 <- read_csv('data/table_14_geo_004.csv') %>% 
  filter(!is.na(lon))

over_10K_005 %>% nrow() #36
over_10K_geo_007 %>% nrow #2401

over_10K_geo_008 <- rbind(over_10K_005,over_10K_geo_007 )
over_10K_geo_008 %>% write_csv("data/table_14_geo_005.csv")

# iteration 6
over_10K_006 <- read_csv("data/table_14_geo_005.csv") %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)#query remaining 12 rows

over_10K_geo_009 <- read_csv('data/table_14_geo_005.csv') %>% 
  filter(!is.na(lon))

over_10K_006 %>% nrow() #12
over_10K_geo_009 %>% nrow #2425

over_10K_geo_010 <- rbind(over_10K_006,over_10K_geo_009 )
over_10K_geo_010 %>% write_csv("data/table_14_geo_006.csv")

# iteration 7

over_10K_007 <- read_csv("data/table_14_geo_006.csv") %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)#query remaining 8 rows

over_10K_geo_011 <- read_csv('data/table_14_geo_006.csv') %>% 
  filter(!is.na(lon))

over_10K_007 %>% nrow() #8
over_10K_geo_011 %>% nrow #2429


over_10K_geo_012 <- rbind(over_10K_007,over_10K_geo_011 )
over_10K_geo_012 %>% write_csv("data/table_14_geo_007.csv")

# iteration 8

over_10K_007 <- read_csv("data/table_14_geo_007.csv") %>% 
  filter(is.na(lon)) %>% 
  select(-lon,-lat) %>% 
  mutate_geocode(agency_with_state, sensor=F)#query remaining 2 rows

