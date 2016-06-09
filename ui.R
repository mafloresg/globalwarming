library(shinydashboard)
require(rCharts)
options(RCHART_LIB = 'polycharts')
require(DT)

sidebar <- dashboardSidebar(
    selectInput("region", label = "Continental region",
                choices = list("Africa", "Asia",
                               "Europe", "North America",
                               "Oceania", "South America"),
                selected = 1),
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Data", tabName = "dataTables", icon = icon("table")),
        menuItem("Reference", tabName = "info", icon = icon("info"))
    )
)


body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "dashboard",
            fluidRow(
                box(
                    title = "Land temperature anomalies",
                    width = 8,
                    h4(textOutput("region"), align = "center"),
                    showOutput("myPlot", "polycharts")
                )
                ,
                box(
                    title = "Prediction",
                    width = 4,
                    sliderInput('histYear', 'Year',
                                value = 1910, min = 1910, max = 2026,
                                step = 1), br(),
                    p(
                        strong("Year: "), 
                        textOutput("histYear", inline=TRUE)
                    ),
                    p(
                        strong("Real anomaly: "), 
                        textOutput("anomaly", inline=TRUE)
                    ),
                    p(
                        strong("Fitting model used: "), 
                        textOutput("modelTxt")
                    ),
                    p(
                        strong("Predicted anomaly: "), 
                        textOutput("forecast", inline=TRUE)
                    ),
                    p(
                        strong("Prediction interval: "), 
                        textOutput("piLwr", inline=TRUE),
                        strong(" / "),
                        textOutput("piUpr", inline=TRUE)
                    )
                )
            )
        ),
        tabItem(
            tabName = "dataTables",
            fluidRow(
                box(
                    title = "Time series for land temperature anomalies",
                    width = 12,
                    DT::dataTableOutput('dataTable')
                )
            )
        ),
        tabItem(
            tabName = "info",
            fluidRow(
                box(
                    title = "Global warming app",
                    width = 12,
                    h4('General information'),
                    p('This ',
                        strong('Global Warming Shiny app'),
                        (' is intended to explore the 
                         evolution of the temperature anomalies in different
                         continental regions.')
                      ),
                    p('Selecting a continental region in the selector
                         located on the left panel you will see:'),
                    tags$ul('- In the ',
                            strong('Dashboard'),
                            (' panel, for the selected region:'),
                         tags$ul('· The time series for the temperature anomalies 
                                from 1910 to 2015 (the blue and red dots; blue means 
                                 a negative value and red a positive one)'),
                         tags$ul('· The fitted curve from 1910 to 2026 (the purple line and point)'),
                         tags$ul('· The prediction interval (the grey line
                                 and point)'),
                         tags$ul('· On the information box located to right of the plot you will find 
                            a slider selector: move the control and you will see the following information
                                 for the selected year:',
                                 tags$ul('. The selected year' ),
                                 tags$ul('· Temperature anomaly in Celsius degrees'),
                                 tags$ul('· The model used for fitting a prediction curve, for the selected continental region'),
                                 tags$ul('· Predicted value in Celsius degrees'),
                                 tags$ul('· Lower and upper levels for the prediction interval, 
                                         in Celsius degrees')
                         )
                        ),
                    tags$ul(
                        '- In the ',
                        strong('Data'),
                        (' panel, all the data used for the selected
                        region:'),
                        tags$ul('· Year'),
                        tags$ul('· Temperature anomaly in Celsius degrees'),
                        tags$ul('· Predicted value in Celsius degrees'),
                        tags$ul('· Lower and upper levels for the prediction interval, 
                                in Celsius degrees')
                    ),
                    tags$ul(
                        '- In the ',
                        strong('Reference'),
                        ' (this) panel: general information
                        about this application and specific notes.'
                    ),
                    tags$br(),
                    h4('Specific notes'),
                    tags$ul('- The data about continental land anomalies
                            is coming from ', 
                            tags$a(href = 'http://www.ncdc.noaa.gov/cag/', 'the NOAA databases')
                            ),
                    tags$ul('- Continental temperature anomalies are with respect to the 
                      1910 to 2000 average.')
                )
            )
        )
    )
)

dashboardPage(
    dashboardHeader(title = "Global warming"),
    sidebar,
    body
)
