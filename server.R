
# Define server logic required to draw a histogram
server <- function(input, output) {
  
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
    x <- ico_common$direct_application_of_securities_legislation
  }
  x
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
  
          # "<p>", ico_common[ico_common$country == p$id, "definition_utility"][1],"</p>",
          # "<p>", ico_common[ico_common$country == p$id, "definition_cryptocurrency"][1], "</p>") 
            #  "<p>",  "<b>","Определение токенов-активов:","</b>",
              #  ico_common[ico_common$country == p$id, "definition_assets"][1], "</p>"
                      # )
      information1 <- lapply(information1, HTML)               
      information2 <- lapply(information2, HTML)
      information3 <- lapply(information3, HTML)
      information4 <- lapply(information4, HTML)
      
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
   
   })
                      ####buttons for showing text under map ####
    observeEvent(input$button1, {
      toggle("hello", animType = "slide", anim = TRUE, time = 0.5)
    })
}




