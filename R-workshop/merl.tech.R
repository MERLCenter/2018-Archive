## MERL Tech DC 2018 

#R Script

## (Make sure you've setup your working directory, installed and activated packages, and read in your data before using this script)

# get a quick overview of your dataset, including number of variables (columns) and observations (rows)
glimpse(df)

# This is where you execute R ccommands. R interprets what you write and prints the results
1 + 1

# A basic concept in programming is called a variable. A variable allows you to store a value (e.g. 5) or an object (e.g. a function) in R for easy access later. 
## TIP: use "Alt" + "-" instead of "<" + "-"

#creating variables for later use. Use the less sign followed by a dash to create a variable

width <- 5                       # assigns the value 5 to the variable "width"
length <- 8                      # assigns the value 8 to the variable "width"
area <- width * length           # multiple the values of both previous variables to create a new variable: "area" 

area  # print the result


## Cleaning your data  
#Analyzing survey data typically starts with cleaning, recoding, and restructuring, or even joining data sets. For example, you may want to know how many missing cases there are or how many people responded to each question. Or you may want to group certain continuous variables like ages or income into ranges. Lastly, you may want to find and deal with outliers.

# remove duplicated rows (if any). The distinct() function keeps only unique rows.
df <- distinct(df)

# You can also choose to remove duplicated rows for specific variables like ID.x and ID.y
df <- distinct(df, ID.x, ID.y, .keep_all = TRUE)

# Group responses and create a new variable using mutate function (dplyr package)
#this creates a new variable that recodes the Age variable into 5 age categories 

df <- df %>% mutate(AgeCut = cut(Age, c((10:29), c(30:34), c(35:50),(51:65), c(66:100))))

## Overview of survey data and basic analysis
# When you're analyzing survey data, one of the first things you need to do is get an overview of your data. For example, you may want to know basis stats for continuous variables or frequency tables for other types of data.

# Get summary stats for one variable

summary(df$Age, IQR = TRUE)

# add new stats

df %>% summarise(
  mean = mean(Age, na.rm = TRUE),
  median = median(Age, na.rm = TRUE),
  IQR = IQR(Age, na.rm = TRUE), n = n()
  )

# add a grouping variable
df %>%
  group_by(Gender) %>%
  summarise(
    mean = mean(Age, na.rm = TRUE),
    median = median(Age, na.rm = TRUE),
    IQR = IQR(Age, na.rm = TRUE), n = n()
  )


#1. Get summary statistics for another continuous variable
# (other variables may includ: income, MonthsProgramming, ExpectedEarning, MoneyForLearning, etc.

#2. Add or change the summary stats you want to calculate 
#(Other useful functions: mean, median, sd, IQR, min, max, quantile, first, last, nth, n, n_distinct)

#3. Add a new grouping variable


# Here's another way to quickly generate summary statistics for select numeric variables using the psyche package
df %>%
  select(c("Age", "Income", "ExpectedEarning", "HoursLearning", "Gender")) %>%
  describeBy("Gender")

## Working with Categorical data  
# summarize categorical data by creating frequency tables using sjmisc package
df %>% frq(SchoolDegree, Gender)

# create cross-tabulations with two or more variables
df %>% flat_table(SchoolDegree, Gender)

# create marginal tables using "row", "col", or "cell"
df %>% flat_table(SchoolDegree, Gender, margin = "row")

##INSTRUCTIONS:
#1. Create other cross-tabulations by changing the variables

#2 try changing the margin argument to col, row, or cell


# Creating charts in R using ggplot2 package   

# create a simple column chart
df %>% ggplot(aes(EmploymentField)) + 
  geom_bar()

# flip it so that it becomes a bar chart and the labels are easier to read. Plus, add a theme
df %>% ggplot(aes(EmploymentField)) +
  geom_bar() +
  coord_flip() +
  theme_classic()

# Get rid of NA
df %>% filter(EmploymentField!="") %>%
  ggplot(aes(EmploymentField)) +
  geom_bar() +
  coord_flip() +
  theme_classic()

# Create a simple histogram  
df %>% ggplot(aes(x=Age)) + geom_bar()

# make it look pretty
df %>% ggplot(aes(x=Age)) +
  geom_histogram(color = "white") +
  theme_economist() +
  labs(title = "Distribution of Age", subtitle = "in our coding survey") 

# try another theme and change the binning size
df %>% ggplot(aes(x=Age)) +
  geom_histogram(color = "white", binwidth = 10) +
  theme_fivethirtyeight() +
  labs(title = "histogram", subtitle = "my subtitle") 

# INSTRUCTIONS
#1 Change the x variable with another numeric variable (income)
#2 Change the theme
#3 Change the bin size

# Create a density plot instead of a histogram   

# Compare only males and females comparison
df  %>%
  ggplot(aes(x=Age, fill = Gender)) +
  geom_density(alpha = .6) +
  theme_minimal()

## Other examples of charts with the ggplot package    
# Relationship between employment status and job preference  

df %>% flat_table(EmploymentStatus, JobPref) %>% data.frame() %>%
  ggplot(aes(EmploymentStatus, JobPref)) +
  geom_tile(aes(fill = Freq), colour = "white") +
  scale_fill_continuous() +
  coord_fixed(ratio = 1) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))


## Stacked bar chart   
Comparing gender breakdown across ages
```{r warning=FALSE , message=FALSE ,echo=FALSE}
df %>% select(Age, Gender) %>%
  group_by(Age, Gender) %>%
  summarise(count=n()) %>%
  ggplot(aes(Age,count,fill=Gender)) +
  geom_bar(stat='identity', position='fill', color='white') + 
  xlim(c(10,70))

