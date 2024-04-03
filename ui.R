library(shiny)
library(tidyverse)


dataset <- read_csv('final_dataset.csv', na = c("", "NA", "0", NaN))

# Define UI
ui <- fluidPage(
  titlePanel("Airbnb Analysis in Texas"),
  sidebarLayout(
    sidebarPanel(
      selectInput("zone", "Choose a neighborhood:",
                  choices = unique(dataset$neighbourhood)),
      sliderInput("price_range", "Price Range:",
                  min = 0, max = max(dataset$price, na.rm = TRUE), value = c(0, 200)),
      sliderInput("availability_range", "Availability (in days) Range:",
                  min = 0, max = max(dataset$availability_365, na.rm = TRUE), value = c(0, 365)),
      selectInput("room_type", "Select Room Type:",
                  choices = unique(dataset$room_type)),
      selectInput("property_type", "Select Property Type:",
                  choices = unique(dataset$property_type)),
      selectInput("accommodates", "Select Accommodation Capacity:",
                  choices = c("Any" = "", 1:10)),
      radioButtons("instant_bookable", "Instant Bookable:",
                   choices = c("Any" = "", "Yes" = "t", "No" = "f"), inline = TRUE)
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("room_type", width = "100%", height = "300px")),
        column(6, plotOutput("price_histogram", width = "100%", height = "300px"))
      ),
      fluidRow(
        column(6, plotOutput("price_reviews_scatter", width = "100%", height = "300px")),
        column(6, plotOutput("price_vs_availability", width = "100%", height = "300px"))
      ),
      fluidRow(
        column(6, plotOutput("property_type_distribution", width = "100%", height = "300px")),
        column(6, plotOutput("accommodates_distribution", width = "100%", height = "300px"))
      ),
      fluidRow(
        column(12, plotOutput("instant_bookable_price_scatter", width = "100%", height = "300px"))
      )
    )
  )
)

