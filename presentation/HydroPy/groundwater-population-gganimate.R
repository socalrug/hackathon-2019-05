library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(gganimate)

wat01 <- readxl::read_excel("WAT01.xls", sheet = 2)
#from https://www.census.gov/library/publications/2011/compendia/usa-counties-2011.html#WAT
# you have to download it first because it's not quite clear which sheet goes with what statistics
# you need the Mastdata from the same site to figure out what the variable names mean

wat01 <- wat01 %>% filter(str_detect(Areaname, ",")) 
county_names <- as_tibble(str_split_fixed(wat01$Areaname, ", ", 2), .name_repair = "unique")
colnames(county_names) <- c("county","state")
wat <- cbind(wat01, county_names) %>% filter(state == "CA") %>% select(county, 
                                                                       `1990` = WAT140190D,
                                                                       `1995` = WAT140195D,
                                                                       `2000` = WAT140200D,
                                                                       `2005` = WAT140205D)
# Contains water usage data from 1990, 1995, 2000, and 2005 in each county
# here we investigate groundwater consumption
# we need to gather 
wat.usage <- wat %>% gather(key = "year", value = "usage", -county, convert = TRUE) %>% as_tibble()

# use the population projection data file to get estimated total population
pop <- data.table::fread("./02_california-population-projection/dof_dru_pop_1970_2050_csya_wide.csv")
pop <- pop %>% mutate(county = str_to_title(county))

county.year.pop <- pop %>% group_by(county, year) %>% summarize(pop = sum(pop_total))

# joint the water and population files
wat.pop <- wat.usage %>% left_join(county.year.pop, by = c("county" = "county", "year" = "year"))

options(gganimate.dev_args = list(width = 800, height = 600)) # fix the size of the .gif to output
ggplot(wat.pop, aes(x = pop, y = usage)) + geom_text(aes(x = pop, y = usage, label = county), size = 5) + theme_bw() +
  scale_x_continuous(trans="log10", limits = c(1000, 1e7)) + scale_y_continuous(trans = "log10", limits = c(0.01, 2000)) +
  labs(x = "Population", y = "Usage (mgd)") + theme(axis.title = element_text(size = 20), plot.title = element_text(hjust = 0.5, size = 28)) +
  transition_states(year) + labs(title = "Groundwater Usage By County: {closest_state}")
anim_save("usage_vs_pop_over_time.gif")

