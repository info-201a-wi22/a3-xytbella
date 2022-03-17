library(tidyverse)
library(dplyr)
library(ggplot2)
library(maps)
library(patchwork)
library(mapproj)

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")

reshaped_race_data <- incarceration %>%
  select(
    year, state, county_name, black_jail_pop, latinx_jail_pop, white_jail_pop, aapi_jail_pop, native_jail_pop, other_race_jail_pop) %>%
  filter(state == "WA") %>%
  filter(county_name == "King County") %>%
  pivot_longer(
    cols = c("black_jail_pop", "latinx_jail_pop", "white_jail_pop", "aapi_jail_pop", "native_jail_pop", "other_race_jail_pop"),
    names_to = "race",
    values_to = "value"
  )

time_chart <- ggplot(reshaped_race_data) +
  geom_line(aes(x = year, y = value, group = race, color = race)) +
  labs(title = "Total jail population of different races in King County WA", x = "year", y = "Jail Population",
       color = "population of different races") +
  xlim(1980, 2018) 

time_chart



library(tidyverse)
library(dplyr)
library(ggplot2)
library(maps)
library(patchwork)
library(mapproj)

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")


gender_data <- incarceration %>%
  filter(state == "WA") %>%
  filter(county_name == "King County") %>%
  select(year, male_jail_pop, female_jail_pop, total_jail_pop) %>%
  mutate(male_ratio = male_jail_pop / total_jail_pop) %>%
  mutate(female_ratio = female_jail_pop / total_jail_pop) %>%
  pivot_longer(col = c("male_ratio", "female_ratio"), 
               names_to = "gender", 
               values_to = "ratio")

comparison_chart <- ggplot(gender_data) +
  geom_col(mapping = aes(x = year, y = ratio, fill = gender), position = "dodge") +
  labs(
    title = "different gender jail ratio in King county, WA",
    x = "year",
    y = "ratio",
    fill = "ratio of different gender"
  )

comparison_chart


