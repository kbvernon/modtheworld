# code based on http://www.noamross.net/archives/2013-06-18-helpconsoleexample/

get_fun_args <- function(x, package, keep_args = NULL) {  
  
  helpfile = utils:::.getHelpFile(help(x, package = eval(package)))
  
  html_lines <- capture.output(tools:::Rd2HTML(helpfile))
  
  html_lines <- paste0(html_lines, collapse = "\n")
  
  html_lines <- xml2::read_html(html_lines)
  
  args_df <- rvest::html_node(html_lines, "table[summary='R argblock']")
  
  args_df <- rvest::html_table(args_df)
  
  names(args_df) <- c("Argument", "Description")
  
  if (!is.null(keep_args)) {
    
    ind <- args_df$Argument %in% keep_args
    
    args_df <- args_df[ind, ]
    
  }
  
  args_df
  
}

add_args_kable <- function(x, caption) {
  
  # kable
  kbl <- knitr::kable(x, 
                      format = "html",
                      escape = FALSE,
                      caption = caption,
                      align = "ll")
  
  kbl <- kableExtra::kable_styling(kbl,
                                   full_width = TRUE,
                                   bootstrap_options = c("hover", "striped"))
  
  kbl
  
}