
packages <- c("formattable", "sjmisc", "knitr", "ggthemes", "corrr", "psych", "tidyverse")

new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# activate the packages you have already installed using the library() function
library(sjmisc) # useful for data wrangling work like recoding, grouping variables, summarizing data
#library(plotly) # an R package for creating interactive web-based graphs
#library(prettydoc) # useful for making prettier Rmarkdown documents or reports
library(knitr) # for creating reports in Word, pdf, html
library(ggthemes) # to add themes to ggplots 
library(corrr) # to create correlation matrices and plots
library(tidyverse) #includes a set of packages that work well together (ggplot, tidyr, dplyr, and others)
library(psych) # for summarizing data
library(formattable) # to publish and format tables using rmarkdown

# 1. Create a folder on your desktop and call it “merl-r”
# 2. Download all the files into your folder (http://bit.ly/merl-r)
# 3. Tell R where your working directory is so that it knows where to find your csv file.
# Replace the file path below with your file path.

## (switch back slashes to forward slashes "/" . The file path must be between parentheses)
setwd("C:/Users/cguedenet/Documents/MERL Tech 2018/MERL Tech")

# import
df <- read.csv("2016.coders.survey.csv")

# get a quick overview of your dataset, including number of variables (columns) and observations (rows)
glimpse(df)


#INTRODUCTION TO CONSOLE

# This is where you execute R ccommands. R interprets what you write and prints the results
1 + 1

# creating variables for later use. Use the less sign followed by a dash to create a variable

width <- 8
length <- 5
area <- width * length
