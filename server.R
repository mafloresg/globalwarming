library(UsingR)
library(nlstools)
library(propagate)
require(rCharts)

shinyServer(  
    function(input, output) {
        output$region <- reactive({input$region})
        
        output$histYear <- reactive({input$histYear})
        
        histYear <- reactive({input$histYear})
        
        tempRegion <- reactive({input$region})
        
        tempData <- reactive({
            switch(input$region,
                   "Africa" = africaTempAnomalies,
                   "Asia" = asiaTempAnomalies,
                   "Europe" = europeTempAnomalies,
                   "North America" = nAmericaTempAnomalies,
                   "Oceania" = oceaniaTempAnomalies,
                   "South America" = sAmericaTempAnomalies
                   )
        })
        
        tempFit <- reactive({
            switch(input$region,
                   "Africa" = lm(Value ~ poly(Year,4), tempData()),
                   "Asia" = lm(Value ~ poly(Year,4), tempData()),
                   "Europe" = lm(Value ~ poly(Year,4), tempData()),
                   "North America" = lm(Value ~ poly(Year,4), tempData()),
                   "Oceania" = lm(Value ~ poly(Year,2, raw=TRUE), tempData()),
                   "South America" = lm(Value ~ poly(Year,2, raw=TRUE), tempData())
            )
        })
        
        output$modelTxt <- reactive({
            switch(input$region,
                   "Africa" = "lm(Value ~ poly(Year,4), africaData)",
                   "Asia" = "lm(Value ~ poly(Year,4), asiaData)",
                   "Europe" = "lm(Value ~ poly(Year,4), europeData)",
                   "North America" = "lm(Value ~ poly(Year,4), nAmericaData)",
                   "Oceania" = "lm(Value ~ poly(Year,2, raw=TRUE), 
                                  oceaniaData)",
                   "South America" = "lm(Value ~ poly(Year,2, raw=TRUE), 
                                  sAmericaData)"
        )})
        
        tempPred <- reactive({
            data.frame(Year=xxx, Prediction=predict(tempFit(), data.frame(Year=xxx)))
        })
        
        tempPredictionInterval <- reactive({
            data.frame(Year=xxx, predict(tempFit(), list(Year = xxx),
                                         interval="prediction"))
        })
        
        tempPImargins <- reactive({
            tempPredictionInterval()[,c(1,3,4)]
        })
        
        output$myPlot <- renderChart({
            p3 <- rPlot(Value ~ Year, type = 'point', data = tempData(),
                        color = "direction",
                        tooltip = "#!function(item){ return 'Year: ' + item.Year + 
                        ' | Anomaly: ' + item.Value + ' ºC'}!#")
            p3$guides(color = list(scale = "#! function(value){
                color_mapping = {1: '#FA8072', 0: '#99ccff'}
                return color_mapping[value];                  
                } !#"))
            p3$layer(x = "Year", y = "Prediction",
                     data = tempPred(), type = 'line', 
                     size = list(const = 3), 
                     color = list(const = 'indigo'))
            p3$layer(x = "Year", y = "Prediction",
                     data = tempPred()[tempPred()$Year == histYear(),], 
                     type = 'point', 
                     size = list(const = 4), 
                     color = list(const = 'indigo'),
                     tooltip = "#!function(item){ return 'Year: ' + item.Year + 
                     ' | Prediction: ' + item.Value + ' ºC'}!#")
            p3$layer(x = "Year", y = "lwr",
                     data = tempPImargins(), type = 'line', 
                     size = list(const = 3), 
                     color = list(const = 'lightgrey'))
            p3$layer(x = "Year", y = "upr",
                     data = tempPImargins(), type = 'line', 
                     size = list(const = 3), 
                     color = list(const = 'lightgrey'))
            p3$guides(y = list(title = "Temperature anomaly (ºC)", 
                               min = floor(min(c(tempData()$Value, 
                                                 tempPred()$Prediction))), 
                               max = ceiling(max(c(tempData()$Value, 
                                                   tempPred()$Prediction)))))
            p3$guides(x = list(title = "Year",
                               min = 1909, max = 2027))
            p3$addParams(width = 700,
                         height = 400,
                         dom = 'myPlot')
            p3$set(legendPosition = "none")
            return(p3)
        })
        
        output$anomaly <- reactive({
            ifelse(input$histYear < 2016,
                   tempData()$Value[tempData()$Year == histYear()],
                   '--')
        })
        
        output$forecast <- reactive({
            round(tempPred()$Prediction[tempPred()$Year == histYear()]
                  ,3)
        })
        
        output$piLwr <- reactive({
            round(tempPredictionInterval()$lwr[tempPredictionInterval()$Year == histYear()]
                  ,3)
        })
        
        output$piUpr <- reactive({
            round(tempPredictionInterval()$upr[tempPredictionInterval()$Year == histYear()]
                  ,3)
        })
        
        dataForTable <- reactive({
            dt <- as.data.frame(
                merge(
                    tempData()[,1:2],
                    tempPredictionInterval(), 
                    by="Year", 
                    all.y=TRUE))
            dt$fit <- round(dt$fit,3)
            dt$lwr <- round(dt$lwr,3)
            dt$upr <- round(dt$upr,3)
            colnames(dt) <- c("Year","Temperature anomaly (ºC)",
                                   "Predicted value", "Prediction interval - lower",
                                   "Prediction interval - upper")
            dt
        })
        
        output$dataTable <- 
            DT::renderDataTable(
                DT::datatable(dataForTable(), 
                              options = list(paging = FALSE),
                              caption = tempRegion())
            )
    }
)