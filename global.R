options(spinner.color="#0275D8", spinner.color.background="#ffffff", spinner.size=2)
library(leaflet)
library(dashboardthemes)
library(devtools)
library(ggplot2)
library(shiny)
library(htmltools)
library(leaflet)
library(data.table)
library(DT)
library(shiny)
library(shinydashboard)
library(tidyr)
library(tibble)
library(igraph)
library(networkD3)
library(tidyverse)
library(lubridate)
library(shinyjs)
library(shinydashboardPlus)
library(shinycssloaders)
library(plotly)
library(highcharter)
library(shinyWidgets )
library(echarts4r)
source("common_table.R")

#css for checkboxinput columns
tweaks <- list(tags$head(tags$style(HTML("
                                 .multicol { 
                                   height: 200px;
                                   -webkit-column-count: 5; /* Chrome, Safari, Opera */ 
                                   -moz-column-count: 5;    /* Firefox */ 
                                   column-count: 5; 
                                   -moz-column-fill: auto;
                                   -column-fill: auto;
                                 } 
                                 ")) 
  ))
