# Load libraries
library(shiny)
library(tidyverse)

# Read in data
adult <- read_csv("adult.csv")
# Convert column names to lowercase for convenience 
names(adult) <- tolower(names(adult))

# Define server logic
shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$`task 2`)
  })
  
  # TASK 5: Create logic to plot histogram or boxplot
  output$task3 <- renderPlot({
    if (input$plot_type == "Histogram") {
      ggplot(df_country(), aes_string(x = input$cont_var)) +
        geom_histogram(fill = "#0072B2", bins = 30, color = "white") +
        labs(
          x = input$cont_var,
          y = "Count",
          title = paste("Histogram of", input$cont_var)
        ) +
        facet_wrap(~ prediction)
    } else {
      ggplot(df_country(), aes_string(y = input$cont_var)) +
        geom_boxplot(fill = "#D55E00") +
        coord_flip() +
        labs(
          y = input$cont_var,
          x = "",
          title = paste("Boxplot of", input$cont_var)
        ) +
        facet_wrap(~ prediction)
    }
  })
  
  # TASK 6: Create logic to plot faceted bar chart or stacked bar chart
  output$task4 <- renderPlot({
    p <- ggplot(df_country(), aes_string(x = input$cat_var)) +
      labs(
        x = input$cat_var,
        y = "Count",
        title = paste("Bar Chart of", input$cat_var)
      ) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "bottom")
    
    if (input$stacked) {
      p + geom_bar(aes(fill = prediction), position = "stack")
    } else {
      p + geom_bar(aes(fill = get(input$cat_var)), position = "dodge") +
        facet_wrap(~ prediction)
    }
  })
  
})
