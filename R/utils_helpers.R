
# other -------------------------------------------------------------------
#' 
#' #' Color palette
#' #' 
#' #' UAB color palette. Primarily used for static UI elements.
#' #' 
#' #' Sourced from https://www.uab.edu/toolkit/brand-basics/colors#digital
#' #' 
#' #' @noRd
#' #' @author Joseph Marlo, \email{support@landeranalytics.com}
#' #' 
#' #' @examples
#' #' color_palette$green
#' #' scales::show_col(unlist(color_palette))
#' color_palette <- list(
#'   green = "#88C408", 
#'   green_medium = '#007348',
#'   green_dark = "#144B39", 
#'   green_dark_dark = "#152e24",
#'   yellow = "#FFD602",
#'   gold = "#A69363",
#'   grey = "#808285",
#'   grey_dark = "#2d3338"
#' )
#' 
#' 
#' #' Add red "beta" ribbon to the bottom left of the UI
#' #'
#' #' To be used withi Shiny UI
#' #'
#' #' @return html
#' #' @noRd
#' #' @author Joseph Marlo, \email{support@landeranalytics.com}
#' #' 
#' #' @examples
#' #' add_beta_ribbon()
#' add_beta_ribbon <- function(){
#'   
#'   # inline CSS
#'   style <- "
#'     width: 200px;
#'     background: #b81b11;
#'     position: fixed;
#'     bottom: 25px;
#'     left: -50px;
#'     text-align: center;
#'     line-height: 50px;
#'     letter-spacing: 3px;
#'     font-size: 1.5em;
#'     font-weight: 700;
#'     color: #f0f0f0;
#'       -webkit-transform: rotate(45deg);
#'       -moz-transform: rotate(45deg);
#'     transform: rotate(45deg);
#'       -webkit-box-shadow: 0 0 15px rgba(0,0,0,0.5);
#'       -moz-box-shadow: 0 0 15px rgba(0,0,0,0.5);
#'     box-shadow: 0 0 15px rgba(0,0,0,0.5);
#'     z-index: 9999;
#'     "
#'   
#'   beta_div <- tags$div(
#'     class = 'corner-ribbon', 
#'     style = style,
#'     'BETA'
#'   )
#'   
#'   return(beta_div)
#' }