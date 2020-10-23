library(leaflet)
library(shiny)
library(htmltools)

# Define server logic required to draw a histogram
server <- function(input, output) {
        source("common_table.R", local = TRUE)
    
    ####Define ifelse for color buttons####
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


   #temp <- pal1()
    #### Draw map ####
    output$mymap <- renderLeaflet({
        leaflet() %>%
            addPolygons(data = my_shape, 
                        weight = 1,
                        smoothFactor = 0.5,
                        color = pal1()(col_type()),
                        fillOpacity = 0.8,
                        fillColor = pal1()(col_type()),
                        highlight = highlightOptions(
                            weight = 2,
                            color = "red",
                            fillOpacity = 0.4,
                            bringToFront = FALSE))

    })
}
