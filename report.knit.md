---
params:
  data: data
  report_config: report_config
  response: response
  set_title: report_title
title: "Data Profiling Report"
---



<script src="d3.min.js"></script>

### Basic Statistics
#### Raw Counts


Name                   Value      
---------------------  -----------
Rows                   188,027    
Columns                120        
Discrete columns       112        
Continuous columns     8          
All missing columns    0          
Missing observations   24,630     
Complete Rows          167,052    
Total observations     22,563,240 
Memory allocation      202.2 Mb   

#### Percentages
<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_intro-1.png" width="1344" />

### Data Structure
<!--html_preserve--><div id="htmlwidget-977376939c884d2c45bd" style="width:1000px;height:960px;" class="diagonalNetwork html-widget"></div>
<script type="application/json" data-for="htmlwidget-977376939c884d2c45bd">{"x":{"root":{"name":"root (Classes 'data.table' and 'data.frame':\t188027 obs. of  120 variables:)","children":[{"name":"ori (chr)"},{"name":"ori9 (chr)"},{"name":"hate_crime_incident_present_flag (chr)"},{"name":"state (chr)"},{"name":"state_abb (chr)"},{"name":"date (chr)"},{"name":"month (chr)"},{"name":"month_num (num)"},{"name":"day_of_week (chr)"},{"name":"year (num)"},{"name":"population (num)"},{"name":"agency_name (chr)"},{"name":"city_name (chr)"},{"name":"fips_state_code (chr)"},{"name":"fips_county_code (chr)"},{"name":"fips_state_county_code (chr)"},{"name":"fips_place_code (chr)"},{"name":"fips_state_place_code (chr)"},{"name":"agency_type (chr)"},{"name":"agency_subtype_1 (chr)"},{"name":"agency_subtype_2 (chr)"},{"name":"crosswalk_agency_name (chr)"},{"name":"census_name (chr)"},{"name":"population_group (chr)"},{"name":"country_division (chr)"},{"name":"country_region (chr)"},{"name":"core_city (chr)"},{"name":"fbi_field_office (chr)"},{"name":"judicial_district (chr)"},{"name":"date_ori_was_added (num)"},{"name":"msa_code_1 (num)"},{"name":"incident_number (chr)"},{"name":"unique_id (chr)"},{"name":"total_num_of_individual_victims (num)"},{"name":"total_offenders (num)"},{"name":"offenders_race_as_a_group (chr)"},{"name":"number_of_victims_offense_1 (num)"},{"name":"ucr_offense_code_1 (chr)"},{"name":"bias_motivation_offense_1 (chr)"},{"name":"location_code_offense_1 (chr)"},{"name":"vic_type_individual_offense_1 (chr)"},{"name":"vic_type_individual_offense_2 (chr)"},{"name":"vic_type_individual_offense_3 (chr)"},{"name":"vic_type_individual_offense_4 (chr)"},{"name":"vic_type_individual_offense_5 (chr)"},{"name":"vic_type_individual_offense_6 (chr)"},{"name":"vic_type_individual_offense_7 (chr)"},{"name":"vic_type_individual_offense_8 (chr)"},{"name":"vic_type_individual_offense_9 (chr)"},{"name":"vic_type_individual_offense_10 (chr)"},{"name":"vic_type_business_offense_1 (chr)"},{"name":"vic_type_business_offense_2 (chr)"},{"name":"vic_type_business_offense_3 (chr)"},{"name":"vic_type_business_offense_4 (chr)"},{"name":"vic_type_business_offense_5 (chr)"},{"name":"vic_type_business_offense_6 (chr)"},{"name":"vic_type_business_offense_7 (chr)"},{"name":"vic_type_business_offense_8 (chr)"},{"name":"vic_type_business_offense_9 (chr)"},{"name":"vic_type_business_offense_10 (chr)"},{"name":"vic_type_government_offense_1 (chr)"},{"name":"vic_type_government_offense_2 (chr)"},{"name":"vic_type_government_offense_3 (chr)"},{"name":"vic_type_government_offense_4 (chr)"},{"name":"vic_type_government_offense_5 (chr)"},{"name":"vic_type_government_offense_6 (chr)"},{"name":"vic_type_government_offense_7 (chr)"},{"name":"vic_type_government_offense_8 (chr)"},{"name":"vic_type_government_offense_9 (chr)"},{"name":"vic_type_government_offense_10 (chr)"},{"name":"vic_type_society_offense_1 (chr)"},{"name":"vic_type_society_offense_2 (chr)"},{"name":"vic_type_society_offense_3 (chr)"},{"name":"vic_type_society_offense_4 (chr)"},{"name":"vic_type_society_offense_5 (chr)"},{"name":"vic_type_society_offense_6 (chr)"},{"name":"vic_type_society_offense_7 (chr)"},{"name":"vic_type_society_offense_8 (chr)"},{"name":"vic_type_society_offense_9 (chr)"},{"name":"vic_type_society_offense_10 (chr)"},{"name":"vic_type_unknown_offense_1 (chr)"},{"name":"vic_type_unknown_offense_2 (chr)"},{"name":"vic_type_unknown_offense_3 (chr)"},{"name":"vic_type_unknown_offense_4 (chr)"},{"name":"vic_type_unknown_offense_5 (chr)"},{"name":"vic_type_unknown_offense_6 (chr)"},{"name":"vic_type_unknown_offense_7 (chr)"},{"name":"vic_type_unknown_offense_8 (chr)"},{"name":"vic_type_unknown_offense_9 (chr)"},{"name":"vic_type_unknown_offense_10 (chr)"},{"name":"vic_type_financial_offense_1 (chr)"},{"name":"vic_type_financial_offense_2 (chr)"},{"name":"vic_type_financial_offense_3 (chr)"},{"name":"vic_type_financial_offense_4 (chr)"},{"name":"vic_type_financial_offense_5 (chr)"},{"name":"vic_type_financial_offense_6 (chr)"},{"name":"vic_type_financial_offense_7 (chr)"},{"name":"vic_type_financial_offense_8 (chr)"},{"name":"vic_type_financial_offense_9 (chr)"},{"name":"vic_type_financial_offense_10 (chr)"},{"name":"vic_type_religious_offense_1 (chr)"},{"name":"vic_type_religious_offense_2 (chr)"},{"name":"vic_type_religious_offense_3 (chr)"},{"name":"vic_type_religious_offense_4 (chr)"},{"name":"vic_type_religious_offense_5 (chr)"},{"name":"vic_type_religious_offense_6 (chr)"},{"name":"vic_type_religious_offense_7 (chr)"},{"name":"vic_type_religious_offense_8 (chr)"},{"name":"vic_type_religious_offense_9 (chr)"},{"name":"vic_type_religious_offense_10 (chr)"},{"name":"vic_type_other_offense_1 (chr)"},{"name":"vic_type_other_offense_2 (chr)"},{"name":"vic_type_other_offense_3 (chr)"},{"name":"vic_type_other_offense_4 (chr)"},{"name":"vic_type_other_offense_5 (chr)"},{"name":"vic_type_other_offense_6 (chr)"},{"name":"vic_type_other_offense_7 (chr)"},{"name":"vic_type_other_offense_8 (chr)"},{"name":"vic_type_other_offense_9 (chr)"},{"name":"vic_type_other_offense_10 (chr)"}]},"options":{"height":null,"width":1000,"fontSize":35,"fontFamily":"serif","linkColour":"#ccc","nodeColour":"#fff","nodeStroke":"steelblue","textColour":"#111","margin":{"top":null,"right":250,"bottom":null,"left":350},"opacity":0.9}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Missing Data Profile
<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/missing_profile-1.png" width="1344" />

### Univariate Distribution

#### Histogram
<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_histogram-1.png" width="1344" />



#### Bar Chart (by frequency)

```
## 18 columns ignored with more than 50 categories.
## ori: 8731 categories
## ori9: 8772 categories
## state: 52 categories
## state_abb: 52 categories
## date: 9497 categories
## agency_name: 7015 categories
## city_name: 7135 categories
## fips_state_code: 52 categories
## fips_county_code: 266 categories
## fips_state_county_code: 2348 categories
## fips_place_code: 5549 categories
## fips_state_place_code: 7880 categories
## crosswalk_agency_name: 7280 categories
## census_name: 6447 categories
## fbi_field_office: 55 categories
## judicial_district: 93 categories
## incident_number: 186502 categories
## unique_id: 188027 categories
```

<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-1.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-2.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-3.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-4.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-5.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-6.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-7.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-8.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-9.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-10.png" width="1344" /><img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_frequency_bar-11.png" width="1344" />





#### QQ Plot
<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/plot_normal_qq-1.png" width="1344" />





### Correlation Analysis

```
## 22 features with more than 20 categories ignored!
## ori: 5868 categories
## ori9: 5868 categories
## state: 50 categories
## state_abb: 50 categories
## date: 9497 categories
## agency_name: 5128 categories
## city_name: 5268 categories
## fips_state_code: 50 categories
## fips_county_code: 185 categories
## fips_state_county_code: 1038 categories
## fips_place_code: 4140 categories
## fips_state_place_code: 5234 categories
## agency_subtype_2: 23 categories
## crosswalk_agency_name: 5222 categories
## census_name: 4646 categories
## fbi_field_office: 54 categories
## judicial_district: 91 categories
## incident_number: 165850 categories
## unique_id: 167052 categories
## ucr_offense_code_1: 44 categories
## bias_motivation_offense_1: 35 categories
## location_code_offense_1: 45 categories
```

<img src="/Users/sefaozalp/Documents/Work/fbi_hate_crimes_data_viz/report_files/figure-html/correlation_analysis-1.png" width="1344" />












