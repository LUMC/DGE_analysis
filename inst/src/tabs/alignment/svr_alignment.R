
## Create se from samples and counts
get_se <- reactive({
  se <- readCountsFromTable(data_counts(), data_samples())
  se <- addSamplesFromTableToSE(se, data_samples())
})

## Select a group to sort summary plot
output[["group_sum"]] <- renderUI({
  tryCatch({
    checkReload()
    selectInput(
      inputId = "group_sum",
      label = "Group by:",
      choices = c("None" = "None", colnames(data_samples()))
    )
  }, error = function(err) {
    return(NULL)
  })
})

## Create alignment summary plot
output[["align_sum"]] <- renderPlotly({
  tryCatch({
    checkReload()
    if (input$setSummary == "actual") {
      perc = FALSE
    } else {
      perc = TRUE
    }
    alignmentSummaryPlot(get_se(), input$group_sum, perc)
  }, error = function(err) {
    return(NULL)
  })
})

## Create complexity plot
output[["complex"]] <- renderPlotly({
  tryCatch({
    checkReload()
    if (input$setComplexity == "actual") {
      perc = FALSE
    } else {
      perc = TRUE
    }
    complexityPlot(get_se(), input$group_color, perc, input$comp_rank)
  }, error = function(err) {
    return(NULL)
  })
})

## Select a group to color complexity plot
output[["group_color"]] <- renderUI({
  tryCatch({
    checkReload()
    selectInput(
      inputId = "group_color",
      label = "Group by:",
      choices = c("None" = "None", colnames(data_samples()))
    )
  }, error = function(err) {
    return(NULL)
  })
})

## INFORMATION BOXES

output[["align_sum_info"]] <- renderUI({
  infoText <-
    "The summary plots provide a general overview of the counting data. These plots show a
        bar chart showing the alignment results and a complexity plot. The alignment plot is a stacked bar
        plot, where each 'row' represents a sample and the stacked bars per row are different
        tags. These tags indicate the distribution of read counts given by a read counter (eg.
        HTSeq)."
  informationBox(infoText)
})

output[["complex_info"]] <- renderUI({
  infoText <-
    "The complexity graphs show how many reads cover a given number of genes. On the X-axis,
        there is a ranking from zero to a thousand. This arrangement represents the number of genes.
        The Y-axis shows the proportion of reads in relation to the total number of gene counts.
        Large variances between samples of the number or reads for a gene, will be visible."
  informationBox(infoText)
})
