#' data_dict 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd

# Available studies for visualization and building enrollment fields
study_choices <- list(var = c("NACC Participant", "adc_bval", "ADRC Participant"),
                      annot = c("nacc", "bval", "adrc"),
                      name = c("NACC ADRC Cohort", "BVal", "Full UAB ADRC Cohort"),
                      start_dt = c("2020-09-01", "2020-01-01", "2018-01-01"),
                      date_field = c("adc_clin_core_dt", "adc_bval_dt", "adrc_enroll_dt"),
                      visit_date_field = c("a1_form_dt", "a1_form_dt", "a1_form_dt")
)
