# set global options
# options(stringsAsFactors = F)

#' Generate Transaction Id
#'
#' @description Id is an alphanumeric character string, length 8.
#' Used to store customer data and name files
#'
#' @return
#'
#' @importFrom purrr %>%
#' @export
#'
#' @examples
generate_tr_id <- function(){
  characters <- c(as.character(0:9), LETTERS)
  sample(characters, 8, T) %>%
    paste(collapse = "")
}

#' Spreadsheet builder
#'
#' @param ...
#'
#' @description Takes in user list containing info on current user, named ...$tr_id
#' Subsets ...$user_template over templates_data and returns worksheets selected in
#' a list, creates an xlsx file named ...$tr_id in temp folder, mails it to
#' ...$email and then deletes the xlsx file
#' ...$first_name and ...$method are required
#' ...$method = "mail", include "googlesheets" maybe or remove
#'
#' @return
#'
#' @import  gmailr
#' @importFrom  openxlsx write.xlsx
#' @importFrom  stringr str_glue
#' @export
#'
#' @examples
ss_builder <- function(...){
  # subset by vector of worksheet names
  user_ss <- templates_data[...$user_template]

  # create a new temporary file path for new xlsx file
  path <- paste0("temp/", ...$tr_id, ".xlsx")

  write.xlsx(user_ss, path)

  mailer <- function(...){
    intro <- {str_glue(
      "Hi {name}, \n",
      "Your id is {id}, \n",
      "Attached below are your spreadsheet and instructions on how to fill them \n",
      "Reply to this mail with any issues using your id as the subject \n",
      name = ...$first_name,
      id = ...$tr_id
    )}
    mime_object <- mime(from = "nigerianentrepreneurs7@gmail.com",
                        to = ...$email,
                        subject = "Your CV Spreadsheet",
                        body = intro)
    mime_object <- attach_part(mime_object, intro)
    mime_object <- attach_file(mime_object, path, type = "application/xlsx")
    mime_object <- attach_file(mime_object, "data/description.txt", type = "text/plain")

    send_message(mime_object)
  }

  switch(...$method,
         "mail" = mailer(...)
  )

  # delete temp file at end of function
  file.remove(path) # returns T
}

#' Multiple Details Handler
#'
#' @param df
#' @param index_col
#'
#' @description Use to process worksheets that may contain extra rows for
#' the same item, index_col. Splits worksheet into a list of dataframes,
#' containing only one item from the index_col per dataframe
#'
#' @return
#'
#' @importFrom purrr map2
#'
#' @examples
multiple_details_handler <- function(df, index_col){
  # store index column in index
  index <- df[index_col]

  # get row positions of index that are NA and store in start,
  # include "" and trim whitespaces in dataframes first
  # subtract 1 from all start positions to get stop positions
  # remove first element(0) from vector and add stop position
  # of last section which is the last row of dataframe
  start <- which(index %>% is.na() == F)
  stop <- c((start - 1)[-1], nrow(df))

  # selector returns selected rows of df
  selector <- function(df, from, to) df[from:to, ]

  # map  df, start and stop to selector
  map2(start, stop, ~selector(df, .x, .y)) # returns the split dataframes in a list
}

#' Convert to PDF
#'
#' @param tr_id
#' @param cv_ui
#'
#' @description Creates a shiny ui page and creates a snapshot in pdf,
#' named ...$tr_id.
#' cv_ui <- fluidPage(...)
#'
#' @return
#'
#' @importFrom stringr str_glue
#' @importFrom shiny shinyApp
#' @importFrom webshot appshot
#' @importFrom purrr %>%
#' @export
#'
#' @examples
convert_to_pdf <- function(tr_id, cv_ui){
  # save file where mail_resume() can find it
  cv_file <- str_glue("temp/{tr_id}.pdf")
  shinyApp(ui = cv_ui, server = function(input, output){}) %>%
    appshot(file =  cv_file)
}

#' Resume mailer
#'
#' @param ...
#'
#' @description Mail resume to client, ... is user info list
#' ...$first_name is required
#'
#' @return
#'
#' @import  gmailr
#' @importFrom  stringr str_glue
#' @export
#'
#' @examples
mail_resume <- function(...){
  intro <- {str_glue(
    "Hi {name}, \n",
    "Attached below is your resume \n",
    "Reply to this mail with any issues using your id: {id} as the subject \n",
    name = ...$first_name,
    id = ...$tr_id
  )}

  # search for pdf file
  path <- str_glue("temp/{...$tr_id}.pdf")

  mime_object <- mime(from = "nigerianentrepreneurs7@gmail.com",
                      to = ...$email,
                      subject = "Your Resume",
                      body = intro)
  mime_object <- attach_part(mime_object, intro)
  mime_object <- attach_file(mime_object, path, type = "application/pdf")

  send_message(mime_object)
}

#' Delete rownames column
#'
#' @param worksheet
#'
#' @description Use in a case where worksheet is read with an extra rownames column
#'
#' @return
#'
#' @importFrom dplyr select %>%
#'
#' @examples
remove_rownames_column <- function(worksheet){
  if(worksheet$X %>% is.null() == F){
    worksheet <- worksheet %>% select(-X)
  }

  worksheet
}

#' Remove NA
#'
#' @param x
#'
#' @description mapped over lists to remove NA values
#'
#' @return
#'
#' @importFrom purrr %>%
#'
#' @examples
remove_na <- function(x){x %>% `[`(!is.na(.))}

#' Split by commas
#'
#' @param table_cell
#'
#' @description Use in worksheet sections where multiple values should be split by commas
#'
#' @return
#'
#' @importFrom purrr flatten_chr %>%
#'
#' @examples
split_csvs <- function(table_cell){
  table_cell %>%
    strsplit(",") %>%
    flatten_chr() %>%
    trimws()
}









































