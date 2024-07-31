rm(list = ls())

setwd('C:/Users/jluo1/OneDrive/Documents/statsProj')
library(tidyverse)
library(lubridate)
library(chron)

# Data Info: https://data.detroitmi.gov/datasets/detroitmi::rms-crime-incidents/about
df <- read.csv('RMS_Crime_Incidents.csv')


df <- df %>%
  arrange(incident_timestamp) %>%
  distinct(crime_id, .keep_all = TRUE) %>%
  select(-c(X, Y, ibr_date, oid, precinct)) %>%
  filter(year %in% (2021:2024))

# Data Types
sapply(df, class)

# Date Conversion
df$incident_timestamp <- as.POSIXct(df$incident_timestamp, format = "%Y/%m/%d %H:%M:%S")
class(df$incident_timestamp)


# Obtain month
df$month <- month(df$incident_timestamp)
colnames(df)
df <- df %>%
  relocate(month, .after = year) %>%
  relocate(neighborhood, .after = address) %>%
  relocate(zip_code, .before = address) %>%
  na.omit()

# Inter-arrival times between incidents
df$interarrival_time <- NA
df$interarrival_time[1] <- 0
for (i in 2:dim(df)[1]) {
  df$interarrival_time[i] <- abs(as.numeric(difftime(df$incident_timestamp[i], df$incident_timestamp[i-1], units = 'hours')))
}


# Data export
write.csv(df, 'RMS_Crime_Incidents_Cleaned.csv', row.names = FALSE)
