
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
    
                                        #### Main Body ####
    dashboardBody(useShinyjs(),
tabItem(tabName = "dashboard",
        fluidRow(
        box(leafletOutput("mymap", height=380),
            width = 12,
            height = "400px")),
        fluidPage(align = "center",
        uiOutput("text1"),
        
                                     #### First button under text ####
        
        actionButton("button1", label = "Названия цифровых активов", width = '100%',
                     class = "btn-success", icon = icon("info"),
                     style="color: #fff;"),
        shinyjs::hidden(
        div(id='first',
        fluidRow(align = "center",
                 column(4, align="center",
                        uiOutput("text2"), 
                        tags$style(type="text/css", "#text2 { height: 30px; width: 100%;
                                   text-align:center; font-size: 15px;}")),
                column(4, align="center",
                        uiOutput("text3"),
                        tags$style(type="text/css", "#text3 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px; }")),
                column(4, align="center",
                        uiOutput("text4"),
                        tags$style(type="text/css", "#text4 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px;}"))))),
        
        
                                         #### Second button ####
        actionButton("button2", label = "Правовой статус", width = '100%',
                     class = "btn-success", icon = icon("edit"),
                     style="color: #fff;"),
        shinyjs::hidden(
        div(id='second',
        fluidRow(column(4, align="center",
                       uiOutput("text5"),
                       tags$style(type="text/css", "#text5 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px;}")),
                column(4, align="center",
                       uiOutput("text6"),
                       tags$style(type="text/css", "#text6 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px;}")),
                column(4, align="center",
                       uiOutput("text7"),
                       tags$style(type="text/css", "#text7 { height: 50px; width: 100%;
                                   text-align:center; font-size: 15px;}")))))
)
)
)
)


        
