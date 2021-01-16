
library(dplyr)
library(ggplot2)
library(here)
library(knitr)
library(kableExtra)


local({
  
  # force knitr to strip white space at begin and end of code block
  # even when collapse = TRUE
  hook_source <- knitr::knit_hooks$get('source')
  knitr::knit_hooks$set(source = function(x, options) {
    
    is_blank2 = function(x) {
      
      if (length(x)) all(grepl('^\\s*$', x)) else TRUE
      
    }
    
    strip_white2 = function(x, test_strip = is_blank2) {
      if (!length(x)) return(x)
      while (test_strip(x[1])) {
        x = x[-1]; if (!length(x)) return(x)
      }
      while (test_strip(x[(n <- length(x))])) {
        x = x[-n]; if (n < 2) return(x)
      }
      x
    }
    
    x <- xfun::split_lines(x)
    x <- strip_white2(x)
    x <- paste(x, sep = '', collapse = '\n')
    hook_source(x, options)
  },
  
  # change error styling in output
  error = function(x, options) {
    paste0("<pre style=\"color: red;\"><code>", x, "</code></pre>")
  })
  
})

knitr::opts_chunk$set(echo = TRUE,
                      warning = FALSE,
                      message = FALSE,
                      error = TRUE,
                      collapse = TRUE, # code and output in same block
                      fig.align = "center")

set.seed(2020)

source(here("R/insert_intro.R"))