#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

  output$placeholder_table <- renderDT({
    # Create a placeholder table with some sample data
    data <- data.frame(
      Test = c("Test", "Test", "Test"),
      Age = c(30, 25, 35),
      Test = c("Test", "Test", "Test")
    )
    datatable(data)
  })
  # Placeholder plot
  output$placeholder_plot <- renderPlot({
    plot(1, type = "n", xlab = "", ylab = "", xlim = c(0, 1), ylim = c(0, 1), main = "Test")
  })
  
}
