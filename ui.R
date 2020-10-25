
ui <- dashboardPage(
    dashboardHeader(title = "Map"),
    dashboardSidebar(
        width = 250,
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
        box(leafletOutput("mymap"),
            width = 12,
            height = "380px")
            )
    )
)
)


        
