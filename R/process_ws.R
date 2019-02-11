#' Process achievements_ws
#'
#' @param achievements_ws
#'
#' @description Call from processor to process achievements_ws
#'
#' @return
#'
#' @importFrom purrr modify_depth map %>%
#'
process_achievements_ws <- function(achievements_ws){
  multiple_details_handler(achievements_ws, "achievements") %>%
    map(as.list) %>% modify_depth(2, remove_na)
}

#' Process awards_ws
#'
#' @param awards_ws
#'
#' @description Call from processor to process awards_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_awards_ws <- function(awards_ws){
  awards_ws %>% as.list()
}

#' Process boards_ws
#'
#' @param boards_ws
#'
#' @description Call from processor to process boards_ws
#'
#' @return
#'
#' @importFrom purrr modify_depth map %>%
#'
process_boards_ws <- function(boards_ws){
  boards_ws %>% multiple_details_handler("role") -> boards_split
  map(boards_split, as.list) %>%
    modify_depth(., 2, remove_na)
}

#' Process education_ws
#'
#' @param education_ws
#'
#' @description Call from processor to process education_ws
#'
#' @return
#'
#' @importFrom purrr modify_depth map %>%
#'
process_education_ws <- function(education_ws){
  multiple_details_handler(education_ws, "degree") %>%
    map(as.list) %>% modify_depth(2, remove_na)
}

#' Process experience_ws
#'
#' @param experience_ws
#'
#' @description Call from processor to process experience_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_experience_ws <- function(experience_ws){
  experience_ws %>% as.list()
}

#' Process grants_ws
#'
#' @param grants_ws
#'
#' @description Call from processor to process grants_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_grants_ws <- function(grants_ws){
  grants_ws %>% as.list()
}

#' Process history_ws
#'
#' @param history_ws
#'
#' @description Call from processor to process history_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_history_ws <- function(history_ws){
  history_ws %>% as.list()
}

#' Process memberships_ws
#'
#' @param memberships_ws
#'
#' @description Call from processor to process memberships_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_memberships_ws <- function(memberships_ws){
  memberships_ws %>% as.list()
}

#' Process personal_ws
#'
#' @param personal_ws
#'
#' @description Call from processor to process personal_ws
#'
#' @return
#'
#' @importFrom purrr map flatten %>%
#'
process_personal_ws <- function(personal_ws){
  # get all complete rows,
  personal_ws[personal_ws %>% complete.cases(),] -> personal_ws

  # push user details to list
  map(personal_ws$X2, list) %>% flatten() -> personal_list

  # name the list items respectively
  names(personal_list) <- personal_ws$Name

  # check for position applied and split if it has multiple csvs
  if(personal_list$`position applied` %>% is.null() == F){
    personal_list$`position applied` <- personal_list$`position applied` %>%
      split_csvs()
  }

  personal_list
}

#' Process references_ws
#'
#' @param references_ws
#'
#' @description Call from processor to process references_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_references_ws <- function(references_ws){
  references_ws %>% as.list()
}

#' Process reports_ws
#'
#' @param reports_ws
#'
#' @description Call from processor to process reports_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_reports_ws <- function(reports_ws){
  reports_ws %>% as.list()
}

#' Process research_ws
#'
#' @param research_ws
#'
#' @description Call from processor to process research_ws
#'
#' @return
#'
#' @importFrom purrr modify_depth map %>%
#'
process_research_ws <- function(research_ws){
  multiple_details_handler(research_ws, "title") %>%
    map(as.list) %>% modify_depth(2, remove_na)
}

#' Process services_ws
#'
#' @param services_ws
#'
#' @description Call from processor to process services_ws
#'
#' @return
#'
#' @importFrom purrr modify_depth map %>%
#'
process_services_ws <- function(services_ws){
  multiple_details_handler(services_ws, "service") %>%
    map(as.list) %>% modify_depth(2, remove_na)
}

#' Process skills_ws
#'
#' @param skills_ws
#'
#' @description Call from processor to process skills_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_skills_ws <- function(skills_ws){
  skills_ws %>% as.list()
}

#' Process skills_2_ws
#'
#' @param skills_2_ws
#'
#' @description Call from processor to process skills_2_ws
#'
#' @return
#'
#' @importFrom purrr map flatten %>%
#'
process_skills_2_ws <- function(skills_2_ws){
  map(skills_2_ws$skills, list) %>%
    flatten() %>%
    map(split_csvs) -> skills_2_list

  names(skills_2_list) <- skills_2_ws$role

  skills_2_list
}

#' Process software_ws
#'
#' @param software_ws
#'
#' @description Call from processor to process software_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_software_ws <- function(software_ws){
  software_ws %>% as.list()
}

#' Process solutions_ws
#'
#' @param solutions_ws
#'
#' @description Call from processor to process solutions_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_solutions_ws <- function(solutions_ws){
  solutions_ws %>% as.list()
}

#' Process talks_ws
#'
#' @param talks_ws
#'
#' @description Call from processor to process talks_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_talks_ws <- function(talks_ws){
  talks_ws %>% as.list()
}

#' Process teaching_ws
#'
#' @param teaching_ws
#'
#' @description Call from processor to process teaching_ws
#'
#' @return
#'
#' @importFrom purrr map modify_depth %>%
#'
process_teaching_ws <- function(teaching_ws){
  multiple_details_handler(teaching_ws, "role") %>%
    map(as.list) %>% modify_depth(2, remove_na)
}

#' Process thesis_ws
#'
#' @param thesis_ws
#'
#' @description Call from processor to process thesis_ws
#'
#' @return
#'
#' @importFrom purrr %>%
#'
process_thesis_ws <- function(thesis_ws){
  thesis_ws %>% as.list()
}


# ============================================================================================


#' Processor
#'
#' @param worksheets
#' @param ...
#'
#' @description switch case statement to run process_ on corresponding worksheet.
#' Map over names of worksheets
#'
#' @return
#'
#' @examples
processor <- function(worksheets, ...){
  available_worksheets <- switch(worksheets,
     "achievements_ws" = process_achievements_ws(...$achievements_ws),
     "awards_ws" = process_awards_ws(...$awards_ws),
     "boards_ws" = process_boards_ws(...$boards_ws),
     # "books_ws" = process_books_ws(...$books_ws),
     # "certificates_ws" = process_certificates_ws(...$certificates_ws),
     # "consulting_ws" = process_consulting_ws(...$consulting_ws),
     "education_ws" = process_education_ws(...$education_ws),
     "experience_ws" = process_experience_ws(...$experience_ws),
     "grants_ws" = process_grants_ws(...$grants_ws),
     # "highlights_ws" = process_highlights_ws(...$highlights_ws),
     "history_ws" = process_history_ws(...$history_ws),
     # "letter_ws" = process_letter_ws(...$letter_ws),
     "memberships_ws" = process_memberships_ws(...$memberships_ws),
     "personal_ws" = process_personal_ws(...$personal_ws),
     "references_ws" = process_references_ws(...$references_ws),
     "reports_ws" = process_reports_ws(...$reports_ws),
     "research_ws" = process_research_ws(...$research_ws),
     "services_ws" = process_services_ws(...$services_ws),
     "skills_ws" = process_skills_ws(...$skills_ws),
     "skills_2_ws" = process_skills_2_ws(...$skills_2_ws),
     "software_ws" = process_software_ws(...$software_ws),
     "solutions_ws" = process_solutions_ws(...$solutions_ws),
     "talks_ws" = process_talks_ws(...$talks_ws),
     "teaching_ws" = process_teaching_ws(...$teaching_ws),
     "thesis_ws" = process_thesis_ws(...$thesis_ws)
  )

  available_worksheets
}

#' Process User Data
#'
#' @param user_data
#'
#' @description Get user data from list of worksheets ready for templates
#'
#' @return
#'
#' @importFrom purrr map set_names %>%
#' @export
#'
#' @examples
process_user_data <- function(user_data){
  # user_data is list of worksheets for current user
  # worksheets are the names of the worksheets in user_data
  worksheets <- names(user_data)

  # iteratively pass each element of worksheets to processor with user_data as the second arg
  # x[] <- ~ processor(worksheets[.x], user_data)
  map(worksheets, processor, user_data) %>%
    # name top level of returned list accordingly
    set_names(worksheets)
}





















