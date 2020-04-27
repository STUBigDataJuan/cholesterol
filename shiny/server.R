function(input, output, session) {
  
  output$riskGender <- renderPlotly({
    #### Visualizing heart disease risk by gender
    # filtering risk
    demo_trigly_risk_gender <- demo_trigly %>%
      filter(RISK %in% input$risk) %>% # setting fixed value, shiny app will use input select
      group_by(RIAGENDR) %>%
      summarize(count = n())
    
    colors = c("#B80095", "#3008B1")
    
    p <- plot_ly(demo_trigly_risk_gender, labels = ~RIAGENDR, values = ~count, type = 'pie',
                 marker = list(colors = colors))
    p <- p %>% layout(title = 'Heart disease risk by gender',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    p
    
  })
  
  output$genderRace <- renderPlotly({
    #### Visualizing heart disease risk by gender and race
    # filtering risk
    demo_trigly_gender_race <- demo_trigly %>%
      filter(RISK %in% input$risk) # setting fixed value, shiny app will use input select
    
    p <- ggplot(data = demo_trigly_gender_race, mapping = aes(x = RIDRETH1, fill = RIAGENDR)) +
      geom_bar(position = "dodge", mapping = aes(y = ..prop.., group = RIAGENDR)) +
      scale_fill_manual(values = c("#B80095", "#3008B1")) +
      theme(panel.border = element_blank(), 
            panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            axis.text.x = element_text(angle = 25, hjust = 1)
      ) +
      labs(title = "Heart disease risk by gender and race",
           subtitle = "Risk based on LDL level",
           x = "Race and Ethnicity",
           y = "Risk percentage %",
           fill = "Gender") 
    # transition_states(RIAGENDR) +
    #     ease_aes('linear')
    #   anim_save("../shiny/www/gganimate02.gif", animate(p))
    p
  })
  
  output$marital <- renderPlotly({
    #### Visualizing heart disease risk by marital status
    # filtering risk
    demo_trigly_marital <- demo_trigly %>%
      filter(DMDMARTL %in% input$maritalStatus) %>%
      group_by(DMDMARTL,RISK) %>%
      summarize(count = n()) %>%
      drop_na()
    
    p <- ggplot(data = demo_trigly_marital, mapping = aes(x = reorder(DMDMARTL,-count), y = count)) +
      geom_col(mapping = aes(fill = RISK)) +
      coord_flip() +
      scale_fill_manual(values = c("#FF3500", "#FF7D05", "#FFC300")) +
      theme(panel.border = element_blank(), 
            panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            axis.text.x = element_text(angle = 0, hjust = 1)
      ) +
      labs(title = "Heart disease risk by marital status",
           subtitle = "Risk based on LDL level",
           x = "Marital status",
           y = "Total patients",
           fill = "Risk level")
    # transition_reveal(count) +
    #     ease_aes('linear')
    #   anim_save("../shiny/www/gganimate01.gif", animate(p))
    p
  })
  
  output$education <- renderPlotly({
    #### Visualizing Heart disease risk by education level
    demo_trigly_education <- demo_trigly %>%
      filter(DMDHREDU <= 5)
    
    p <- ggplot(data = demo_trigly_education, mapping = aes(x = DMDHREDU, y = LBDLDL)) +
      geom_point(color = "#FFC300", alpha = 0.4) +
      geom_smooth(size = 1.1, method = "loess", se = FALSE) +
      scale_x_log10() +
      theme(strip.background = element_rect(
        fill="#FF7D05", size=1.5, linetype="solid"
      ),panel.border = element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(),
      axis.text.x = element_text(angle = 0, hjust = 1)
      )+
      facet_wrap(~RISK, ncol = 3) +
      labs(x = "Education Level (1 - lowest, 5 - highest)",
           y = "LDL Levels",
           title = "Heart disease risk by education level",
           subtitle = "Risk based on LDL level")
    p
  })
  
  output$income <- renderPlotly({
    #### Visualizing Heart disease risk by Annual household income
    p <- ggplot(data = demo_trigly, mapping = aes(x = INDHHIN2, fill = RISK)) +
      geom_density(alpha = 0.7) +
      scale_x_log10() +
      scale_fill_manual(values = c("#FF3500", "#FFC300", "#FF7D05")) +
      labs(x = "Annual Household Income (1 - lowest, 100 - highest)",
           y = "Risk score",
           title = "Heart disease risk by annual household income",
           subtitle = "Risk based on LDL level")
    p
  })
  
  output$region <- renderPlotly({
    #### Visualizing National Center for Health Statistics region
    # filtering Maryland region, where National Center for Health Statistics is located at
    states <- map_data("state")
    
    nchs_region <- states %>%
      filter(region == 'maryland')
    
    p <- ggplot() +
      geom_polygon(data = states, aes(x=long,y=lat, group = group, fill=region),color="white", alpha = 0.3) +
      geom_polygon(data = nchs_region, aes(x=long,y=lat, group = group, fill=region),color="white") +
      labs(title = "National Center for Health Statistics - Maryland") +
      theme_void()
    guides(fill = FALSE)
    p
  })
  
  output$location <- renderLeaflet({
    #### Visualizing National Center for Health Statistics location
    # National Center for Health Statistics coordinates 
    m <- leaflet() %>%
      addTiles() %>%
      addMarkers(lng=-76.951720,
                 lat=38.969450,
                 label="National Center for Health Statistics",
                 labelOptions = labelOptions(noHide=T))
    m
  })
}



