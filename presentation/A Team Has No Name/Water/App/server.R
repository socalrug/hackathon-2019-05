shinyServer(function(input, output, session) {
    
    imap <- reactiveVal(NULL)
    
    observe({
        if(input$area == "COUNTY") {
            counties <- CAcounties$COUNTY
            statcounts <- rep(0, length(counties))
            violations <- ActVi[, .N, by = .(COUNTY)]
            statcounts[match(violations$COUNTY, counties)] <- violations$N 
            popup <- ""
            pal <- colorNumeric(palette = "viridis", domain = statcounts)	
            imap <- leaflet(CAcounties) %>% addProviderTiles("CartoDB.DarkMatterNoLabels") %>%
                addPolygons(stroke = F, smoothFactor = 0.2, fillOpacity = 0.8,
                            color = ~pal(statcounts), popup = popup)
        } else {
            zips <- data.table(ZIPCODE = as.character(CAzips@data$ZCTA5CE10), N = 0)
            zipcounts <- ActVi[, .N, by = .(ZIPCODE)]
            zips[match(zipcounts$ZIPCODE, zips$ZIPCODE), N := zipcounts$N]
            zippal <- colorNumeric(palette = "viridis", zips$N)
            popup <- ""
            imap <- leaflet(CAzips) %>% addProviderTiles("CartoDB.DarkMatterNoLabels") %>%
                    addPolygons(stroke = F, smoothFactor = 0.2, fillOpacity = 0.8,
                                color = ~zippal(zips$N), popup = popup)
        }
        imap(imap)
    })

    output$imap <- renderLeaflet({
        imap()
    })
    
    output$imap2 <- renderLeaflet({

        factpal <- colorFactor(palette = "viridis", Stations$Dry)
        # numpal <- colorNumeric(palette = "viridis", Stations$DryHistory)
        imap <- leaflet(Stations) %>% addProviderTiles("CartoDB.DarkMatterNoLabels") %>%
            addCircles(lng = ~LONGITUDE, lat = ~LATITUDE, radius = 1,
                             color = ~factpal(Stations$Dry), fill = F)
        imap
    })
    

})


