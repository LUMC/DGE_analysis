
## GC bias plot
output[["gc_bias"]] <- renderPlotly({
  tryCatch({
    checkReload()
    biasPlot(inUse_deTab, input$selectGC, NA, "%", "biasGC")
  }, error = function(err) {
    return(NULL)
  })
})

## GC bias table
output[["selected_biasgc"]] <- DT::renderDataTable({
  tryCatch({
    s <- event_data(event = "plotly_selected", source = "biasGC")
    DT::datatable(inUse_deTab[s$key, ], options = list(pageLength = 15, scrollX = TRUE))
  }, error = function(err) {
    return(DT::datatable(data.frame(c(
      "No data available in table"
    )), rownames = FALSE, colnames = ""))
  })
})

## dropdown with all gc choices
output[["selectGC"]] <- renderUI({
  tryCatch({
    checkReload()
    selectInput(
      inputId = "selectGC",
      label = "Show bias based on:",
      choices = grep(
        'gc$',
        colnames(inUse_deTab),
        value = TRUE,
        ignore.case = TRUE
      )
    )
  }, error = function(err) {
    return(NULL)
  })
})

## feature length bias plot
output[["len_bias"]] <- renderPlotly({
  tryCatch({
    checkReload()
    biasPlot(inUse_deTab, input$selectLength, "log", NA, "biasLength")
  }, error = function(err) {
    return(NULL)
  })
})

## feature length bias table
output[["selected_biaslength"]] <- DT::renderDataTable({
  tryCatch({
    s <- event_data(event = "plotly_selected", source = "biasLength")
    DT::datatable(inUse_deTab[s$key, ], options = list(pageLength = 15, scrollX = TRUE))
  }, error = function(err) {
    return(DT::datatable(data.frame(c(
      "No data available in table"
    )), rownames = FALSE, colnames = ""))
  })
})

## dropdown with all length choices
output[["selectLength"]] <- renderUI({
  tryCatch({
    checkReload()
    selectInput(
      inputId = "selectLength",
      label = "Show bias based on:",
      choices = grep(
        'length$',
        colnames(inUse_deTab),
        value = TRUE,
        ignore.case = TRUE
      )
    )
  }, error = function(err) {
    return(NULL)
  })
})

## feature length bias plot
output[["geneStrand_bias"]] <- renderPlotly({
  tryCatch({
    checkReload()
    geneStrandBar(inUse_deTab)
  }, error = function(err) {
    return(NULL)
  })
})

## INFORMATION BOXES

output[["gc_bias_info"]] <- renderUI({
  infoText <-
    "The GC bias plots are generated based on the mean change of the logFC on the Y-axis. The bias plots
        can only be used if an annotation is used to perform the analysis. If annotation values are
        is present, a column can be selected using a drop-down button. The columns must
        contain the text: 'GC', otherwise they will not be recognized as a suitable column
        for GC bias calculations."
  informationBox(infoText)
})

output[["len_bias_info"]] <- renderUI({
  infoText <-
    "The feature-length bias plots are generated from the mean change of the logFC on the Y-axis. The bias plots
        can only be used if an annotation is used to perform the analysis. If annotation values are
        is present, a column can be selected using a drop-down button. The columns must
        contain the text: 'length', otherwise they will not be recognized as a suitable column
        for length bias calculations."
  informationBox(infoText)
})

output[["geneStrand_info"]] <- renderUI({
  infoText <-
    "The gene strand bias plots are generated based on strand info (+ or -) and number
        genes (DE or not). It shows the distribution of genes between strands. The Gene Strand Plot can only
        be generated using the gene strand information annotation file."
  informationBox(infoText)
})
