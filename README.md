# fbi_hate_crimes_data_viz

This is a repo to visualise the hate crimes in 2016 data which are published by the FBI.

The aim is to create two maps that show where hate crimes are recorded and also where they are not.

The inspiration comes from ProPublica's amazing work https://projects.propublica.org/graphics/hatecrime-map. This is mostly replication at this stage but might evolve into something else, will see.

First task is to download and clean data from FBI's website https://ucr.fbi.gov/hate-crime/2016/topic-pages/incidentsandoffenses. Although this is a straightforward task, as always, there are problems.

First problem is that the data provided by the FBI come in excel format, which is quite inconvenient. What's more (or worse), there are many merged cells and header groupings, which makes it nearly impossible to work with the data. Therefore, it's necessary to pre-process the data manually. This is a huge pain and it will take time. 

Second problem is, the data are not geolocated. Although police agency names are explicitly stated, there is no postcode or long/lat info pertaining to each police force. Therefore, must find a way to acquire geo-locations for each police force to locate them on the map. There might be an R package for that, will check. The US is a well studied country.
