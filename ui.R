
ui <-dashboardPagePlus(
    dashboardHeaderPlus(title = tagList(
                          span(class = "logo-lg", "Меню"), 
                          img(src = "https://image.flaticon.com/icons/svg/204/204074.svg")),
                        enable_rightsidebar = TRUE,
                        rightSidebarIcon = "gears"),
sidebar = dashboardSidebar(
        width = 240,
        sidebarMenu(
            menuItem("Карта", tabName = "map", 
                     icon = icon("glyphicon glyphicon-globe", lib = "glyphicon")
            ),
            menuItem("Сравнение", tabName = "compare", icon = icon("globe")
            ),
            menuItem("Графы", tabName = "graphs", icon = icon("globe")
            ),
            menuItem("Таблица", tabName = "table", icon = icon("globe")
        
        ))),
                                        ### Main Body ###
 dashboardBody(useShinyjs(),
               ### changing theme
               shinyDashboardThemes(
                 theme = "blue_gradient"
               ),
                                          #### Map ####
tabItems(
tabItem(tabName = "map",
        fluidRow(
        gradientBox( title = "Раскрасить страны", 
          icon = "fa fa-paint-brush",
          dropdown_icon = "wrench",
          gradientColor = "teal",
          boxToolSize = "sm",
          width = 7,
          height = 210,
          footer = selectInput("pal_but", label = "", width = "900px",
                                choices = list("Регулирование Майнинга" = 1,
                                               "Применение законодательства о цб" = 2, 
                                               "Свободный оборот криптовалют" = 3), 
                                selected = 1)),
        
        # box with map graph comparison
        boxPlus(collapsible = TRUE, 
            status = "teal",
            title = "Данные по миру",
                width=5,
               withSpinner(echarts4rOutput("main_comp", height = 150, width = "100%"),
                           type = 3))),
        
        fluidRow(
          boxPlus(withSpinner(leafletOutput("mymap", height=380), type = 3),
            width = 12,
            height = "400px")),
        fluidRow(align = "center",
        uiOutput("text1"),
        
                                     #### First button under text ####
        
        actionButton("button1", 
                     label = "Названия цифровых активов", width = '100%',
                     class = "btn-success", icon = icon("info"),
                     style="color: #fff; background-color:#39CCCC;"),
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
                     style="color: #fff;background-color:#39CCCC;"),
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
                                   text-align:center; font-size: 15px;}"))))),

                                            #### Third button ####
        actionButton("button3", label = "Применимое право", width = '100%',
             class = "btn-success", icon = icon("edit"),
             style="color: #fff;background-color:#39CCCC;"),
    
    shinyjs::hidden(
    div(id='third',
        
        box(width = 6,
        actionButton("button3_1", label = "Указание на применимое право", 
                     width = '100%',
                     class = "btn-success", 
                     style="color: #fff; background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 15px;"),
        shinyjs::hidden(
          div(id='third_1',
              column(6, 
                     uiOutput("text8"),
                     tags$style(type="text/css", "#text8 { height: 20px; 
                                    width: 290px;
                                   text-align:center; font-size: 15px;}")))),
        
        actionButton("button3_3", label = "Экстерриториальное прим. (утилити токены)", 
                     width = '100%',
                     class = "btn-success", 
                     style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 14px;"),
        shinyjs::hidden(
          div(id='third_3',
                column(6, 
                       uiOutput("text10"),
                       tags$style(type="text/css", "#text10 { height: 20px; 
                                        width: 290px;
                                        text-align:center; font-size: 15px;}")))),
        
        actionButton("button3_5", label = "Оборот токенов-активов", 
                     width = '100%',
                     class = "btn-success", 
                     style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
        shinyjs::hidden(
          div(id='third_5',
                column(6, 
                       uiOutput("text12"),
                       tags$style(type="text/css", "#text12 { height: 20px; 
                                  width: 290px;
                                   text-align:center; font-size: 15px;}"))))),
        
        box(width = 6, 
        actionButton("button3_2", label = "Выпуск утилити токенов", 
                     width = '100%',
                     class = "btn-success", 
                    style="color: #fff;background-color:#39CCCC;"),
        shinyjs::hidden(
            div(id='third_2',
                column(6, 
                              uiOutput("text9"),
                              tags$style(type="text/css", "#text9 { height: 20px; 
                                                width: 290px;
                                               text-align:center; font-size: 15px;")))),
        
    actionButton("button3_4", label = "Оборот криптовалюты", 
                 width = '100%',
                 class = "btn-success",
                 style="color: #fff;background-color:#39CCCC;
                 text-align:center"),
    shinyjs::hidden(
      div(id='third_4',
          column(6, 
                 uiOutput("text11"),
                 tags$style(type="text/css", "#text11 { height: 20px; 
                                  width: 290px;
                                   text-align:center; font-size: 15px;}")))),
    
    actionButton("button3_6", label = "Экстерриториальное прим. (токены активы)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                 text-align:center;"),
      shinyjs::hidden(
        div(id='third_6',
          column(6, 
                 uiOutput("text13"),
                 tags$style(type="text/css", "#text13 { height: 20px; 
                                  width: 290px;
                                  text-align:center; font-size: 15px;}")))))
    )))
),
                                #### Comparison ####
tabItem(tabName = "compare",
        box(tweaks,
            width  = 12,
            height = 150,
            title = "Выберите страны для анализа", 
            tags$div(align = 'left', 
                     class = 'multicol', 
                     prettyCheckboxGroup(
                       inputId = "compare_c",
                       label = NULL,
                       choices = c("Беларусь" = 'Белоруссия', 
                                   "Великобритания" = 'Великобритания',
                                   "Германия" = 'Германия', 
                                   'Казахстан' = 'Казахстан',
                                   'КНР' = 'Китайская Народная Республика',
                                   'Россия' = 'Россия',
                                   'Украина' = 'Украина',
                                   'Швейцария' = 'Швейцария',
                                   'Эстония' = 'Эстония',
                                   'Япония' = 'Япония'),
                       selected = c("Швейцария", 'Китайская Народная Республика',
                                    'Россия','Германия','Япония', 'Белоруссия'),
                       icon = icon("check-square-o"),
                       animation = "jelly",
                       inline = FALSE, 
                       status = "primary"
                     ))),
        
        
                                 #### Circle bar ####
        fluidRow(
          boxPlus(
            title = "Сравнение законодательства",
            collapsible = TRUE,
            status = "teal",
            withSpinner(echarts4rOutput("plot1", height = 240),
                        type = 3)),
          
                                  #### Time chart ####
          boxPlus(
            width = 6,
            title = "Количество ICO",
            collapsible = TRUE,
            status = "teal",
            withSpinner(plotlyOutput("plot2", height = 240, width = "100%"),
                        type = 3))
          )),
    
                              
        
        
                            
                          #### Network comparison ####
tabItem(tabName = "graphs",  
        box(tweaks,
          width  = 12,
          height = 150,
          title = "Выберите страны для анализа", 
            tags$div(align = 'left', 
                     class = 'multicol', 
                     prettyCheckboxGroup(
                        inputId = "network_1",
                        label = NULL,
          choices = c("Беларусь" = 'Белоруссия', 
                      "Великобритания" = 'Великобритания',
                      "Германия" = 'Германия', 
                      'Казахстан' = 'Казахстан',
                      'КНР' = 'Китайская Народная Республика',
                      'Россия' = 'Россия',
                      'Украина' = 'Украина',
                      'Швейцария' = 'Швейцария',
                      'Эстония' = 'Эстония',
                      'Япония' = 'Япония'),
          selected = c("Швейцария", 'Китайская Народная Республика',
                       'Россия','Германия','Япония', 'Белоруссия'),
          icon = icon("check-square-o"),
          animation = "jelly",
          inline = FALSE, 
          status = "primary"
        ))),
        
        
        
boxPlus(
  width = 12,
  title = "Сеть соответствия законодательств",
  collapsible = TRUE,
  status = "teal",
  enable_sidebar = TRUE,
  sidebar_width = 35,
  sidebar_start_open = FALSE,
  withSpinner(plotOutput("plot_network",width = "100%"), type = 3))
),

                              


                         #### Methodology ####
tabItem(tabName = "table",
        DTOutput('tbl'))



)
)
)






















