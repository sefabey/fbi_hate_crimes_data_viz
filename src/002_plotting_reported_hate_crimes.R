library(tidyverse)
library(ggplot2)
library(ggmap)
library(hrbrthemes)
# try plotting
# devtools::install_github("dkahle/ggmap", force=T)
# install.packages("ggmap")
# devtools:: install_version("ggplot2", version = "2.2.1", repos = "http://cran.us.r-project.org")
# install.packages("ggplot2")
reported_agency_geo_complete <- read_csv('data/Table_13_geo_003.csv')

reported_agency_geo_complete_2 <- reported_agency_geo_complete%>% 
  filter(State!='Alaska') %>% 
  filter(Population>10000 | is.na(Population)) #%>%  # NAs are metropolitan counties. They should be included.

usa_bbox <- make_bbox(lat = lat, lon = lon, data = reported_agency_geo_complete_2)
usa_big <- get_map(location = usa_bbox, maptype = 'terrain-background')
reported_agency_geo_complete %>% names

ggmap(usa_big) + 
  geom_point(data = reported_agency_geo_complete_2, 
             mapping = aes(x = lon, y = lat, size = Total_incidents_Q1_to_Q4))+
  # scale_size_area()+
  scale_radius(range=c(0.05, 5))+
  scale_color_viridis_d()+
  labs(x="Longitude", y="Latitude",
       title="Hate Crimes Reported by the US Law Enforcement Agencies in 2016",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="Social Data Science Lab, Cardiff University") +
  theme_ipsum_rc()+
  theme(legend.position="bottom",
        legend.direction = "horizontal",
        legend.title = element_text( size=14),
        plot.caption= element_text(size=14))+
  labs(size="Legend")+
  NULL

ggsave(filename = 'viz/reported_hate_crimes.png', device = "png", scale = 2, dpi = 'retina', width = 20, height = 12, units = "cm")
