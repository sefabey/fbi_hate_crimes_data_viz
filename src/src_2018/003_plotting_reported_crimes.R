library(tidyverse)
library(ggmap)
library(hrbrthemes)

reported_agency_geo_complete <- read_csv('data/data_2018/processed_data/Table_13_geocoded.csv')

reported_agency_geo_complete %>% 
  arrange(desc(Total_incidents_bias_motivation))

# data check
reported_agency_geo_complete %>% 
  select(lon, lat, agency_with_state) %>% 
  skimr::skim() # data looking good



reported_agency_geo_complete_2 <- reported_agency_geo_complete %>% 
  filter(!State %in% c('Alaska', "Hawaii")) %>% 
  filter(Population>10000 | is.na(Population)) #%>%  # NAs are metropolitan counties. They should be included.

usa_bbox <- make_bbox(lat = lat, lon = lon, data = reported_agency_geo_complete_2)
usa_big <- get_map(location = usa_bbox, maptype = 'terrain-background')
reported_agency_geo_complete %>% names

plot_ggmap <-  ggmap(usa_big) + 
  geom_point(data = reported_agency_geo_complete_2, 
             mapping = aes(x = lon, y = lat, size = Total_incidents_Q1_to_Q4))+
  # scale_size_area()+
  scale_radius(range=c(0.05, 5))+
  scale_color_viridis_d()+
  labs(x="Longitude", y="Latitude",
       title="Hate Crimes Reported by the US Law Enforcement Agencies in 2018",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="Social Data Science Lab, Cardiff University") +
  theme_ipsum_rc()+
  theme(legend.position="bottom",
        legend.direction = "horizontal",
        legend.title = element_text( size=14),
        plot.caption= element_text(size=14))+
  labs(size="Legend")+
  NULL

ggsave(plot_ggmap, filename = 'viz/viz_2018/reported_hate_crimes_crowded_map.pdf', device = cairo_pdf, scale = 1.8, dpi = 'retina', width = 20, height = 12, units = "cm")

# Above plot was too busy. Replotting with an empty plot.


# plot 2: less clutter =====

us <- map_data("state")

plot_flat <- ggplot()+
  geom_map(data = us, map=us,
           aes(x=long, y=lat, map_id=region),
           fill="#E7E7CB", color="#666633", size=0.15)+
  geom_point(data = reported_agency_geo_complete_2, 
             mapping = aes(x = lon, y = lat, size = Total_incidents_Q1_to_Q4))+
  scale_radius(range=c(0.01, 4))+
  scale_alpha()+
  labs(x="Longitude", y="Latitude",
       title="Hate Crimes Reported by the US Law Enforcement Agencies in 2018",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="HateLab, 2020, by @SefaOzalp") +
  
  theme_ipsum_rc()+
  theme(legend.position="bottom",
        legend.direction = "horizontal",
        legend.title = element_text( size=12),
        plot.caption= element_text(size=14),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank()
        
  )+
  labs(size="Number of Hate Crimes")+
  # scale_size(guide = "legend", 
             # trans = "log10"
             # )+
  NULL

ggsave(plot_flat, filename = 'viz/viz_2018/reported_hate_crimes_flat.pdf', device = cairo_pdf, scale=1.8, dpi = 500, width = 20, height = 12, units = "cm")


# plot 3: less clutter, albers projection =====


plot_albers <- ggplot()+
  geom_map(data = us, map=us,
           aes(x=long, y=lat, map_id=region),
           fill="#E7E7CB", color="#666633", size=0.25)+
  coord_map("albers",lat0=39, lat1=45)+
  
  geom_point(data = reported_agency_geo_complete_2, 
             mapping = aes(x = lon, y = lat, size = Total_incidents_Q1_to_Q4))+
  scale_radius(range=c(0.01, 4))+
  scale_alpha()+
  labs(x="Longitude", y="Latitude",
       title="Hate Crimes Reported by the US Law Enforcement Agencies in 2018",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="HateLab, 2020, by @SefaOzalp") +
  
  theme_ipsum_rc()+
  theme(legend.position="bottom",
        legend.direction = "horizontal",
        legend.title = element_text( size=12),
        plot.caption= element_text(size=14),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank()
        
  )+
  labs(size="Number of Hate Crimes")+
  NULL

ggsave(plot_albers, filename = 'viz/viz_2018/reported_hate_crimes_albers.pdf', device = cairo_pdf, scale=1.8, dpi = 500, width = 20, height = 12, units = "cm")


# plot 4: choropleth of states =====

library(usmap) # includes alaska and Hawaii

# plot_usmap("states")
# state_map <- us_map(regions = "states")
# str(state_map)
# state_map

dt_fbi_hatecrimes <- reported_agency_geo_complete %>% 
  group_by(State) %>% 
  summarise(total_incidents_state=sum(Total_incidents_Q1_to_Q4)) %>%
  mutate(fips=usmap::fips(State)) %>% 
  arrange(fips)

statepop %>% head()
dt_fbi_hatecrimes %>% head()

plot_state_choropleth <- plot_usmap(data = dt_fbi_hatecrimes, 
           values = "total_incidents_state" , color = "black") + 
  scale_fill_gradientn (
                        colours=rev(RColorBrewer::brewer.pal(8,"Spectral")),
                        # na.value="white",
                        na.value = "grey90",
                        guide = "colourbar")+
  labs(x="Longitude", y="Latitude",
       title="Hate Crimes Reported by the US Law Enforcement Agencies in 2018",
       subtitle="Source: FBI Hate Crime Statistics",
       caption="HateLab, 2020, by @SefaOzalp") +
  theme_ipsum_rc()+
  theme(legend.position="right",
        legend.direction = "vertical",
        legend.title = element_text( size=12),
        plot.caption= element_text(size=14),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank()
        
  )+
  labs(size="Number of Hate Incidents")+
  NULL

ggsave(plot_state_choropleth, filename = 'viz/viz_2018/reported_state_choropleth.pdf', device = cairo_pdf, scale=1.8, dpi = 500, width = 20, height = 12, units = "cm")
