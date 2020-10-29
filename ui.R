
ui <- dashboardPage(skin = "green",
    dashboardHeader(title = "Map"),
    dashboardSidebar(
        width = 240,
        sidebarMenu(
            menuItem("Карта", tabName = "dashboard", icon = icon("globe"),
                     menuSubItem(icon = NULL,
                                 selectInput("pal_but", label = h5("Раскрасить страны по:"),
                                 choices = list("Регулирование Майнинга" = 1,
                                                "Применение законодательства о цб" = 2, 
                                                "Использование криптовалют в потребительских целях" = 3), 
                                 selected = 1))
        )
        
        )),
    dashboardBody(useShinyjs(),
tabItem(tabName = "dashboard",
        fluidRow(
        box(leafletOutput("mymap", height=380),
            width = 12,
            height = "400px"),
        fluidPage(align = "center",
        uiOutput("text1")),
        actionButton("button1", label = "Названия цифровых активов", width = '100%',
                     class = "btn-success",block = TRUE, icon = icon("info"),
                     style="color: #fff;"),
        div(id='hello',
        fluidRow(column(4, align="center",
                        uiOutput("text2"), 
                        tags$style(type="text/css", "#text2 { height: 30px; width: 110%;
                                   text-align:center; font-size: 15px;}")
        ),
                column(4, align="center",
                        uiOutput("text3"),
                        tags$style(type="text/css", "#text3 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px; }")
        ),
                column(4, align="center",
                        uiOutput("text4"),
                        tags$style(type="text/css", "#text4 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px;}")
        ))) 
)
)
)
)


        
