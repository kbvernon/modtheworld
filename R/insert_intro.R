
### Insert Intro Table Into Chapter ###

insert_intro <- function(goal, 
                         tldr, 
                         outcomes,
                         datasets,
                         requirements,
                         readings){
  
  outcomes <- paste0("Here, you will learn about",
                     "<br>",
                     "<ol>",
                     paste0("<li>",
                            outcomes, 
                            "</li>",
                            collapse = ""),
                     "</ol>")
  
  c_paste_url <- function(x){ 
    
    bob <- lapply(x, function(z){ 
      
      md_url <- paste0("[", z['name'], "](", z['url'], ")") 
      
      entry <- ifelse(is.na(z['ref']), 
                      md_url, 
                      paste(md_url, z['ref'], sep = " "))
      
      return(entry)
      
    })
    
    paste0(unlist(bob), collapse = "<br>")
    
  } 
  
  datasets <- if (length(datasets)) c_paste_url(datasets) else "NONE"
  
  requirements <- if (length(requirements)) c_paste_url(requirements) else "NONE"
  
  readings <- if (length(readings)) c_paste_url(readings) else "NONE"
  
  
  ### data.frame
  meta <- paste0("__", 
                 c("Goal", "tl;dr", "Outcomes", "Datasets", "Requirements", "Further Reading"),
                 "__")
  
  content <- c(goal, tldr, outcomes, datasets, requirements, readings)
  
  intro <- data.frame(meta, content)
  
  
  # custom css for table formatting
  col1_css <- paste0("border: 0 solid transparent; ",
                     "padding-right: 0px; ",
                     "vertical-align: top;")
  
  col2_css <- paste0("border: 0 solid transparent; ",
                     "padding-left: 9px; ",
                     "text-align: justify; ",
                     "text-justify: inter-word;")
  
  # kable
  kbl <- knitr::kable(intro, 
                      format = "html",
                      col.names = NULL,
                      align = "ll",
                      escape = FALSE,
                      table.attr = "class='table-intro'")
  
  kbl <- kableExtra::kable_styling(kbl,
                                   full_width = TRUE,
                                   bootstrap_options = c("hover", "striped"))
  
  kbl <- kableExtra::column_spec(kbl, 1, extra_css = col1_css)
  
  kbl <- kableExtra::column_spec(kbl, 2, extra_css = col2_css)
  
  kbl
  
}
