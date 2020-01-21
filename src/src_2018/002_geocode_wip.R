# Geocoding Hate Crime Data
library(tidyverse)
library(ggmap)

# DATA I/O and health check-----------
# read data and clean
reported_agency <- read_csv("data/data_2018/processed_data/Table_13_Hate_Crime_Incidents_per_Bias_Motivation_and_Quarter_by_State_and_Agency_2018_processed.csv") %>% 
  mutate(agency_with_state= paste(Agency_name, State, sep = ", ")) %>%
  mutate(agency_with_state= str_remove_all(agency_with_state, pattern = regex( paste0( c( "State Police: ", "Federal Bureau of Investigation Field Offices: "), collapse = "|" )))) %>% # without removing these, nominatim would not work
  mutate(agency_with_state= str_replace_all( agency_with_state,pattern = ":", ",")) # this is to remove the : from unis


# sample 20 and manually compare to FBI data 
reported_agency %>% 
  sample_n(100) %>%
  print()

# Looking good. Great job, Arron!

# Geo-coding data-------------

# using Open Street Maps Nominatim API (https://datascienceplus.com/osm-nominatim-with-r-getting-locations-geo-coordinates-by-its-address/)
  
  
nominatim_osm <- function(address = NULL)
  {
    if(suppressWarnings(is.null(address)))
      return(data.frame())
    tryCatch(
      d <- jsonlite::fromJSON( 
        gsub('\\@addr\\@', gsub('\\s+', '\\%20', address), 
             'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
      ), error = function(c) return(data.frame())
    )
    if(length(d) == 0) return(data.frame())
    return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
}



query_geocode <- function(address) {
  #set the elapsed time counter to 0
  t <- Sys.time()
  #calling the nominatim OSM API
  api_output <- nominatim_osm(address)
  #get the elapsed time
  t <- difftime(Sys.time(), t, 'secs')
  #return data.frame with the input address, output of the nominatim_osm function and elapsed time
  if (is.null(api_output$lat)){
    output_tibble= tibble (address, long=NA, latid=NA, elapsed_time=t)
  } else {
    output_tibble= tibble (address, long=api_output$lon, latid=api_output$lat, elapsed_time = t)
  }
  Sys.sleep(1)
  return(output_tibble)
 
  
}

# quick function tests
query_geocode("Cardiff, UK")
query_geocode("Cardasasdff, UK")

reported_agency %>% 
  sample_n(3) %>% 
  select(agency_with_state) %>% 
  pull %>% 
  map_df(query_geocode )
# tests looking good

# query the actual data
# api blocked me due to bulk scraping per https://operations.osmfoundation.org/policies/nominatim/. Chnaing the IP address worked
# Introduced 1 second sleep per call and will query overnight.

geocode_results <- reported_agency %>% 
  # sample_n(1) %>%
  select(agency_with_state) %>% 
  pull %>% 
  map_df(query_geocode )


reported_agency %>% 
  left_join(geocode_results, by=c("agency_with_state"= "address"))


  
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
