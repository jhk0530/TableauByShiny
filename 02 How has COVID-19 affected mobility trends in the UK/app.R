library(ggplot2)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = 'Google Mobility Report : UK Lockdown',
  header = dashboardHeader(
    disable = TRUE
  ),
  sidebar = dashboardSidebar(
    disable = TRUE
  ),
  body = dashboardBody(
    # header
    p('Google Mobility Report: UK Lockdown'),
    tabsetPanel(
      tabPanel(
          'Grocery & Phamacy',
          plotOutput('myplot')
      ),
      tabPanel('Park'),
      tabPanel('Residential'),
      tabPanel('Retail & Recreation'),
      tabPanel('Transit Stations'),
      tabPanel('Workplaces')
    )
  )
)

server <- function(input, output, session) {
  tab <- read.csv('Global_Mobility_Report.csv')
  UK <- tab %>% filter(country_region=='United Kingdom')
  grocery <- UK %>% select(date, grocery_and_pharmacy_percent_change_from_baseline)
  colnames(grocery) <- c('date', 'change')
  grocery <- grocery %>%filter(!is.na(change))
  grocery <- grocery %>% arrange(as.Date(date))
  grocery$date <- as.Date(grocery$date)
  
  
  gg <- ggplot(grocery %>% group_by(date) %>% mutate(means = mean(change)), aes(x = date, y = change))+ 
    geom_jitter(height = 1, width = 0, alpha = 0.15, colour = '#A3AeB2', size = 5) + 
    scale_shape_manual(values = 1) +
    geom_step(aes(x = date, y = means), size = 2) + 
    geom_hline(yintercept = 0, linetype = 'dotted', size = 2)+
    geom_vline(xintercept = as.Date('2020-03-23'), size = 1, color = '#0984e3') + 
    annotate('text', label = 'UK Lockdown', x = as.Date('2020-03-28'), y = -60) + 
    annotate('text', label = 'Baseline', x = as.Date('2020-06-27'), y = 15)
  
  output$myplot <- renderPlot(gg)
}

shinyApp(ui, server)
