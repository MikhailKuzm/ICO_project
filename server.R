
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
                        #### Define pal function for coloring  map####
pal1 <- reactive({ 
    if (input$pal_but == 1) {
        pal <- colorFactor(palette = c("green", "red"),
                           domain = ico_common$mining_is_regulated,
                           na.color = "#808080")
    }else if (input$pal_but == 2) {
            pal <- colorFactor(palette = c("green", "red"),
                               domain = ico_common$direct_application_of_securities_legislation,
                               na.color = "#808080")
      }else{ 
   pal <- colorFactor(palette = c("green", "red"), 
                      domain = ico_common$payment_for_goods_and_services_in_cryptocurrency,
                      na.color = "#808080")
}
 pal
})
                        #### Make argument for pal() function ####
col_type <- reactive({
  if (input$pal_but == 1){
    x <- ico_common$mining_is_regulated
  } else if (input$pal_but == 2){
      x <- ico_common$direct_application_of_securities_legislation
    }else{
    x <- ico_common$payment_for_goods_and_services_in_cryptocurrency
  }
  x
})
                        #### make comparison graph for map ####
num_gen  <- reactive({ 
  if (input$pal_but == 1){
    x <- "mining_is_regulated"
  } else if (input$pal_but == 2){
    x <- "direct_application_of_securities_legislation"
  }else{
    x <- "payment_for_goods_and_services_in_cryptocurrency"
  }
  # make small table for graph with name and frequncy
  test <- filter (ico_common, !is.na(get(x)))
  num_gen <- data.frame(names = unique(test[,x]),
                        n = as.data.frame(test %>% group_by (get(x)) %>%
                                            summarise(n = n()))[2])
num_gen 
})

output$main_comp <- renderPlotly({
plot_ly(num_gen(), labels = ~names, values = ~n, type="pie", sort = FALSE,
        height = 160,
        textposition = 'inside',
        textinfo = 'percent',
        hoverinfo = 'percent',
        hole = 0.6,
        marker=list(line=list(color="black", width=1))) %>%
    layout(showlegend = TRUE, legend = list(font = list(size = 10))) 
})


                        #### Make interactive labels for map ####
labels <- reactive ({ 
  if (input$pal_but == 1){
  paste ("<p>", ico_common$country, "</p>",
                 "<p>", "Регулирование Майнинга: ",
                 ico_common$mining_is_regulated, "</p>",
                 sep = "")
  } else if (input$pal_but == 2){
      paste ("<p>", ico_common$country, "</p>",
             "<p>", "Применение законодательства о цб: ",
             ico_common$direct_application_of_securities_legislation, "</p>",
             sep = "")
     } else {
       paste ("<p>", ico_common$country, "</p>",
              "<p>", "Использование криптовалют в потребительских целях: ",
              ico_common$payment_for_goods_and_services_in_cryptocurrency, "</p>",
              sep = "")
     }
})

                        #### Draw map ####
    output$mymap <- renderLeaflet({
        leaflet() %>%
        setView(lat=52, lng=34 , zoom=2) %>%
        addTiles(group='Основная')%>%
        addProviderTiles('Stamen.Watercolor',group='Пиратская')%>%
        addProviderTiles('CartoDB.PositronNoLabels',group='Контурная чистая') %>%
        addProviderTiles('Esri.WorldStreetMap',group='Физическая (рельеф)') %>%
        addProviderTiles('Esri.DeLorme',group='Физическая (пиксель)') %>%
        addProviderTiles('Esri.OceanBasemap',group='Морская') %>%
        addProviderTiles('Esri.NatGeoWorldMap',group='Горная') %>%
        addProviderTiles('CartoDB.Positron',group='Контурная с подписями') %>%
        addProviderTiles('CartoDB.PositronNoLabels',group='Контурная чистая') %>%
        addProviderTiles('Stamen.TonerLite', group='Белая') %>%
        
        addLayersControl(
          baseGroups = c('Морская',
                          'Пиратская',
                         'Контурная чистая',
                         'Физическая (рельеф)',
                         'Физическая (пиксель)',
                         'Горная',
                         'Контурная с подписями',
                         'Контурная чистая',
                         "Белая"), 
          options = layersControlOptions(collapsed = TRUE)) %>%
            addPolygons(data = my_shape, 
                        fill = "white",
                        stroke=TRUE, 
                        weight = 0.3,
                        smoothFactor = 0.9,
                        color = 'white',
                        fillOpacity = 0.2,
                        fillColor = pal1()(col_type()),
                        highlight = highlightOptions(
                            weight = 2,
                            color = "red",
                            fillOpacity = 0.8,
                            bringToFront = FALSE),
                        label = lapply(labels(), HTML),
                        labelOptions = labelOptions( 
                          style = list("font-weight" = "normal", padding = "3px 8px"), 
                          textsize = "13px", 
                          direction = "auto"),
                        layerId = ~NAME_RU) %>%
        addLegend("bottomright", pal = pal1(), 
                  values = col_type(), 
                  opacity = 0.2)
    })
    
    
                        #### Make text under map (based on click on map) ####
    observeEvent(input$mymap_shape_click, {
  p <- input$mymap_shape_click
  information1 <- paste("<p>", "<b>", p$id,"</b>","</p>")
  information2 <- paste("<p>", "<b>",'Название утилити токенов',"</b>",br(), 
          ico_common[ico_common$country == p$id, "name_utility"][1], "</p>")

  information3 <- paste("<p>",  "<b>", "Название криптовалют","</b>", br(),
          ico_common[ico_common$country == p$id, "name_cryptocurrency"][1], "</p>")
  
  information4 <- paste("<p>", "<b>", "Название токенов активов","</b>",br(),
          ico_common[ico_common$country == p$id, "name_assets"][1], "</p>")
  
  information5 <- paste("<p>", "<b>", "Утилити токены","</b>",br(),
                        ico_common[ico_common$country == p$id, "legal_status_utility"][1], "</p>")
  
  information6 <- paste("<p>", "<b>", "Криптовалюта","</b>",br(),
                        ico_common[ico_common$country == p$id, "legal_status_cryptocurrency"][1], "</p>")
  
  information7 <- paste("<p>", "<b>", "Токены активы","</b>",br(),
                        ico_common[ico_common$country == p$id, "legal_status_assets"][1], "</p>")
  
  information8 <- paste(ico_applicable[ico_applicable$country == p$id, "clause_of_the_applicable_law"][1])
  
  information9 <- paste(ico_applicable[ico_applicable$country == p$id, "applicable_law_utility_issuance"][1])
  
  information10 <- paste(ico_applicable[ico_applicable$country == p$id, "extraterritorial_appl_utility_turnover"][1])
  
  information11 <- paste(ico_applicable[ico_applicable$country == p$id, "applicable_law_cryptocurrency_turnover"][1])
  
  information12 <- paste(ico_applicable[ico_applicable$country == p$id, "applicable_law_assets_turnover"][1])
  
  information13 <- paste(ico_applicable[ico_applicable$country == p$id, "extraterritorial_appl_assets_issue"][1])
  
  information14 <- paste(ico_applicable[ico_applicable$country == p$id, "applicable_law_exchange"][1])
  
  information15 <- paste(ico_applicable[ico_applicable$country == p$id, "extraterritorial_appl_exchange"][1])
  
  information16 <- paste(ico_applicable[ico_applicable$country == p$id, "possibility_of_an_agreement_utility"][1])
  
  information17 <- paste(ico_applicable[ico_applicable$country == p$id, "possibility_of_an_agreement_assets"][1])
  
  
  
      information1 <- lapply(information1, HTML)               
      information2 <- lapply(information2, HTML)
      information3 <- lapply(information3, HTML)
      information4 <- lapply(information4, HTML)
      information5 <- lapply(information5, HTML)
      information6 <- lapply(information6, HTML)
      information7 <- lapply(information7, HTML)
      information8 <- lapply(information8, HTML)               
      information9 <- lapply(information9, HTML)
      information10 <- lapply(information10, HTML)
      information11 <- lapply(information11, HTML)
      information12 <- lapply(information12, HTML)
      information13 <- lapply(information13, HTML)
      information14 <- lapply(information14, HTML)
      information15 <- lapply(information15, HTML)
      information16 <- lapply(information16, HTML)
      information17 <- lapply(information17, HTML)
      
      
      
   output$text1 <- renderUI({
     information1
         })
   output$text2 <- renderUI({
     information2 
   })
   output$text3 <- renderUI({
     information3 
   })
   output$text4 <- renderUI({
     information4 
   })
   output$text5 <- renderUI({
     information5 
   })
   output$text6 <- renderUI({
     information6 
   })
   output$text7 <- renderUI({
     information7 
   })
   output$text8 <- renderUI({
     information8 
   })
   output$text9 <- renderUI({
     information9 
   })
   output$text10 <- renderUI({
     information10 
   })
   output$text11 <- renderUI({
     information11 
   })
   output$text12 <- renderUI({
     information12 
   })
   output$text13 <- renderUI({
     information13 
   })
   output$text14 <- renderUI({
     information14 
   })
   output$text15 <- renderUI({
     information15 
   })
   output$text16 <- renderUI({
     information16 
   })
   output$text17 <- renderUI({
     information17 
   })
   })
                                
    
                        #### First button for showing text under map ####
    
    observeEvent(input$button1,  {
      toggle("first", animType = "slide", anim = TRUE, time = 0.5)
    })
                        #### Second button for showing text under map ####
    observeEvent(input$button2,  {
      toggle("second", animType = "slide", anim = TRUE, time = 0.5)
    })
    
    observeEvent(input$button3,  {
      toggle("third", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_1,  {
      toggle("third_1", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_2,  {
      toggle("third_2", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_3,  {
      toggle("third_3", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_4,  {
      toggle("third_4", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_5,  {
      toggle("third_5", animType = "slide", anim = TRUE, time = 0.5)
    })
    observeEvent(input$button3_6,  {
      toggle("third_6", animType = "slide", anim = TRUE, time = 0.5)
    })

                        #### comparison of countries features ####           
result_ab <-c()
# 
compar_1 <- reactive({
for (i in c(5:7, 9, 11, 13:16,18:24)){
  ifelse (ico_common[ico_common$country == input$select_com1, i] == ico_common[ico_common$country == input$select_com2, i],
          result_ab <- c(result_ab, "Совпадения"),
          result_ab <- c(result_ab, "Несовпадения "))
}
for (i in c(2:5, 8, 9,11)){
  ifelse (ico_applicable[ico_applicable$country == input$select_com1, i] == ico_applicable[ico_applicable$country == input$select_com2,i],
          result_ab <- c(result_ab, "Совпадения"),
          result_ab <- c(result_ab,"Несовпадения "))
}
                          #### create a table for comparative plot for 2 countries ####
ab_table <- data.frame("letter" = c("Совпадения", "Несовпадения "), "number" = c(length(result_ab[result_ab=="Совпадения"]), length(result_ab[result_ab=="Несовпадения "])))
ab_table
})

output$plot1 <- renderPlotly({
plot_ly(compar_1(), labels = ~letter, values = ~number, type="pie", sort = FALSE,
                            textposition = 'inside',
                            textinfo = 'percent',
                            hoverinfo = 'text',
                            text = ~paste(letter,":", number),
                            hole = 0.6,
                            marker=list(line=list(color="black", width=1))) %>%
  layout(autosize = F, width = 340, height = 160)
})

                        #### make time plot for countries ####
number_ico <- read.csv("number_ico.csv")
time_number <- reactive ({
  time_number <- filter(comcontr, place == input$select_com1 | place == input$select_com2)
  time_number
})

output$plot2 <- renderPlotly({
p <- time_number() %>%
  ggplot(aes(x=value, y=active, text = active, group=place, color=place)) +
  geom_line(size = 1) +
  theme_minimal() +
  theme(legend.position = "bottom", axis.text.x=element_text(angle=30, hjust=1)) +
  scale_x_date(date_breaks = "6 month", date_labels = "%m-%Y", 
               limits = dmy("01-06-2017","01-11-2020")) +
  ylab("")+
  xlab("")

p <- ggplotly(p, tooltip = "text") %>% 
  layout(legend = list(orientation = "h", xanchor = "center", x = 0.5, y = -0.3))
p  
})
                        #### make circle bar plot ####
label_data <- read.csv("circle_bar_t.csv")

label_data1 <- reactive({
  
  l1 <-filter(label_data, group == input$select_com1)
  x = 0
  while (x < 3){
    x = x+1
  l1 <- l1  %>% add_row(group = NA, value= NA,feature = NA, id = 32, hjust = NA,  
                                       angle = NA)  
  }
  l2 <-filter(label_data, group == input$select_com2)
  x = 0
  while (x < 3){
    x = x+1
    l2 <- l2  %>% add_row(group = NA, value= NA,feature = NA, id = 32, hjust = NA,  
                          angle = NA)  
  }
  l3 <-filter(label_data, group == input$circle_sel1)
  x = 0
  while (x < 3){
    x = x+1
    l3 <- l3  %>% add_row(group = NA, value= NA,feature = NA, id = 32, hjust = NA,  
                          angle = NA)  
  }
  l4 <-filter(label_data, group == input$circle_sel2)
  x = 0
  while (x < 3){
    x = x+1
    l4 <- l4  %>% add_row(group = NA, value= NA,feature = NA, id = 32, hjust = NA,  
                          angle = NA)  
  }
  if (nrow(l3) > 5 & nrow(l3) > 5){
    l_fin <- rbind(l1,l2,l3,l4)
  }else{
    if (nrow(l3) > 5){
      l_fin <- rbind(l1,l2,l3)
    }else{
      if (nrow(l4) > 5){
      l_fin <- rbind(l1,l2,l4)
    }else{
      l_fin <- rbind(l1,l2)
    }
        }
  }
  # make a table for circle bar
  l_fin$id <- seq(nrow(l_fin))
  number_of_bar <- nrow(l_fin)
  angle <-  90 - 360 * (l_fin$id-0.5) /number_of_bar 
  l_fin$hjust <- ifelse( angle < -90, 1, 0)
  l_fin$angle <- ifelse(angle < -90, angle+180, angle)
  l_fin
})

output$plot3 <- renderPlot({
  ggplot(label_data1(), aes(x=as.factor(id), y=value, fill=group)) +
    geom_bar(stat="identity", alpha=0.5) +
    ylim(-70,290) +
    theme_minimal() +
    labs("")+
    theme(
      legend.position = c(0.5, 0.5),
      legend.title=element_blank(),
      legend.text = element_text(size = 8),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-6,10), "cm")  
    ) +
    coord_polar(start = 0)+
    geom_text(data=label_data1(), aes(x=id, y=value+5, label=feature, hjust=hjust),
              color="black", fontface="bold",alpha=0.6, size=3.5, 
              angle= label_data1()$angle, inherit.aes = FALSE ) 
})



                        #### network graph ####
test_t <- filter(ico_common, !is.na(legal_source_utility))

# find all NA and replace them with 0
test_t <- test_t[,1:24]
test_t[is.na(test_t)] = 0


# make reactive table
#n <- reactive({ input$network_1 })
mt <- reactive({ 
z <- input$network_1  
z <-  match(z,test_t$country)
test_t <- test_t[z,]
m <- matrix(rep(0,length(input$network_1)*length(input$network_1)), 
            nrow = length(input$network_1), ncol = length(input$network_1),
            dimnames = list(input$network_1,input$network_1))

# make for loop to make matrix
for (i in 1:length(input$network_1)) {  # row
  for (j in 2:24) {    # column
    t = 0
    while (t < length(input$network_1)){
      t = t+1
      if(test_t[i,j] == test_t[t,j]){
        m[t,i] <- m[t,i] +1
      }else{
        next
      }}
  }
}
m
})

output$plot_network <- renderPlot({
network <- graph_from_adjacency_matrix(mt(), weighted=TRUE, 
                                       mode="undirected", diag=F)
deg <- rowSums(mt())   # size of node
cut.off <- mean(mt()) # mean of number of edges
m1 <- as.data.frame(mt())  
x <-c()       # make vector for collor 
for (i in 1:length(input$network_1)){
  temp <- mean(m1[,i])
  if (temp>cut.off){
    x <- c(x,0)
    print(x)
  }else{
    x<- c(x,1)
    print(x)
  }
}

colrs <- c("deepskyblue1", "maroon1")
V(network)$color <- colrs[ifelse(x==0,1,2)]
n_for_shape <- grep(0,x)
net_plot <- plot(network, vertex.size=deg/8, vertex.label.font=2,
                 vertex.shape = 'sphere',
                 vertex.label.dist = 2, 
                 mark.groups=n_for_shape, mark.col="#C5E5E7", 
                 edge.curved=0.3 )
net_plot
})
                        #### buttons for comparison page ####
  # FIRST COLUMN

output$comp_t <- renderText({input$select_com1})
output$comp_t2 <- renderText({input$select_com2})

output$acct_1 <- renderUI({
  x <- ico_common[ico_common$country == input$select_com1,c("name_utility",
                                                        "name_cryptocurrency",
                                                        "name_assets")][1,]
  
  HTML(paste0("<p>",x[1],"</p>","<p>", x[2],"</p>","<p>", x[3],"</p>", sep="\n"))
})

output$acct_2 <- renderUI({
  ico_common[ico_common$country == input$select_com1, 
             "payment_for_goods_and_services_in_cryptocurrency"][1]
})

output$acct_3 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com1, 
                               "clause_of_the_applicable_law"][1]
})

output$acct_5 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com1,
                 "extraterritorial_appl_utility_turnover"][1]
})

output$acct_6 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com1,
                 "extraterritorial_appl_assets_issue"][1]
})

output$acct_7 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com1,
                 "extraterritorial_appl_exchange"][1]
})

output$acct_8 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com1,
                 "possibility_of_an_agreement_utility"][1]
})



observeEvent(input$accord_1,  {
  toggle("acc1", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_2,  {
  toggle("acc2", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_3,  {
  toggle("acc3", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_5,  {
  toggle("acc5", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_6,  {
  toggle("acc6", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_7,  {
  toggle("acc7", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord_8,  {
  toggle("acc8", animType = "slide", anim = TRUE, time = 0.5)
})

    # SECOND COLUMN
output$acct2_1 <- renderUI({
  x <- ico_common[ico_common$country == input$select_com2,c("name_utility",
                                                            "name_cryptocurrency",
                                                            "name_assets")][1,]
  
  HTML(paste0("<p>",x[1],"</p>","<p>", x[2],"</p>","<p>", x[3],"</p>", sep="\n"))
})

output$acct2_2 <- renderUI({
  ico_common[ico_common$country == input$select_com2, 
             "payment_for_goods_and_services_in_cryptocurrency"][1]
})

output$acct2_3 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com2, 
                 "clause_of_the_applicable_law"][1]
})

output$acct2_5 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com2,
                 "extraterritorial_appl_utility_turnover"][1]
})

output$acct2_6 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com2,
                 "extraterritorial_appl_assets_issue"][1]
})

output$acct2_7 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com2,
                 "extraterritorial_appl_exchange"][1]
})

output$acct2_8 <- renderUI({
  ico_applicable[ico_applicable$country == input$select_com2,
                 "possibility_of_an_agreement_utility"][1]
})



observeEvent(input$accord2_1,  {
  toggle("acc21", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_2,  {
  toggle("acc22", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_3,  {
  toggle("acc23", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_5,  {
  toggle("acc25", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_6,  {
  toggle("acc26", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_7,  {
  toggle("acc27", animType = "slide", anim = TRUE, time = 0.5)
})

observeEvent(input$accord2_8,  {
  toggle("acc28", animType = "slide", anim = TRUE, time = 0.5)
})






}




