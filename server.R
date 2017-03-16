shinyServer(function(input, output) {
  downloads <- reactive({
      packages <- input$package
      cran_downloads0(package = packages, 
                      from    = get_initial_release_date(packages), 
                      to      = Sys.Date()-1) %>% 
          mutate(year=lubridate::year(date)) %>% 
          mutate(month=lubridate::month(date)) %>%
          mutate(week=lubridate::week(date)) %>%
          mutate(day=lubridate::day(date)) %>% 
          as_data_frame()
  })
  
  output$downloadsPlotly <- renderPlotly({
      if (input$transformation=="weekly") {
          d <- downloads() %>% 
              group_by(package, year, week) %>% 
              summarise(count=sum(count),
                        date=min(date)) %>% 
              ungroup() %>% 
              group_by(package)
      } else if (input$transformation=="cumulative") {
          d <- downloads() %>%
              group_by(package) %>%
              mutate(count=cumsum(count))
      } else {
          d <- downloads()
      }
      
      plot_ly(d,
              x     = ~date,
              y     = ~count,
              color = ~package,
              type  = "scatter",
              mode  = "lines") %>% 
          layout(xaxis=list(title="Date"),
                 yaxis=list(title="Download Count"))
  })

})
