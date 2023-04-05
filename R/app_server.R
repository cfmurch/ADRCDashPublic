#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # hide loading spinner
  Sys.sleep(2) # prevent flashing if load is too fast
  waiter::waiter_hide()
  
}
