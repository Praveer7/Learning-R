#Load relevant packages
library(gapminder)
library(dplyr)
library(ggplot2)

#Have a look at GapMinder dataset
gapminder

glimpse(gapminder)

#Select()
gapminder %>%
  select(continent, year, pop, gdpPercap)

#Using select for creating new table
gapminder_table <- gapminder %>%
  select(continent, year, pop, gdpPercap)
gapminder_table

#filter() and arrange()
gapminder_table %>%
  arrange(gdpPercap)

gapminder_table %>%
  arrange(desc(gdpPercap))

gapminder_table %>%
  arrange(desc(gdpPercap)) %>%
  filter(year == 2007)

gapminder %>%
  arrange(desc(gdpPercap)) %>%
  filter(lifeExp > 80)

gapminder %>%
  arrange(desc(gdpPercap)) %>%
  filter(year == 2007, lifeExp > 80) 

#mutate()
gapminder_table %>%
  mutate(gdp = gdpPercap * pop))
gapminder_table

#count()
gapminder %>%
  count()

gapminder %>%
  count(continent)

gapminder %>%
  count(continent, sort = TRUE)

gapminder %>%
  count(continent, wt = pop, sort = TRUE)

#summarize()
gapminder %>%
  summarize(total_pop = sum(pop))

gapminder %>%
  summarize(total_pop = sum(pop),
            avg_pop = mean(pop))

#summarize within groups, and then arrange
gapminder %>%
  group_by(continent) %>%
  summarize(total_pop = sum(pop),
            avg_pop = mean(pop)) %>%
  arrange(desc(avg_pop))

#group by two columns
gapminder %>%
  group_by(continent, year) %>%
  summarize(total_pop = sum(pop))

#ungroup()
gapminder %>%
  group_by(continent, year) %>%
  summarize(total_pop = sum(pop)) %>%
  ungroup()

#top_n verb (highest population)
gapminder_table %>%
  group_by(continent) %>%
  top_n(1, pop)

gapminder_table %>%
  group_by(continent) %>%
  top_n(3, pop)

#Selecting
gapminder %>%
  select(continent, year, pop, gdpPercap)

#Select a range (and then arrange)
glimpse(gapminder)

gapminder %>%
  select(continent, year:gdpPercap) %>%
  arrange(year)

#Contains
gapminder %>%
  select(country, continent, contains("life"))

#Starts with
gapminder %>%
  select(country, continent, starts_with("gdp"))

#Ends with
gapminder %>%
  select(country, continent, ends_with("Exp"))

#Removing a variable
gapminder %>%
  select(-country)

#Renaming a column (1. using rename())
gapminder %>%
  rename(population = pop)

#Renaming a column (2. using select())
gapminder %>%
  select(continent, year, population = pop)

#Transmute ~= select & mutate
gapminder %>%
  transmute(country, continent, gdp = pop * gdpPercap)

#Filter for multiple names
gapminder_names <- gapminder %>%
  filter(country %in% c("Canada", "Australia"))
gapminder_names  

#Grouped mutate
gapminder %>%
  group_by(year) %>%
  mutate(pop_sum = sum(pop)) %>%
  ungroup()

#Window function (lag)
gapminder %>%
  filter(country == "Canada") %>%
  mutate(difference = gdpPercap - lag(gdpPercap))
