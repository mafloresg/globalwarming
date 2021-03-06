<style>
.small-code pre code {
  font-size: 70%;
}
</style>

Global Warming Shiny App
========================================================
author: Maria A. Flores
date: 9 June 2016
autosize: false

Introduction
========================================================
The Global Warming Shiny App is intended to explore the evolution of 
the land temperature anomalies in six different continental regions. Additionally, it shows a prediction for the next 10 years (2016-2026).

The data is from the NOAA databases <http://www.ncdc.noaa.gov/cag/>. There is a data set for each one of the six continental regions. 

Each data set have the land temperature anomalies in a time series with two columns: the year and the anomaly value in Celsius degrees.

Before building the app
========================================================
class: small-size
<div class="small-size" style="font-size:80%;">
For each continental region five different regression models were tested: lineal, orthogonal polynomial of 2nd and 3rd, non-orthogonal polynomial of 4th degree, and exponential.
<br><br>
In order to choose the model, <i>anova</i> and <i>AIC</i> functions were used, selecting the best model for each region. Finally, the residuals vs fitted values are plotted, to discard hidden patterns.
<div class="small-size" style="font-size:50%;">The next plots are made executing R code, but I don't show it because of lack of space. You can see the code in the .Rpres original file <https://github.com/mafloresg/globalwarming>
***
<br>
![plot of chunk unnamed-chunk-1](globalWarmingApp-figure/unnamed-chunk-1-1.png)

Before building the app
========================================================
class: small-size

Selected models:
<ul>
<li>Africa: polynomial 4th degree</li>
<li>Asia: polynomial 4th degree</li>
<li>Europe: polynomial 4th degree</li>
<li>North America: polynomial 4th degree</li>
<li>Oceania: polynomial 2nd degree</li>
<li>South America: polynomial 2nd degree</li>
</ul>

Due to the difficult calculation of prediction intervals for exponential models
(_nls_ objects), for Europe and South America was selected the second best model.

The Global Warming App
========================================================
<div class="small-size" style="font-size:50%;">
The ui.R interface was built using the [shinydashboard](http://rstudio.github.io/shinydashboard/index.html) library, with three tabs. 

The selector in the left panel is used to change the continental region in the _Dashboard_ and _Data_ tabs. Changing the region, a reactive sentence in server.R changes the used data set, changing the plot, the fitting, the prediction interval, the data in _Data_ tab and some text outputs.

In _Dashboard_ tab, the plot is using [rCharts](http://rcharts.io/). In the box in the right side there is a slider that allows, by means of reactive sentences in server.R, to choose the year, moving a point in the fitted line and changing the values.

In _Data_ tab there is a table with the data used in the app (original and calculated). The table is built using the [DT](http://rstudio.github.io/DT/) library.

In the _Reference_ tab there is some documentation about using the app.
<br>
![Dashboard tab](tab1.png)
