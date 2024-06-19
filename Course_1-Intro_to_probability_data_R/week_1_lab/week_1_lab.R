# Week 1 Lab: Introduction to R and RStudio
## Personal notes to supplement lab 1

here()
data("arbuthnot")
str(arbuthnot)
skim_without_charts(arbuthnot)
dim(arbuthnot) # Dimensions of an object (dataframe)
colnames(arbuthnot)
# or just
names(arbuthnot)

## Access observations (rows) by naming columns from the dataset
arbuthnot$boys
arbuthnot$girls

## Using ggplot for initial data exploration; number of girls baptized per year
arbuthnot %>%
  ggplot(aes(x = year, y = girls)) +
  geom_point()

## Adding observation values, boys and girls
arbuthnot$boys + arbuthnot$girls

## Adding a new column using the mutate() from dplyr
arbuthnot <- arbuthnot %>%
  mutate(total = boys + girls)

## New plot, a line chart
arbuthnot %>%
  ggplot(aes(x = year, y = total)) +
  geom_line()

## Exercise: Now, generate a plot of the proportion of boys born over time. What do you see?
arbuthnot %>%
  ggplot(aes(x = year, y = boys / total)) +
  geom_point()

## Making comparisons with >, < and ==
arbuthnot <- arbuthnot %>%
  mutate(more_boys = boys > girls)

## Dataset 2: Present birth records
data(present)
View(present)

## How many variables are included in this data set?
dim(present)
str(present)

### 3 (initially, before data manipulation)

## What years are included in this dataset? **Hint:** Use the `range` function and `present$year` as its argument.
range(present$year)

## Calculate the total number of births for each year and store these values in a new 
## variable called `total` in the `present` dataset. Then, calculate the proportion of 
## boys born each year and store these values in a new variable called `prop_boys` in 
## the same dataset. Plot these values over time and based on the plot determine if the 
## following statement is true or false: The proportion of boys born in the US has 
## decreased over time.
present <- present %>%
  mutate(total = boys + girls)

present <- present %>%
  mutate(prop_boys = boys / total)

present %>%
  ggplot(aes(x = year, y = prop_boys)) +
  geom_point()

### True

## Create a new variable called `more_boys` which contains the value of either `TRUE` 
## if that year had more boys than girls, or `FALSE` if that year did not. Based on this 
## variable which of the following statements is true?
present <- present %>%
  mutate(more_boys = boys > girls)

### Every year there are more boys born than girls

## Calculate the boy-to-girl ratio each year, and store these values in a new variable called `prop_boy_girl` in the `present` dataset. 
## Plot these values over time. Which of the following best describes the trend?
present <- present %>%
  mutate(prop_boy_girl = boys / girls)

present %>%
  ggplot(aes(x = year, y = prop_boy_girl)) +
  geom_point()

### Increase, decrease, increase, decrease

## In what year did we see the most total number of births in the U.S.? *Hint:* Sort 
## your dataset in descending order based on the `total` column. You can do this 
## interactively in the data viewer by clicking on the arrows next to the variable 
## names. Or to arrange the data in a descending order with new function: `desc` (for descending order).

sum_pivot_table <- present %>%
  group_by(year) %>%
  summarize(births = total) %>%
  arrange(desc(births))

### 2007