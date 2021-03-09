library(readr)
library(dplyr)

## repo url https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations
url <- "https://github.com/owid/covid-19-data/raw/master/public/data/vaccinations/vaccinations.csv"

vac_data <- read_csv(url)

## get latest data for each country---------

vac_data <- vac_data %>%
    group_by(`iso_code`) %>%
    mutate(latest_day = max(date))

latest_vac_data <- vac_data %>%
    group_by(`iso_code`) %>%
    filter(date == latest_day)

write_csv(vac_data, "vac_data.csv")

write_csv(latest_vac_data, "latest_vac_data.csv")

iso3s <- readRDS("./iso3_keys.rds")

african_vac_data <- subset(vac_data, (`iso_code` %in% iso3s))

african_latest_vac_data <- subset(latest_vac_data, (`iso_code` %in% iso3s))

write_csv(african_vac_data, "african_vac_data.csv")

write_csv(african_latest_vac_data, "african_latest_vac_data.csv")
