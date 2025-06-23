library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(ggplot2)
library(scales) # pour comma()

# Chargement des données
dataset <- read_csv('/Users/klim/Downloads/Spotify_Youtube.csv')

# Pré-calculs des top 3 (pour les infoBoxes & valueBoxes)
top_views3 <- dataset %>%
  group_by(Artist) %>%
  summarise(Total_Views = sum(Views, na.rm = TRUE)) %>%
  arrange(desc(Total_Views)) %>%
  slice_head(n = 3) %>%
  mutate(Rank_Youtube = row_number())

top_streams3 <- dataset %>%
  group_by(Artist) %>%
  summarise(Total_Streams = sum(Stream, na.rm = TRUE)) %>%
  arrange(desc(Total_Streams)) %>%
  slice_head(n = 3) %>%
  mutate(Rank_Spotify = row_number())

server <- function(input, output) {
  
  # --- VALUE BOXES & INFO BOXES (Onglet Stats) ---
  output$valuebox <- renderValueBox({
    if (input$var == "YouTube") {
      valueBox(
        value = round(max(top_views3$Total_Views, na.rm = TRUE) / 1e6, 2),
        subtitle = "Le nombre d'écoutes max (en millions)",
        icon = icon("youtube"),
        color = "red"
      )
    } else {
      valueBox(
        value = round(max(top_streams3$Total_Streams, na.rm = TRUE) / 1e6, 2),
        subtitle = "Le nombre d'écoutes max (en millions)",
        icon = icon("spotify"),
        color = "green"
      )
    }
  })
  
  output$valuebox1 <- renderValueBox({
    if (input$var == "YouTube") {
      valueBox(
        value = input$var,
        subtitle = "La plateforme choisie",
        icon = icon("youtube"),
        color = "red"
      )
    } else {
      valueBox(
        value = input$var,
        subtitle = "La plateforme choisie",
        icon = icon("spotify"),
        color = "green"
      )
    }
  })
  
  output$valuebox2 <- renderValueBox({
    if (input$var == "YouTube") {
      valueBox(
        value = icon("youtube"),
        subtitle = "L'icône de la plateforme",
        icon = icon("youtube"),
        color = "red"
      )
    } else {
      valueBox(
        value = icon("spotify"),
        subtitle = "L'icône de la plateforme",
        icon = icon("spotify"),
        color = "green"
      )
    }
  })
  
  output$info1 <- renderInfoBox({
    if (input$var == "YouTube") {
      infoBox(
        title = "Chanteur n°1",
        value = top_views3$Artist[1],
        icon = icon("1"),
        color = "maroon"
      )
    } else {
      infoBox(
        title = "Chanteur n°1",
        value = top_streams3$Artist[1],
        icon = icon("1"),
        color = "teal"
      )
    }
  })
  
  output$info2 <- renderInfoBox({
    if (input$var == "YouTube") {
      infoBox(
        title = "Chanteur n°2",
        value = top_views3$Artist[2],
        icon = icon("2"),
        color = "orange"
      )
    } else {
      infoBox(
        title = "Chanteur n°2",
        value = top_streams3$Artist[2],
        icon = icon("2"),
        color = "olive"
      )
    }
  })
  
  output$info3 <- renderInfoBox({
    if (input$var == "YouTube") {
      infoBox(
        title = "Chanteur n°3",
        value = top_views3$Artist[3],
        icon = icon("3"),
        color = "yellow"
      )
    } else {
      infoBox(
        title = "Chanteur n°3",
        value = top_streams3$Artist[3],
        icon = icon("3"),
        color = "lime"
      )
    }
  })
  
  # --- PLOTS (Onglet Graphiques) ---
  output$plot1 <- renderPlot({
    ds <- dataset %>% filter(Url_youtube != "") # enlever les lignes sans URL YouTube
    
    if (input$var == "YouTube") {
      top_views <- ds %>%
        group_by(Artist) %>%
        summarise(Total_Views = sum(Views, na.rm = TRUE)) %>%
        arrange(desc(Total_Views)) %>%
        slice_head(n = input$range) %>%
        mutate(Rank_Youtube = row_number())
      
      ggplot(top_views, aes(
        x = Total_Views / 1e6,
        y = reorder(paste(Rank_Youtube, Artist, sep = " - "), Total_Views)
      )) +
        geom_point(size = 3, color = "#FF0000") +
        geom_text(aes(label = round(Total_Views / 1e6, 1)), hjust = -0.5, size = 3, color = "#FF0000") +
        labs(
          title = "Top Artistes - Vues YouTube",
          x = "Nombre de vues (en millions)",
          y = "Artiste"
        ) +
        scale_x_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
        theme_minimal() +
        theme(
          plot.margin = margin(10, 40, 10, 10),
          axis.text.y = element_text(size = 8)
        )
    } else {
      top_streams <- ds %>%
        group_by(Artist) %>%
        summarise(Total_Streams = sum(Stream, na.rm = TRUE)) %>%
        arrange(desc(Total_Streams)) %>%
        slice_head(n = input$range) %>%
        mutate(Rank_Spotify = row_number())
      
      ggplot(top_streams, aes(
        x = Total_Streams / 1e6,
        y = reorder(paste(Rank_Spotify, Artist, sep = " - "), Total_Streams)
      )) +
        geom_point(size = 3, color = "#1DB954") +
        geom_text(aes(label = round(Total_Streams / 1e6, 1)), hjust = -0.5, size = 3, color = "#1DB954") +
        labs(
          title = "Top Artistes - Écoutes Spotify",
          x = "Nombre d'écoutes (en millions)",
          y = "Artiste"
        ) +
        scale_x_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
        theme_minimal() +
        theme(
          plot.margin = margin(10, 40, 10, 10),
          axis.text.y = element_text(size = 8)
        )
    }
  })
  
  output$plot2 <- renderPlot({
    top_views <- dataset %>%
      group_by(Artist) %>%
      summarise(Total_Views = sum(Views, na.rm = TRUE)) %>%
      arrange(desc(Total_Views)) %>%
      slice_head(n = 50)
    
    top_streams <- dataset %>%
      group_by(Artist) %>%
      summarise(Total_Streams = sum(Stream, na.rm = TRUE)) %>%
      arrange(desc(Total_Streams)) %>%
      slice_head(n = 50)
    
    spotify_only <- setdiff(top_streams$Artist, top_views$Artist)
    youtube_only <- setdiff(top_views$Artist, top_streams$Artist)
    
    spotify_only_dataset <- dataset %>%
      filter(Artist %in% spotify_only) %>%
      group_by(Artist) %>%
      summarise(Total_Views = sum(Views, na.rm = TRUE)) %>%
      arrange(desc(Total_Views))
    
    youtube_only_dataset <- dataset %>%
      filter(Artist %in% youtube_only) %>%
      group_by(Artist) %>%
      summarise(Total_Streams = sum(Stream, na.rm = TRUE)) %>%
      arrange(desc(Total_Streams))
    
    if (input$var == "YouTube") {
      ggplot(youtube_only_dataset, aes(Total_Streams / 1e6, reorder(Artist, Total_Streams))) +
        geom_point(size = 3, color = "#FF0000") +
        geom_text(aes(label = round(Total_Streams / 1e6, 1)), hjust = -0.5, size = 3, color = "#FF0000") +
        labs(
          title = "Artistes Top 50 YouTube (hors Top 50 Spotify)",
          x = "Nombre d'écoutes Spotify (en millions)",
          y = "Artiste"
        ) +
        scale_x_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
        theme_minimal() +
        theme(
          axis.text.y = element_text(size = 8),
          plot.margin = margin(10, 40, 10, 10)
        )
    } else {
      ggplot(spotify_only_dataset, aes(Total_Views / 1e6, reorder(Artist, Total_Views))) +
        geom_point(size = 3, color = "#1DB954") +
        geom_text(aes(label = round(Total_Views / 1e6, 1)), hjust = -0.5, size = 3, color = "#1DB954") +
        labs(
          title = "Artistes Top 50 Spotify (hors Top 50 YouTube)",
          x = "Nombre de vues YouTube (en millions)",
          y = "Artiste"
        ) +
        scale_x_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
        theme_minimal() +
        theme(
          axis.text.y = element_text(size = 8),
          plot.margin = margin(10, 40, 10, 10)
        )
    }
  })
}
