library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Example"),
  
  sidebarPanel(
    textInput("path", "File:"),
    actionButton("browse", "Browse"),
    tags$br(),
    tags$br(),
    actionButton("upload", "Upload Data")
  ),
  
  mainPanel(
    verbatimTextOutput('content')
  )
  
))