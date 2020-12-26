
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
            menuItem("Методология", tabName = "method", icon = icon("globe")
        
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
                title = "",
                width=5,
               withSpinner(plotlyOutput("main_comp", height = 150, width = "100%"),
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
      fluidRow(
        box(
          width = 6,
          title = "Выберите страны для сравнения",
          icon = "fa fa-th",
          collapsible = TRUE,
          background = "teal",
          selectInput("select_com1", label = "", width = 800,
                                choices = list("Германия" = "Германия",
                                               "Китайская Народная Республика" = "Китайская Народная Республика", 
                                               "Эстония" = "Эстония",
                                               "Великобритания" = "Великобритания",
                                               "Швейцария" = "Швейцария"), 
                                selected = "Германия"),
                    selectInput("select_com2", label = "", width = 800,
                      choices = list("Германия" = "Германия",
                                     "Китайская Народная Республика" = "Китайская Народная Республика", 
                                     "Эстония" = "Эстония",
                                     "Великобритания" = "Великобритания",
                                     "Швейцария" = "Швейцария"), 
                      selected = "Эстония")
            ),
          boxPlus(
            title = "Сравнение законодательства",
            collapsible = TRUE,
            status = "teal",
            withSpinner(plotlyOutput("plot1", height = 150),
                        type = 3)
            
)),
        fluidRow(
          boxPlus(
            width = 6,
            title = "Количество ICO",
            collapsible = TRUE,
            status = "teal",
            withSpinner(plotlyOutput("plot2", height = 240, width = "100%"),
                        type = 3)
),

                            #### Circle bar  box####
          boxPlus(
            width = 6,
            title = "Изменение законов и кол. ICO",
            collapsible = TRUE,
            status = "teal",
            enable_sidebar = TRUE,
            sidebar_width = 75,
            sidebar_start_open = FALSE,
            sidebar_content = tagList(selectizeInput("circle_sel1", label = "", 
                                          choices = list("Германия" = "Германия",
                                                         "Китайская Народная Республика" = "Китайская Народная Республика", 
                                                         "Эстония" = "Эстония",
                                                         "Великобритания" = "Великобритания",
                                                         "Швейцария" = "Швейцария",
                                                         "Япония" = "Япония"), 
                                          options = list(placeholder = 'Выберите страну',
                                            onInitialize = I('function() { this.setValue(""); }'))),
          
                         selectizeInput("circle_sel2", label = "", 
                        choices = list("Германия" = "Германия",
                                       "Китайская Народная Республика" = "Китайская Народная Республика", 
                                       "Эстония" = "Эстония",
                                       "Великобритания" = "Великобритания",
                                       "Швейцария" = "Швейцария",
                                       "Япония"= "Япония"),
                        options = list( placeholder = 'Выберите страну',
                          onInitialize = I('function() { this.setValue(""); }')))),
            withSpinner(plotOutput("plot3", height = 250, width = "100%"),
                        type = 3)
          )),
                            #### Network comparison ####
boxPlus(
  width = 12,
  title = "Сеть соответствия законодательств",
  collapsible = TRUE,
  status = "teal",
  enable_sidebar = TRUE,
  sidebar_width = 35,
  sidebar_start_open = FALSE,
  sidebar_content = tagList(checkboxGroupInput("network_1", label = "Выберите страны для графика", 
                                           choices = list("Германия" = "Германия",
                                                          "Китайская Народная Республика" = "Китайская Народная Республика", 
                                                          "Эстония" = "Эстония",
                                                          "Великобритания" = "Великобритания",
                                                          "Швейцария" = "Швейцария",
                                                          "Япония" = "Япония",
                                                          "Россия" = "Россия",
                                                          "Франция" = "Франция",
                                                          "Украина" = "Украина"
                                                          ), 
                                           selected = c("Германия","Китайская Народная Республика",
                                                        "Эстония", "Великобритания",
                                                        "Россия", "Украина"))),
  withSpinner(plotOutput("plot_network",width = "100%"), type = 3)),

                    #       ### accordion box ####

  # FIRST COLUMN
boxPlus(width = 6, title = textOutput("comp_t"),
        enable_dropdown = TRUE,
        dropdown_icon = "wrench",
        dropdown_menu = dropdownItemList(
          dropdownItem(name = "item 2"),
          dropdownDivider(),
          dropdownItem(url = "#", name = "item 3")
        ),
        enable_label = TRUE,
        label_text = 2,
        label_status = "danger",
        collapsible = TRUE, status = "teal", 
    actionButton("accord_1", label = "Определения", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff; background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 15px;"),
    shinyjs::hidden(
      div(id='acc1',  
          fluidRow(align = "center",
          column(6, 
                 uiOutput("acct_1"),
                 tags$style(type="text/css", "#acct_1 { height: 80px; 
                                     width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_2", label = "Свободный оборот криптовалют", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff; background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 15px;"),
    shinyjs::hidden(
      div(id='acc2',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct_2"),
                          tags$style(type="text/css", "#acct_2 { height: 20px; 
                                     width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_3", label = "Применимое право установлено", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center; 
                     font-size: 14px;"),
    shinyjs::hidden(
      div(id='acc3',  
          fluidRow(align = "center",
          column(6, 
                 uiOutput("acct_3"),
                 tags$style(type="text/css", "#acct_3 { height: 20px; 
                                         width: 340px;
                                        text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_5", label = "Экстерриториальное прим. (утилити токены)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc5',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct_5"),
                          tags$style(type="text/css", "#acct_5 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_6", label = "Экстерриториальное прим. (токены активы)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc6',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct_6"),
                          tags$style(type="text/css", "#acct_6 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_7", label = "Экстерриториальное прим. (криптобиржи)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc7',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct_7"),
                          tags$style(type="text/css", "#acct_7 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord_8", label = "Соглашение о прим. праве (утилити)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc8',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct_8"),
                          tags$style(type="text/css", "#acct_8 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}")))))),


# SECOND COLUMN
boxPlus(width = 6, title = textOutput("comp_t2"),
        enable_label = TRUE,
        label_text = 1,
        label_status = "danger",
        collapsible = TRUE, status = "teal",
    actionButton("accord2_1", label = "Определения", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff; background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 15px;"),
    shinyjs::hidden(
      div(id='acc21',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_1"),
                          tags$style(type="text/css", "#acct2_1 { height: 80px; 
                                     width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_2", label = "Свободный оборот криптовалют", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff; background-color:#39CCCC;
                     text-align:center; float:center;
                     font-size: 15px;"),
    shinyjs::hidden(
      div(id='acc22',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_2"),
                          tags$style(type="text/css", "#acct2_2 { height: 20px; 
                                     width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_3", label = "Применимое право установлено", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center; 
                     font-size: 14px;"),
    shinyjs::hidden(
      div(id='acc23',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_3"),
                          tags$style(type="text/css", "#acct2_3 { height: 20px; 
                                         width: 340px;
                                        text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_5", label = "Экстерриториальное прим. (утилити токены)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc25',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_5"),
                          tags$style(type="text/css", "#acct2_5 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_6", label = "Экстерриториальное прим. (токены активы)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc26',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_6"),
                          tags$style(type="text/css", "#acct2_6 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_7", label = "Экстерриториальное прим. (криптобиржи)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc27',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_7"),
                          tags$style(type="text/css", "#acct2_7 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))),
    
    actionButton("accord2_8", label = "Соглашение о прим. праве (утилити)", 
                 width = '100%',
                 class = "btn-success", 
                 style="color: #fff;background-color:#39CCCC;
                     text-align:center; float:center"),
    shinyjs::hidden(
      div(id='acc28',  
          fluidRow(align = "center",
                   column(6, 
                          uiOutput("acct2_8"),
                          tags$style(type="text/css", "#acct2_8 { height: 20px; 
                                   width: 340px;
                                   text-align:center; font-size: 15px;}"))))))),
      
                         #### Methodology ####
       tabItem(tabName = "method",
               boxPlus())




)
)
)




















