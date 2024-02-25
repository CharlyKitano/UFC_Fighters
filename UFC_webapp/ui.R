library(shiny)
library(shinydashboard)
library(DT)
dashboardPage(
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
