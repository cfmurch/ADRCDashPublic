#' The application User-Interface
#' 
#' 
#' UI is defined with header, left sidebar and body
#' Sidebar has three options: "Home", "Data Explorer", "Operational Dashboard"
#' 
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#'
#' @import shiny
#' @import data.table
#'
#' @noRd
#' 
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources - adds CSS (www) and Images (img)
    golem_add_external_resources(),
    
    # initial load spinner
    waiter::waiterShowOnLoad(
      color = ADRCDashHelper::color_palette$grey_dark,
      html = shiny::tagList(
        tags$img(src = 'www/logo-watermark.png',
                 style = 'width: 200px; margin-bottom: 40px',
                 alt = 'UAB logo'),
        br(),
        waiter::spin_ellipsis()
      )
    ),
    
    # TODO: remove when ready
    ADRCDashHelper::add_beta_ribbon(),
    
    # start of dashboard
    bs4Dash::dashboardPage(
      title = "ADRC Data Visualization",
      fullscreen = TRUE,
      dark = NULL,
      
      header = bs4Dash::dashboardHeader(
        title = tags$a(
          href = 'https://www.uab.edu/',
          target = "_blank",
          tags$img(
            src = 'www/logo-ADC.png',
            width = "100%",
            style = "padding: 8% 10% 2% 10%", 
            alt = 'UAB logo'
          )
        )
      ),
      
      body = bs4Dash::dashboardBody(
        
        bs4Dash::tabItems(
          
          # Home tab - splash image
          bs4Dash::tabItem(
            tabName = "home_tab", 
            
            htmltools::tags$div(
              id = 'landing-page',
              htmltools::tags$img(src = "www/splash.png"),
              htmltools::tags$p(
                "This is the visualization dashboard for UAB's Alzheimer's Disease Research Center. Navigation is on the left-hand side and consists of a data exploration tab and operation dashboard. The exploration tab allows you to select covariates of interest and can be subset by sex and race."
              )
            )
          ),
          
          # Data Explorer tab
          bs4Dash::tabItem(
            tabName = "explorer_output",
            
            shiny::fluidRow(
              
              bs4Dash::box(
                width = 4,
                title = 'Inputs',
                
                selectInput(inputId = "group_curr",
                            label = "Group of Interest",
                            choices = group_choices),
                selectInput(inputId = "indvar_curr",
                            label = "X-axis Category",
                            choices = xvar_choices),
                selectInput(inputId = "depvar_curr",
                            label = "Y-axis Variable",
                            choices = yvar_choices),
                selectInput(inputId = "visit_curr",
                            label = "Select visit",
                            choices = visit_choices),  
                shinyWidgets::prettyCheckbox(
                  inputId = "expl_study_restrict",
                  label = "Study Timeframe Only",
                  icon = icon("check"),
                  shape = "curve"
                )
              ),
              
              bs4Dash::box(
                width = 8,
                title = "Results",
                align = "center" , 
                reactable::reactableOutput(
                  outputId = "table_curr_explorer"
                )
              )
            ),
            
            shiny::fluidRow(
              bs4Dash::box(
                width = 12,
                title = "Covariate Explorer Plot",
                echarts4r::echarts4rOutput("plot_curr_explorer_echarts", height = "500px")
              )
            )
          ),
          
          # Inventories tab
          bs4Dash::tabItem(
            tabName = "biospecimen_inventory",
            
            fluidRow(
              bs4Dash::box(
                width = 4,
                title = 'Inputs',
                shinyWidgets::pickerInput(
                  inputId = "inventory_group", 
                  label = "Select inventory subsets",
                  choices = inventory_group_select,
                  options = list(
                    `actions-box` = TRUE, 
                    size = "auto",
                    `select-text-format` = "count", 
                    `count-selected-text` = "{0} selected"
                  ),
                  multiple = TRUE)
              )
            ),
            
            fluidRow(
              bs4Dash::box(
                width = 12,
                title = "Inventory Totals {REVIEW NAME}",
                reactable::reactableOutput(outputId = "biospecimen_table_sum")
              ),
              bs4Dash::box(
                width = 12,
                title = "Inventory Totals {REVIEW NAME}",
                reactable::reactableOutput(outputId = "biospecimen_table_mean")
              )
            )
          )
          
          
          
        )
      ),
      
      sidebar = bs4Dash::dashboardSidebar(
        id = 'sideBarMenu',
        skin = 'dark',
        width = "275px",
        
        bs4Dash::sidebarMenu(
          
          # study select input at top of page
          shinyWidgets::pickerInput(
            inputId = "study_select",
            label = "Study",
            choices = study_choices[["name"]],
            multiple = FALSE,
            selected = "ADRC Cohort"
          ),
          
          htmltools::hr(style = "height: 1px; background-color: #c9d1c5; margin: 1em;"),
          
          # Submenu 1 - Home tab
          bs4Dash::menuItem(
            text = "Home",
            tabName = "home_tab",
            selected = TRUE,
            icon = icon("home", lib = "glyphicon")
          ),
          
          # Submenu 2 - Data Explorer with plot and companion table
          # Has three inputs, grouping of plot (used as group aes), depvar (for Y-axis) and indvar (for X-axis)
          bs4Dash::menuItem(
            text = "Data Explorer", 
            tabName = "explorer_output",
            icon = icon("bar-chart")
          ),
          
          # Biospecimen Inventories
          bs4Dash::menuItem(
            text = "Biospecimen Inventories", 
            tabName = "biospecimen_inventory",
            icon = icon("warehouse")
          )
          
        )
        
      ),
      
      # footer
      footer = bs4Dash::dashboardFooter(
        fixed = TRUE,
        left = htmltools::a(
          href = "https://www.landeranalytics.com/",
          target = "_blank",
          htmltools::HTML(glue::glue("&copy; Lander Analytics {format(lubridate::today(), '%Y')}"))
        )
      )
    )
  )
}


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  #Resource path for CSS
  add_resource_path(
    'www', app_sys('app/www/')
  )
  
  #Resource path for Images (e.g. logo in header)
  add_resource_path(
    'img', system.file('app/img/', package = 'ADRCDash')
  )
  
  #Head tags including favicon
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'ADRC Data Explorer'
    ),
    
    # Add here other external resources
    # Initialize use of waiter
    waiter::use_waiter()
  )
}
