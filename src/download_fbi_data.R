library(usethis)
library(tidyverse)
library(fs)
library(zip)

# function
download_fbi_data <- function(year, parent_path=getwd()){
  "this function will download files based on year value and create a 'data_year/' folder in the parenth_path specified" 
  
  url_tables <- paste0("https://ucr.fbi.gov/hate-crime/",year,"/downloads/hate-crime-statistics-",year,"-tables.zip")
  # url_pdfs <- paste0("https://ucr.fbi.gov/hate-crime/",year,"/downloads/hate-crime-statistics-",year,"-pdfs.zip")
  
  year_data_path <- paste0(parent_path, "data_", year, "/" )
  
  if (!dir.exists(year_data_path)){
    dir.create(year_data_path)
  } else {
    print("Year data folder already exists!")
  }
  
  
  usethis:::tidy_download(url_tables, destdir = year_data_path)
  # usethis:::tidy_download(url_pdfs, destdir = year_data_path) # pdf URLs are not uniform across the years
  
  fs::dir_ls(year_data_path,glob = "*.zip") %>%
    map(zip::unzip,
        exdir=paste0(year_data_path)
    )
  
}