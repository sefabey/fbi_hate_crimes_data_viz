# fbi_hate_crimes_data_viz

This is a repo to visualise hate crimes data published by the FBI.

The aim is to create two maps that shows where hate crimes are recorded and also where they are not.

The idea is drawn from ProPublica's amazing viz https://projects.propublica.org/graphics/hatecrime-map.

First task is to download and clean data from FBI's website https://ucr.fbi.gov/hate-crime/2016/topic-pages/incidentsandoffenses.

First problem is, the data come in excel format, which is quite inconvenient. What's more (or worse), there are many merged cells and vague header groupings, which makes it nearly impossible to work with data. Therefore, it's necessary to pre-process the data manually. This is a huge pain and it will take time. 

Second problem is, the data are not geolocated: Although police agency names are explicitly stated, there is no postcode or long/lat info pertaining to each police force. Therefore, must find a way to acquire geo-locations for each police force to locate them on the map. There might be an R package for that.

