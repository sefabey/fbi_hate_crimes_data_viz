library(tidyverse)
library(ggplot2)
library(ggmap)
library(hrbrthemes)
# try plotting
# devtools::install_github("dkahle/ggmap", force=T)
# install.packages("ggmap")
# devtools:: install_version("ggplot2", version = "2.2.1", repos = "http://cran.us.r-project.org")
# install.packages("ggplot2")

reported_agency_geo_complete_2 <- reported_agency_geo_complete%>% 
  filter(State!='Alaska') %>% 
  filter(Population>10000 | is.na(Population)) #%>%  # NAs are metropolitan counties. They should be included.

usa_bbox <- make_bbox(lat = lat, lon = lon, data = reported_agency_geo_complete_2)
usa_big <- get_map(location = usa_bbox, maptype = 'terrain-background')
reported_agency_geo_complete %>% names

ggmap(usa_big) + 
  geom_point(data = reported_agency_geo_complete_2, 
             mapping = aes(x = lon, y = lat, size = Total_incidents_Q1_to_Q4, color=Agency_Type))+
  # scale_size_area()+
  scale_radius(range=c(0.1, 5))+
  scale_color_viridis_d()+
  theme_minimal()+
  NULL


us_map <- get_map('the US', maptype = 'terrain-background')

ggplot(temp_map)

us.map <- get_map(location=c(lon=-100, lat=40), zoom=4, maptype="terrain", filename="data/ggmapTemp")  
p <- ggmap(us.map) +  
  geom_point(data=reported_agency_geo_complete, aes(x=lon, y=lat, size=Bias_Motivation_Race_Ethnicity_Ancestry/10000))  

.libPaths()

