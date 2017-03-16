shinyUI(fluidPage(
    fluidRow(
        column(width=3, align="left",
               wellPanel(
                   HTML("Enter an R package to see the # of downloads over time from the RStudio CRAN Mirror.",
                        "You can enter multiple packages to compare them"),
                   selectInput("package", 
                               label = "Packages:",
                               selected = "lexRankr", # initialize the graph with a random package
                               choices = package_names,
                               multiple = TRUE),      
                   radioButtons("transformation", 
                                "Data Transformation:",
                                c("Daily" = "daily", "Weekly" = "weekly", "Cumulative" = "cumulative")),
                   HTML("Created using the <a href='https://github.com/metacran/cranlogs'>cranlogs</a> package.",
                        "This app is not affiliated with RStudio or CRAN.",
                        "You can find the code for the app <a href='https://github.com/dgrtwo/cranview'>here</a>,",
                        "or read more about it <a href='http://varianceexplained.org/r/cran-view/'>here</a>.")
               )
               )
    ),
    fluidRow(
        column(width=10, offset=1, align="center",
               plotlyOutput("downloadsPlotly")
               )
    )
  )
)
