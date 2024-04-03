library(ggplot2)
library(scales)
# Define server
server <- function(input, output) {
  
 
  filtered_data <- reactive({
    dataset %>%
      filter(neighbourhood == input$zone,
             price >= input$price_range[1] & price<= input$price_range[2],
             availability_365 >= input$availability_range[1] & availability_365 <= input$availability_range[2])
  })
  
  
  
  # Create room type plot
  output$room_type <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = room_type, fill = room_type)) +
      geom_bar() +
      labs(title = "Room Type Distribution") +
      theme_minimal() +  # Apply a minimal theme
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      theme(panel.grid = element_blank())
  })
  
 
  
  # Create price vs. number of reviews scatter plot
  output$price_reviews_scatter <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = price, y = number_of_reviews)) +
      geom_point(color = "orangered") +  
      labs(title = "Price vs. Number of Reviews") +
      theme_minimal() +
      theme(panel.grid = element_blank())
  })
  
  # Scatter plot of Price vs. Availability
  output$price_vs_availability <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = price, y = availability_365)) +
      geom_point(color = "mediumblue") +  
      labs(title = "Price vs. Availability") +
      theme_minimal()+
      theme(panel.grid = element_blank())
  })
  
  # Create property type distribution plot
  output$property_type_distribution <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = property_type, fill = property_type)) +
      geom_bar() +
      labs(title = "Property Type Distribution") +
      theme_minimal() + 
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      theme(panel.grid = element_blank())
  })
  
  # Create accommodation capacity distribution plot
  output$accommodates_distribution <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = factor(accommodates))) +
      geom_bar(fill = "tan1") + 
      labs(title = "Accommodation Capacity Distribution") +
      theme_minimal()+
      theme(panel.grid = element_blank())
  })
  
  # Create instant bookable vs. price scatter plot
  output$instant_bookable_price_scatter <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(x = instant_bookable, y = price, fill = instant_bookable)) +
      geom_boxplot() +
      labs(title = "Instant Bookable vs. Price") +
      theme_minimal()  +
      theme(panel.grid = element_blank())
  })
}

shinyApp(ui = ui, server = server)
