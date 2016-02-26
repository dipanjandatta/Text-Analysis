library(shiny)

file.choose2 <- function(...) {
  pathname <- NULL;
  tryCatch({
    pathname <- file.choose();
  }, error = function(ex) {
  })
  pathname;
}

shinyServer(function(input, output, session) {
  
  observe({
    
    if (input$browse == 0) return()
    
    updateTextInput(session, "path",  value = file.choose2())
  })
  
  contentInput <- reactive({ 
    
    if(input$upload == 0) return()
    
    isolate({
      writeLines(paste(readLines(input$path), collapse = "\n"))
    })
  })
  
  output$content <- renderPrint({
    contentInput()
  })
  
})