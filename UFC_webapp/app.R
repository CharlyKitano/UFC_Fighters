library(shiny)
library(shinydashboard)
library(DT)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "UFC"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("General Info", tabName = "general_info"),
      menuItem("Comparison", tabName = "comparison") #think about adding icons
    )
  ),
  dashboardBody(
    tabItems(
      # General Info tab
      tabItem(
        tabName = "general_info",
        # Left sidebar panel
        fluidRow(
          box(
            title = "General Information",
            status = "primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(
              column(6,
                     textInput("country", "Country:", placeholder = "Enter country")),
              column(6,
                     selectInput("fighting_style", "Fighting Style:",
                                 choices = c("KICKBOXER", "Wrestler", "JIU-JITSU"),
                                 selected = "KICKBOXER")
              ),
              column(6,
                     textInput("country", "Country:", placeholder = "Enter country")),
            ),
            #add other inputs and choices 
            actionButton("get_results", "Get Results", class = "btn-primary")
          )
          
        ),
        
        fluidRow(
          column(12,
                 DTOutput("placeholder_table")
          )
        ),
        
        
      ),
      # Comparison tab
      tabItem(
        tabName = "comparison",
        # Right sidebar panel
        fluidRow(
          box(
            title = "Player Comparison",
            status = "warning",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(
              column(6, textInput("player1", "Player 1:", placeholder = "Enter name")),
              column(6, textInput("player2", "Player 2:", placeholder = "Enter name"))
            ),
            actionButton("compare_players", "Compare Players", class = "btn-warning")
          ),
          box(
            title = "Player Info",
            status = "primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            textInput("player_info", "Player Info:", placeholder = "Enter name")
            ,
            actionButton("generate", "Generate Info")
          ),
          
          # Placeholder graph
          fluidRow(
            plotOutput("placeholder_plot", width = "100%")
          )
        )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
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

# Run the application
shinyApp(ui = ui, server = server, appName = "UFC_Fighers")
