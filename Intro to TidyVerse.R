#Load the relevant packages
library(gapminder)
library(dplyr)
library(ggplot2)

#Have a look at the GapMinder dataset
gapminder

glimpse(gapminder)

##DATA WRANGLING

#Filtering for one year
gapminder %>%
  filter(year == 2007)

#Filtering for one country
gapminder %>%
  filter(country == "Canada")

#Filtering for two variables
gapminder %>%
  filter(year == 2007, country == "Canada")

#Sorting with arrange()
gapminder %>%
  arrange(gdpPercap)

#Sorting in descending order
gapminder %>%
  arrange(desc(gdpPercap))

#Filtering then arranging
gapminder %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

#Using mutate to change a variable
gapminder %>%
  mutate(pop = pop / 1000000)

#Using mutate to add new variable
gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

##VISUALIZATION WITH ggplot2

#Variable assignment
gapminder_2007 <- gapminder %>%
  filter(year == 2007)

#Scatter Plot
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#Using Log Scales
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

#Additional aesthetics
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10()

#Faceting
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ year)

#Summarizing
gapminder %>%
  summarize(meanLifeExp = mean(lifeExp))

#Summarizing one year
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp))

#Summarizing into multiple columns
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

#Grouping (Summarizing by year)
gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

#Summarizing by continent
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

#Summarizing by continent and year
gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

#Visualizing summarized data by year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))
by_year
ggplot(by_year, aes(x = year, y = totalPop)) +
  geom_point()

#Starting Y-axis at 0
ggplot(by_year, aes(x = year, y = totalPop)) +
  geom_point() +
  expand_limits(y = 0)

#Visualizing summarized data by year and continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

ggplot(by_year_continent, aes(x = year, y = totalPop)) +
  geom_point() +
  expand_limits(y = 0)

ggplot(by_year_continent, aes(x = year, y = totalPop, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

#Line Plots
ggplot(by_year_continent, aes(x = year, y = totalPop, color = continent)) +
  geom_line() +
  expand_limits(y = 0)

#Bar Plots
by_continent <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp))
by_continent  

ggplot(by_continent, aes(x = continent, y = meanLifeExp)) +
  geom_col()

#Histograms
ggplot(gapminder_2007, aes(x = lifeExp)) +
  geom_histogram()

ggplot(gapminder_2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5)

#Box Plots
ggplot(gapminder_2007, aes(x = continent, y = lifeExp)) + 
  geom_boxplot()
