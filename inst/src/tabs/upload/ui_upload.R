
tab_upload <- tabItem(
  tabName = "upload",
  align = "center",
  br(),
  
  radioButtons(
    inputId = "app_mode",
    label = "Set analysis mode",
    inline = TRUE,
    choices = c("New analysis" = "new",
                "View analysis" = "view")
  ), 
  
  fluidRow(column(
    width = 6,
    div(
      id = "show_new_analysis",
      br(),
      br(),
      br(),
      fileInput(
        inputId = "file_samples",
        label = "Choose your samples (metadata) file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ), 
      fileInput(
        inputId = "file_counts",
        label = "Choose your raw counts file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      fileInput(
        inputId = "file_annotation",
        label = "Choose your annotation file (optional):",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      br(),
      br(),
      br(),
      style = "position: relative; border-radius: 25px; border: 3px solid #0088cc;",
      hidden(
        div(id = "hide_new_analysis",
            style = "background-color: rgba(0,0,0,0.5); border-radius: 25px; position: absolute; width: 100%; height: 100%; top: 0; z-index: 10;")
      )
    )
  ),
  column(
    width = 6,
    div(
      id = "show_view_analysis",
      br(),
      fileInput(
        inputId = "file_samples_view",
        label = "Choose your samples (metadata) file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      fileInput(
        inputId = "file_counts_view",
        label = "Choose your raw counts file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      fileInput(
        inputId = "file_norm_view",
        label = "Choose your normalized counts file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      fileInput(
        inputId = "file_detab_view",
        label = "Choose your DE file:",
        multiple = FALSE,
        accept = c(
          "CSV",
          ".csv",
          "TSV",
          ".tsv",
          "TXT",
          ".txt",
          "ZIP",
          ".zip",
          "GZ",
          ".gz"
        )
      ),
      style = "position: relative; border: 3px solid rgba(0,0,0,0)",
      div(id = "hide_view_analysis",
          style = "background-color: rgba(0,0,0,0.5); border-radius: 25px; position: absolute; width: 100%; height: 100%; top: 0; z-index: 10;")
    )
  )),
  
  br(),
  div(id = "new_tabs",
      tabsetPanel(
        tabPanel(
          "Samples",
          HTML('<hr style="border-color: #0088cc;">'),
          DT::dataTableOutput("sample_data") %>% withSpinner(),
          HTML('<hr style="border-color: #0088cc;">')
        ),
        
        tabPanel(
          "Counts",
          HTML('<hr style="border-color: #0088cc;">'),
          DT::dataTableOutput("count_data") %>% withSpinner(),
          HTML('<hr style="border-color: #0088cc;">')
        ),
        
        tabPanel(
          "Annotation",
          HTML('<hr style="border-color: #0088cc;">'),
          DT::dataTableOutput("annotation_data") %>% withSpinner(),
          HTML('<hr style="border-color: #0088cc;">')
        )
      )),
  
  hidden(div(
    id = "view_tabs",
    tabsetPanel(
      tabPanel(
        "Samples",
        HTML('<hr style="border-color: #0088cc;">'),
        DT::dataTableOutput("sample_data_view") %>% withSpinner(),
        HTML('<hr style="border-color: #0088cc;">')
      ),
      
      tabPanel(
        "Counts",
        HTML('<hr style="border-color: #0088cc;">'),
        DT::dataTableOutput("count_data_view") %>% withSpinner(),
        HTML('<hr style="border-color: #0088cc;">')
      ),
      
      tabPanel(
        "Normalized Counts",
        HTML('<hr style="border-color: #0088cc;">'),
        DT::dataTableOutput("norm_data_view") %>% withSpinner(),
        HTML('<hr style="border-color: #0088cc;">')
      ),
      
      tabPanel(
        "DE table",
        HTML('<hr style="border-color: #0088cc;">'),
        DT::dataTableOutput("detab_data_view") %>% withSpinner(),
        HTML('<hr style="border-color: #0088cc;">')
      )
    )
  ))
)
