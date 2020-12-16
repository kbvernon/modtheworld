
library(dplyr)
library(ggplot2)
library(here)
library(knitr)
library(kableExtra)

knitr::opts_chunk$set(echo = TRUE,
                      warning = FALSE,
                      message = FALSE,
                      collapse = TRUE, # code and output in same block
                      strip.white = TRUE,
                      fig.align = "center")


set.seed(2020)

source(here("R/insert_intro.R"))