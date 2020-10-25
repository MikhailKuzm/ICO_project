

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
titlePanel("Map"),
sidebarLayout(
    sidebarPanel(
        selectInput("pal_but", label = h4("Раскрасить страны по:"),
            choices = list("Регулирование Майнинга" = 1,
                         "Применение законодательства о цб" = 2, 
                         "Использование криптовалют в потребительских целях" = 3), 
                 selected = 1)),
    
    mainPanel(
        leafletOutput("mymap")
            )
    )
)


        
