
ui <- dashboardPage(skin = "green",
    dashboardHeader(title = "Map"),
    dashboardSidebar(
        width = 240,
        sidebarMenu(
            menuItem("Map", tabName = "dashboard", icon = icon("th"),
                     menuSubItem(icon = NULL,
                                 selectInput("pal_but", label = h5("Раскрасить страны по:"),
                                 choices = list("Регулирование Майнинга" = 1,
                                                "Применение законодательства о цб" = 2, 
                                                "Использование криптовалют в потребительских целях" = 3), 
                                 selected = 1))
        ))),
    dashboardBody(
tabItem(tabName = "dashboard",
         fluidRow(
        box(leafletOutput("mymap", height=380),
            width = 12,
            height = "400px"),
        box(uiOutput("text"),
            width = 12)
            )
    )
)
)


        
