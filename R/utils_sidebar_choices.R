#' sidebar_choices 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd

# data exploration choices
group_choices <- c("AD Syndromal Stage", "Race", "Sex", "Race and Sex")
xvar_choices <- c("AD Numeric Stage", "AD Syndromal Stage", "Global CDR", "Race")
yvar_choices <- c("Count", "Age", "Education", "Global CDR")
visit_choices <- c("Baseline", "Most Recent", "Longitudinal")

# selection of marginals for inventory
inventory_group_select <- c("Race", "Sex", "AD Syndromal Stage")
