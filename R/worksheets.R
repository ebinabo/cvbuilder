# keep builders commented except case of upgrade
# keep spreadsheets vanilla
#
# library(googlesheets)
# library(magrittr)
# library(readr)
# #
# gs_ls("cv-builder templates") -> sheets
#
# sheets$sheet_title[1] %>% gs_title() %>% saveRDS("data/templates.rda")
#
# templates_ws <- readRDS("data/templates.rda") %>% gs_ws_ls()
#
# templates <- readRDS("data/templates.rda")
#
# achievements <- gs_read(templates, "achievements 1")
# boards <- gs_read(templates, "advisory boards 1")
# certificates <- gs_read(templates, "certificates 1")
# consulting <- gs_read(templates, "consulting 1")
# memberships <- gs_read(templates, "current memberships 1")
# education <- gs_read(templates, "education 1")
# history <- gs_read(templates, "employment history 1")
# experience <- gs_read(templates, "experience 1")
# grants <- gs_read(templates, "grants 1")
# highlights <- gs_read(templates, "highlights 1")
# awards <- gs_read(templates, "honours, awards 1")
# letter <- gs_read(templates, "letter 1")
# talks <- gs_read(templates, "major invited talks 1")
# personal <- gs_read(templates, "personal 1")
# books <- gs_read(templates, "publications, books 1")
# reports <- gs_read(templates, "publications, reports 1")
# thesis <- gs_read(templates, "publications, thesis 1")
# references <- gs_read(templates, "references 1")
# research <- gs_read(templates, "research 1")
# services <- gs_read(templates, "services 1")
# skills <- gs_read(templates, "skills 1")
# software <- gs_read(templates, "software 1")
# solutions <- gs_read(templates, "solutions 1")
# teaching <- gs_read(templates, "teaching 1")
#
# list(achievements_ws = achievements, boards_ws = boards,
#      certificates_ws = certificates, consulting_ws = consulting,
#      memberships_ws = memberships, education_ws = education,
#      history_ws = history, experience_ws = experience,
#      grants_ws = grants, highlights_ws = highlights, awards_ws = awards,
#      letter_ws = letter, talks_ws = talks, personal_ws = personal,
#      books_ws = books, reports_ws = reports, thesis_ws = thesis,
#      references_ws = references, research_ws = research,
#      services_ws = services, skills_ws = skills, software_ws = software,
#      solutions_ws = solutions, teaching_ws = teaching) %>%
#   saveRDS("data/worksheet-data.rda")
#
# worksheets in a list of data frames
# templates_data <- readRDS("data/worksheet-data.rda")
#
# # names of worksheets
# templates_ws <- gs_ws_ls(templates)
# readr::read_rds("data/worksheet-data.rda")
