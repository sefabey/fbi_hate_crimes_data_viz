# plot 1: less clutter, albers projection =====
# excludes metropolitan counties (no population data provided)

library(tidyverse)
library(ggmap)
library(scales)
options(scipen=999)

non_report_agencies_geo_over10K <- read_csv('data/table_14_geo_007.csv') %>% 
  filter(state!='Alaska')

non_report_agencies_geo_over10K %>% arrange(desc(lat))

us <- map_data("state")

ggplot()+
  geom_map(data = us, map=us,
           aes(x=long, y=lat, map_id=region),
           fill="#EAD1BE", color="#C9C1BB", size=0.25)+
  coord_map("albers",lat0=39, lat1=45)+
  
  geom_point(data = non_report_agencies_geo_over10K, 
             mapping = aes(x = lon, y = lat, size = population))+
  
  scale_radius(range=c(0.01, 4), breaks = c(11000,50000,100000,200000,300000))+
  # scale_size(label=comma)+
  labs(x="Longitude", y="Latitude",
       title="Population of Cities Where the US Law Enforcement Agencies Did not Report Hate Crime in 2016",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="Social Data Science Lab, Cardiff University") +
  
  theme_ipsum_rc()+
  theme(legend.position="right",
        legend.direction = "vertical",
        legend.title = element_text( size=12),
        plot.caption= element_text(size=14),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank()
        
  )+
  labs(size="Population")+
  NULL

ggsave(filename = 'viz/non_report_agency_populations.png', device = "png", scale = 2, dpi = 600, width = 20, height = 12, units = "cm")


