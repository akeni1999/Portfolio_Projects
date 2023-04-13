---
title: "Data Analysis Project"
---


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, 
                      message = FALSE, 
                      warning = FALSE,
                      comment = "")
```


# Student Information

**Aditya Keni**: 
**G01328544**:


# Introduction

This semester we will be working with a dataset of all domestic outbound flights from Dulles International Airport in 2016.

Airports depend on accurate flight departure and arrival estimates to maintain operations, profitability, customer satisfaction, and compliance with state and federal laws. Flight performance, including departure and arrival delays must be monitored, submitted to the Federal Aviation Agency (FAA) on a regular basis, and minimized to maintain airport operations. **The FAA considered a flight to be delayed if it has an arrival delay of at least 15 minutes**.

The executives at Dulles International Airport have hired you as a Data Science consultant to perform an exploratory data analysis on all domestic flights from 2016 and produce an executive summary of your key insights and recommendations to the executive team.

Before you begin, take a moment to read through the following airline flight terminology to familiarize yourself with the industry: [Airline Flight Terms](https://www.myairlineflight.com)



## Dulles Flights Data

The `flights_df` data frame is loaded below and consists of 33,433 flights from IAD (Dulles International) in 2016. The rows in this data frame represent a single flight with all of the associated features that are displayed in the table below.

**Note**: If you have not installed the `tidyverse` package, please do so by going to the `Packages` tab in the lower right section of RStudio, select the `Install` button and type `tidyverse` into the prompt. If you cannot load the data, then try downloading the latest version of R (at least 4.0). The `readRDS()` function has different behavior in older versions of `R` and may cause loading issues.



```{r}

library(tidyverse)

flights_df <- readRDS(url('https://gmubusinessanalytics.netlify.app/data/dulles_flights.rds'))

```


### Raw Data

```{r}

flights_df

```


# Exploratory Data Analysis


Executives at this company have hired you as a data science consultant to evaluate their flight data and make recommendations on flight operations and strategies for minimizing flight delays.

You must think of **at least 8 relevant questions** that will provide evidence for your recommendations.

The goal of your analysis should be discovering which variables drive the differences between flights that are early/on-time vs. flights that are delayed.

Some of the many questions you can explore include:

-   Are flight delays affected by taxi-out time? Do certain airlines or time of 
    year lead to greater taxi out times (i.e. traffic jams on the runways)?

-   Are certain times of the day or year problematic?

-   Are certain destination or airlines prone to delays?


You must answer each question and provide supporting data summaries with either a summary data frame (using `dplyr`/`tidyr`) or a plot (using `ggplot`) or both.

In total, you must have a minimum of 5 plots and 4 summary data frames for the exploratory data analysis section. Among the plots you produce, you must have at least 4 different types (ex. box plot, bar chart,
histogram, heat map, etc...)

Each question must be answered with supporting evidence from your tables and plots.


```{r}

## Filtering the Data

arrival_delay_df <- flights_df %>% filter( arrival_delay >= 15)
arrival_delay_df

```

## Question 1

**Question**:
Which Destination Airport has the most number of arrival delay for the flights from Dulles Airport ?

**Answer**:
The destination airports which has the most number of arrival delay for the flights from Dulles Airport is found to be Los Angeles and San Francisco. Los Angeles had maximum around 730 flights that got delayed with an average arrival delay of 54.97 minutes. San Francisco has second highest 709 number of  flights which got delayed with average arrival delay of 62.72 minutes. Denver Airport has next highest of 449 flights getting delayed with 64.46 minutes of average arrival delay which is less as compared to the other two airports.

To add additional R code chunks for your work, select `Insert` then `R` from the top of this notebook file.

```{r}

flights <- arrival_delay_df %>% group_by(dest_airport_name) %>% 
                  summarise(n_arrival_delay = n(), avg_arrival_delay = mean(arrival_delay))

flights %>% arrange(desc(n_arrival_delay))
```

## Question 2

**Question**:
Which Airline had the most number of Arrival Delays ?

**Answer**:
United Airlines is found to have the highest that is around 3115 number of flights causing arrival delays. It has an average arrival delay of 69.64 minutes. The second maximum arrival delays are caused by American Airlines which is 538 flights respectively with mean arrival delay of 74.13 minutes. It is quite less as compared to the number of flights getting delayed by United Airlines but the average arrival delay is found to be more.

```{r}
flights <- arrival_delay_df %>% group_by(airline) %>% 
                  summarise(n_arrival_delay = n(),
                            avg_arrival_delay = mean(arrival_delay))

flights %>% arrange(desc(n_arrival_delay))

```

## Question 3

**Question**:
Are certain month of the year problematic ?

**Answer**:
It is observed that June and July are the most problematic months of the year. Because the July month is found to have the highest number of flights experiencing the arrival delays. It had nearly 748 flights witnessing arrival delay of average 84.187 minutes.June month has the second highest number of flights experiencing arrival delays. About 682 flights caused arrival delay of average 88.37 minutes.June month has more average arrival delay as compared to July.
```{r}
flights <- arrival_delay_df %>% group_by(month) %>% 
                  summarise(n_flights = n(),
                  avg_arrival_delay = mean(arrival_delay))

flights %>% arrange(desc(n_flights))

ggplot(arrival_delay_df, aes(x = month, y = arrival_delay)) +
        geom_boxplot() +  theme(axis.text.x = element_text(angle = 90))
```

## Question 4

**Question**:
Does the flight distance affect the arrival delay ?

**Answer**:
The average arrival delays are found to be between 0 and 250 minutes and majority of the flights have a distance less than 2500km. But there is no significant relation between the distance and arrival delay.

```{r}

library(ggplot2)
ggplot(arrival_delay_df, aes(x = arrival_delay, y = distance)) +
    geom_point()

```

## Question 5

**Question**:
Which Day of the week has the most arrival delay ?

**Answer**:
Thursday has experienced the most number of arrival delay with a count of 893 arrival delays. After Thursday other two days that experienced more amount of delay are Monday and Friday. On Saturday it has the least number of arrival delay but the average delay that takes place is the highest than the other days.

```{r}

flights <- arrival_delay_df %>% group_by(weekday) %>% 
                  summarise(n_arrival_delay = n(),
                            avg_arrival_delay = mean(arrival_delay))

flights %>% arrange(desc(n_arrival_delay))

ggplot(flights, aes(x = weekday, y = n_arrival_delay)) + geom_col() +
  geom_bar(stat="identity", fill=" purple ") +
  geom_text(aes(label= n_arrival_delay), vjust=1.4, color="black", size=3.8)

```

## Question 6

**Question**:
Which Airport Region had the most number of arrival delay from Dulles Airport ?

**Answer**:
The Destination airports in the West Region experience the maximum number of flights with a count of 2420 flights getting delayed at arrival. Also, South Region is second maximum with 1104 flights getting delayed at arrival. South region has more average arrival delay as compared to West region. 

```{r}

flights <- arrival_delay_df %>% group_by(dest_airport_region) %>% 
                  summarise(n_arrival_delay = n(),
                            avg_arrival_delay = mean(arrival_delay))

flights %>% arrange(desc(n_arrival_delay))

ggplot(flights, aes(x = dest_airport_region, y = n_arrival_delay)) + geom_col() + geom_bar(stat="identity", fill="lightblue") +
  geom_text(aes(label= n_arrival_delay), vjust=1.4, color="black", size=3.8)

```

## Question 7

**Question**:
Is arrival delay affected by airlines departure delay ?

**Answer**:
Yes, from the analysis below we can observe that arrival delay is directly proportional to departure delay because when departure delay increases arrival delay too increases.

```{r}

ggplot(arrival_delay_df, aes(x = dep_delay, y = arrival_delay)) + geom_line() + expand_limits( y = 0)

```

## Question 8

**Question**:

What is the distribution of departure time for the flights ?

**Answer**:
From the following analysis it can be inferred that maximum of 7500 flights at Dulles Airport are scheduled to departure between 17:00 to 18:00. So these might lead to traffic at runways causing departure delays. 

```{r}

ggplot(flights_df, aes( x = dep_time)) +
  geom_histogram( bins = 20, fill = "orange")

```

# Summary of Results

Write an executive summary of your overall findings and recommendations to the executives at Dulles Airport. Think of this section as your closing remarks of a presentation, where you summarize your key findings and make recommendations on flight operations and strategies for minimizing flight delays.

Your executive summary must be written in a [professional tone](https://www.universalclass.com/articles/writing/business-writing/appropriate-tone-in-business-communications.htm), with minimal grammatical errors, and should include the following
sections:

1.  An introduction where you explain the business problem and goals of your data analysis

    -   What problem(s) is this company trying to solve? Why are they important
        to their future success?

    -   What was the goal of your analysis? What questions were you 
        trying to answer and why do they matter?


2.  Highlights and key findings from your Exploratory Data Analysis section

    -   What were the interesting findings from your analysis and
        **why are they important for the business**?

    -   This section is meant to **establish the need for your recommendations** 
        in the following section
        

3.  Your recommendations to the company

    -   Each recommendation must be supported by your data analysis results

    -   You must clearly explain **why** you are making each recommendation and which results 
        from your data analysis support this recommendation

    -   You must also describe the potential business impact of your recommendation:

        -   Why is this a good recommendation?

        -   What benefits will the business achieve?
      
## Executive Summary

Please write your executive summary below. If you prefer, you can type your summary in a text editor, such as Microsoft Word, and paste your final text here.

1. Introduction:

The business problem is to evaluate the flight data of all domestic outbound flights from Dulles Airport and make recommendations on flight operations and strategies for minimizing flight delays.

The goal of my analysis is to discover which variables drive the differences between flights that are early/on-time vs flights that are delayed.

2. Highlights and Key findings:

From the analysis, it is seen that most of the flights at Dulles Airport are scheduled to depart between 17:00 to 18:00. So this might be the reason causing a traffic jam at runways leading to the departure delays. Also, it is found that Los Angeles and San Francisco are the two destination airports that have the highest flights witnessing arrival delays. In terms of airlines, it is inferred that United Airlines is the highest among all other airlines in causing arrival delays. Analysis based on the regions concluded that the airports in the West region are prone to more arrival delays, followed by the South region.

It is also seen that the most problematic months of the year were found to be June and July, where July month has caused the most arrival flight delays whereas June month is found to be the second-highest to witness arrival delays. Summer Vacation may seem to be the influencing factor for causing delays in June and July. Moreover, most arrival flight delay takes place on Thursday and Monday. This might be because of the weekend as lot of passengers might be traveling for the weekend and returning from the weekend and due to the air traffic, there might be a lot of arrival delays.

Also, it is seen that distance has nothing to contribute to the delays caused by the flights. We can also observe that arrival delay is directly proportional to departure delay so when departure delay increases arrival delay too increases.

3. Recommendations:

I recommend the company to evenly schedule the departure of flights throughout the day rather than scheduling more flights at a specific time. I feel this is a good recommendation because it will reduce the traffic jam on runways which would further decrease the departure delays. This can be seen in the data analysis performed for Question 8 where the distribution of departure time of the flights is analyzed.

I recommend the company to improve the functionality and services provided by United airlines. I feel this is a good recommendation because this would reduce the arrival delays caused by United airlines and it would increase the customer satisfaction. This can be seen in the data analysis performed for Question 2 where airlines and average arrival delay is analyzed.

I recommend the company to improve the operations and maintenance at Los Angeles and San Francisco airports. I feel this is a good recommendation because this would reduce the arrival delays of the flights from Dulles airport as this airports have the highest number of flights experiencing the delays. This recommendation is suggested from the analysis done in question 1.












