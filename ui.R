# Load libraries
library(shiny)
library(tidyverse)

# Application Layout
shinyUI(
  fluidPage(
    br(),
    
    # TASK 1: Application title
    titlePanel("Task 1"),
    p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demographic information."),
    
    # TASK 2: Add first fluidRow to select input for country
    fluidRow(
      column(12, 
             wellPanel(
               selectInput("task 2", "task 2", 
                           choices = c("United-States", "Mexico", "Philippines", "Germany", "Canada"),
                           selected = "United-States")
             )
      )
    ),
    
    # TASK 3: Add second fluidRow to control how to plot the continuous variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
               radioButtons("cont_var", "Continuous Variable:",
                            choices = c("age", "hours_per_week"),
                            selected = "age"),
               radioButtons("plot_type", "Chart Type:",
                            choices = c("Histogram", "Boxplot"),
                            selected = "Histogram")
             )
      ),
      column(9, 
             plotOutput("task3")
      )
    ),
    
    # TASK 4: Add third fluidRow to control how to plot the categorical variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart to combine the income levels into one graph."),
               radioButtons("cat_var", "Categorical Variable:",
                            choices = c("education", "workclass", "occupation", "sex", "race"),
                            selected = "education"),
               checkboxInput("stacked", "Stacked Bar Chart", value = FALSE)
             )
      ),
      column(9, 
             plotOutput("task4")
      )
    )
  )
)
