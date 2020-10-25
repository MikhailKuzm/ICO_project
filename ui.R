
ui <- dashboardPage(
    dashboardHeader(title = "Map"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Map", tabName = "dashboard", icon = icon("dashboard"))
        )),
    dashboardBody(
tabItem(tabName = "dashboard",
         fluidRow(
              box( selectInput("pal_but", label = h4("Раскрасить страны по:"),
                                choices = list("Регулирование Майнинга" = 1,
                                               "Применение законодательства о цб" = 2, 
                                               "Использование криптовалют в потребительских целях" = 3), 
                                selected = 1)),
        box(leafletOutput("mymap"))
            )
    )
)
)


        
