# Week 2 Lab: Introduction to Data
## Personal notes to supplement lab 2

## Load NYC Flights data frame:
data("nycflights")
View(nycflights)
## View variables/columns/field names:
names(nycflights)
colnames(nycflights)
## View the structure of the data frame:
str(nycflights)
## Examine the distribution of departure delays of all flights with a histogram:
nycflights %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram()


## Adjusting the binwidth to better represent the data?:
nycflights %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(binwidth = 15)

nycflights %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(binwidth = 150)
## Use the filter() function to only view flights headed to RDU:
nycflights %>%
  filter(dest == "RDU") %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(color = 4, fill = "white")
### OR
rdu_flights <- nycflights %>%
  filter(dest == "RDU")
rdu_flights %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(color = 4, fill = "white")

## Obtain numerical summaries
rdu_flights %>%
  summarize(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), n = n())

## We can also filter based on multiple criteria. Suppose we are interested in flights headed to San Francisco (SFO) in February:
sfo_feb_flights <- nycflights %>%
  filter(dest == "SFO", month == 2)
