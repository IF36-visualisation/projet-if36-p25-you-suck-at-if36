library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(
    title = tags$div("Top artistes en fonction de la plateforme", style = "font-size: 11px;"),
    titleWidth = 215
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Stats", tabName = "stats", icon = icon("calendar")),
      menuItem("Graphiques", tabName = "graphiques", icon = icon("signal")),
      sliderInput("range", label = "Nb artistes :", min = 1, max = 50, value = 10),
      selectInput("var", label = "Plateforme", choices = c("YouTube", "Spotify"), selected = "YouTube")
    ),
    width = 215
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "stats",
              fluidRow(
                valueBoxOutput("valuebox1"),
                valueBoxOutput("valuebox"),
                valueBoxOutput("valuebox2")
              ),
              fluidRow(
                infoBoxOutput("info1"),
                infoBoxOutput("info2"),
                infoBoxOutput("info3")
              )
      ),
      tabItem(tabName = "graphiques",
              fluidRow(
                box(
                  title = "Top Artistes en fonction de la plateforme choisie", status = "info", solidHeader = TRUE,
                  plotOutput("plot1", height = 600),
                  width = 6
                ),
                box(
                  title = "Top Artistes d'une plateforme unique", status = "warning", solidHeader = TRUE,
                  plotOutput("plot2", height = 600),
                  width = 6
                )
              )
      )
    )
  ),
  skin = "blue"
)
