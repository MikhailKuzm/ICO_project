

# Define server logic required to draw a histogram
server <- function(input, output) {
    
                        #### Define pal function for coloring  map####
pal1 <- reactive({ 
    if (input$pal_but == 1) {

        pal <- colorFactor(palette = c("green", "red"),
                           domain = ico_common$mining_is_regulated,
                           na.color = "#808080")
    }else{
        if (input$pal_but == 2) { 
            pal <- colorFactor(palette = c("green", "red"),
                               domain = ico_common$direct_application_of_securities_legislation,
                               na.color = "#808080")
      }else{ 
   pal <- colorFactor(palette = c("green", "blue"), 
                      domain = ico_common$payment_for_goods_and_services_in_cryptocurrency,
                      na.color = "#808080")
}
}
 pal
})
 
                        #### Make argument for pal() function ####
col_type <- reactive({
  if (input$pal_but == 1){
    x <- ico_common$mining_is_regulated
  }else{
    if (input$pal_but == 2){
      x <- ico_common$direct_application_of_securities_legislation
    }else{
    x <- ico_common$direct_application_of_securities_legislation
  }
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
  }else{
     if (input$pal_but == 2){
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
  }
})


                        #### Draw map ####
    output$mymap <- renderLeaflet({
        leaflet() %>%
        setView(lat=52, lng=34 , zoom=2) %>%
        addTiles() %>% 
            addPolygons(data = my_shape, 
                        fill = "white",
                        stroke=TRUE, 
                        weight = 0.3,
                        smoothFactor = 0.5,
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
                        layerId = ~NAME)

    })
    
                  #### Make text under map (based on click on map) ####
 observeEvent(input$mymap_shape_click, {
  p <- input$mymap_shape_click
  information <- paste("<p>","<b>","Страна:","</b>", p$id,"</p>",
                       "<p>", "<b>","Название утилити токена:","</b>", 
                        ico_common[ico_common$country == p$id, "name_utility"], "</p>",
                        "<p>", "<b>","Название криптовалют:", "</b>",
                        ico_common[ico_common$country == p$id, "name_cryptocurrency"], "</p>",
                        "<p>", "<b>","Название токенов-активов:","</b>",
                        ico_common[ico_common$country == p$id, "name_assets"], "</p>",
                           "<p>", "<b>","Определение утилити токена:","</b>",
                        ico_common[ico_common$country == p$id, "definition_utility"],"</p>", 
                       "<p>", "<b>","Определение криптовалют:","</b>",
                        ico_common[ico_common$country == p$id, "definition_cryptocurrency"], "</p>", 
                       "<p>",  "<b>","Определение токенов-активов:","</b>",
                       ico_common[ico_common$country == p$id, "definition_assets"], "</p>"
                       )
      
      information <- lapply(information, HTML)
      
   output$text <- renderUI({
     information 
         })
    })

}




