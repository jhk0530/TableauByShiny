library(shiny)
library(shinyjs)
ui <- basicPage(
  useShinyjs(),
  titlePanel("Title"),
  tags$head(
    tags$style(HTML("html, body {height : 100%;}")),
    tags$style(HTML(".container-fluid {height : 100%;}")),
  ),
  fluidRow(
    style = "height : 90%; text-align : center;",
    div(
      id = "DivA",
      style = "
      border : solid 1px #ff6b6b; 
      background-color : #ff6b6b;
      height : 100%; 
      width : 5%; 
      display : inline-block; 
      vertical-align : top;",
      actionButton(inputId = "Button1", label = "", icon = icon("angle-double-right"), style = "width : 100%"),
      p(
        "Label A",
        style = "white-space: nowrap;transform: rotate(-90deg) translateX(-100%);font-size: 24px;",
        id = "LabelA"
      ),
      div(
        id = "ContentA",
        style = "display:none;",
        p(
          "this is content of A"
        )
      )
    ),
    div(
      id = "DivB",
      style = "
      border : solid 1px #1dd1a1; 
      background-color : #1dd1a1; 
      height : 100%; 
      width : 5%; 
      display : inline-block; 
      vertical-align : top;
      ",
      actionButton(inputId = "Button2", label = "", icon = icon("angle-double-right"), style = "width : 100%"),
      p(
        "Label B",
        style = "white-space: nowrap;transform: rotate(-90deg) translateX(-100%);font-size: 24px;",
        id = "LabelB"
      ),
      div(
        id = "ContentB",
        style = "display:none;",
        p(
          "this is content of B"
        )
      )
    ),
    div(
      id = "DivC",
      style = "
      border : solid 1px #54a0ff; 
      background-color : #54a0ff;
      height : 100%; 
      width : 85%; 
      display : inline-block; 
      vertical-align : top;",
      p("this is content of C"),
    )
  )
)

server <- function(input, output, session) {
  stateA <- FALSE
  stateB <- FALSE
  observeEvent(input$Button1, {
    if (stateA) {
      runjs(code = '
            $("#DivC").css("width", "85%"); 
            $("#DivB").css("width", "5%"); 
            $("#DivA").css("width", "5%");
            $("#LabelA").show();
            $("#ContentA").hide();
            ')
      stateA <<- FALSE
      stateB <<- FALSE
    }
    else {
      runjs(code = '
            $("#DivC").css("width", "60%"); 
            $("#DivB").css("width", "5%"); 
            $("#DivA").css("width", "30%");
            $("#LabelA").hide();
            $("#ContentA").show();
            ')
      stateA <<- TRUE
    }
  })
  observeEvent(input$Button2, {
    if (stateB) {
      runjs(code = '
            $("#DivC").css("width", "85%"); 
            $("#DivA").css("width", "5%");
            $("#DivB").css("width", "5%");
            $("#LabelB").show();
            $("#ContentB").hide();
            ')
      stateA <<- FALSE
      stateB <<- FALSE
    }
    else {
      runjs(code = '
            $("#DivC").css("width", "60%"); 
            $("#DivA").css("width", "5%"); 
            $("#DivB").css("width", "30%");
            $("#LabelB").hide();
            $("#ContentB").show();
            ')
      stateB <<- TRUE
    }
  })
}

shinyApp(ui, server, options = list(launch.browser = TRUE))
