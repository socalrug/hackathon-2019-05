# load relevant libraries
library(dplyr)

# set working directory
setwd("Documents/Code/OCRUG Hackathon/Team")

# load data
stations <- read.csv("gw_stations.csv")
measure <- read.csv("measurements.csv")
pop <- read.csv("ca_pop_projections.csv")
pws <- read.csv("public_water_system_info.csv")
perf <- read.csv("gw_perforations.csv")

# clean data
measure$msmt_date <- as.Date(measure$MSMT_DATE)
measure$msmt_year <- format(measure$msmt_date, "%Y")
stations$county_rev <- tolower(stations$COUNTY_NAME)
pop$county_rev <- tolower(pop$county)

# enhance measurements data with counties mapped by stn_id;
# drop measurements data without a matching county
measure_stns <- inner_join(measure, stations, by='STN_ID')

# create summarized measurements dataset aggregating by county and year
measure_stns_mean <- measure_stations %>% group_by(county_rev, msmt_year) %>% dplyr::summarise(mean_wse = mean(GSE_WSE, na.rm=TRUE))
measure_stns_sum <- measure_stations %>% group_by(county_rev, msmt_year) %>% dplyr::summarise(sum_wse = sum(GSE_WSE, na.rm=TRUE))

# rename year column name
colnames(measure_stns_sum)[colnames(measure_stns_sum)=='msmt_year'] <- 'year'

# change year column type back to integer
measure_stns_sum$year <- as.integer(measure_stns_sum$year)

# create summarized population dataset aggregating by county and year
pop_sum <- pop %>% group_by(county_rev, year) %>% dplyr::summarise(sum_pop = sum(pop_total, na.rm=TRUE))

# merge measurement and population datasets
measure_pop <- inner_join(measure_stns_sum, pop_sum, by=c('county_rev', 'year'))

# output data to file
write.csv(measure_pop, "measure_pop.csv")