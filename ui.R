library(leaflet)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
titlePanel("Map"),
    
radioButtons("pal_but", label = h4("Раскрасить страны по:"),
            choices = list("Регулирование Майнинга" = 1,
                         "Применение законодательства о цб" = 2, 
                         "Свободное использование криптовалют" = 3), 
                 selected = 1),
    
    
    mainPanel(
        
        leafletOutput("mymap")
            )
    )


        
