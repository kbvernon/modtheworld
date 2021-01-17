# R Style Guide {#r-style-guide}



<!-- include libraries -->



<!-- kableExtra bootstrap css 
https://haozhu233.github.io/kableExtra/bookdown/use-bootstrap-tables-in-gitbooks-epub.html
-->




<!-- knit_hook: collapse and strip white 
this is a Blake hack -->



<!-- knit_hook: collapse and print error red
super hacky, see here: https://stackoverflow.com/a/54985678/7705429
we'll need to be careful to not string four # together anywhere
--->

<script>
$(document).ready(function() {
  window.setTimeout(function() {
    $(".co:contains('####')").css("color", "red");
    var tmp = $(".co:contains('####')").text();
    $(".co:contains('####')").text(tmp.replace("####", "##"));
  }, 15);
});
</script>



<!-- chunk options -->





<!-- miscellaneous -->





<div class="figure" style="text-align: center">
<a href="https://abstrusegoose.com/432" target="_blank"><img src="https://abstrusegoose.com/strips/you_down_wit_OPC-yeah_you_know_me.png" alt="O.P.C. (Abstruse Goose 432)" width="80%" /></a>
<p class="caption">(\#fig:05-style)O.P.C. (Abstruse Goose 432)</p>
</div>



<!--
> "Good coding style is like correct punctuation: you can manage without it, butitsuremakesthingseasiertoread." -Hadley Wickham 
-->

## Abelson again

When writing code, you should always have an eye to ensuring that it is both clear and intelligible for anyone who might come along and read it. This will ensure that your code is _reproducible_, which is especially important if what you are doing with R is scientific analysis. It is also just of practical value, for you will most assuredly want to reuse your code at some point in the future, or apply it to a different data set, but if you can't make heads or tails of it, well...

The following styling rules-of-thumb are inspired by the [Tidyverse style guide](https://style.tidyverse.org/), with a focus on those that are more relevant to beginning R coders. These rules we have tried to follow throughout this book. 

## Be verbose!

One way to make your code clearer is to make it more verbose. Obviously, this isn't a recommendation to include long-winded, self-indulgent soliloquies in your code. Rather, the suggestion is that you not shy away from being explicit, even if - horror of horrors! - it takes you an extra second or two to do. In other words, don't leave it up to the reader to guess what you're doing. 

Verbosity in this sense can be applied to three aspects of R code: i) object names, ii) function parameters (or arguments), and iii) coding comments.  

### Object names

An old-school coding norm encouraged programmers to write highly compact code with loads of abbreviations. In general, however, you should avoid this, at least when it's reasonable to do so. 


```r
# Good
mean_height <- mean(height)

# Bad
mh <- mean(height)

# But,
mean_height_of_actors_who_auditioned_for_aragorn <- mean(height) # is overkill
```

If the abbreviation is something obvious, though, like "USA" or "IHOP," you should feel free to use it.  

### Function parameters

When you call a function, you typically supply it with i) a data object, which the function is going to do something with, and then ii) a list of arguments, which specify how exactly the function will work with the data. You can avoid specifying the argument name for the data object, but you should strive to use the names of any arguments you override.  


```r
# Good
bob <- mean(1:5, na.rm = TRUE)

# Bad
bob <- mean(1:5, TRUE)
```

### Code commenting

Looks like some people get really worked up about this one, but just keep this in mind. Anyone reading your code should ideally be able to understand what it is doing without comments, but this frankly is not always possible (for example, for students who are first learning R!). This means you should typically keep comments to a minimum and only use them when you think it would help someone to understand not just _what_ you are doing, but _why_ you are doing it.


## Don't Repeat Yourself (DRY)

Also known as the DRY Principle. If you find yourself copying the same code multiple times - say, three or more times a session, this is a good indication that you should write a function instead.

## Assignment first

Technically, R allows you to use a right-facing arrow, `->`, for assignment. You can also use the equal sign, `=`. However, even though these are allowed by R, they make your code harder to read and - at least in the latter case - ambiguous. So, you should always use the left-facing arrow, `<-`, for assignment


```r
# Good
bob <- 5.137

# Bad
5.137 -> bob

# Ambiguous
bob = 5.137
```


## The Cratylus Rule

This rule requires that a name reflect the nature of the thing named. Because objects _are_ things and functions _do_ things, the Cratylus Rule suggests that you should use nouns as names for R objects and verbs as names for R functions. 


```r
numbers <- 1:10

add_one <- function(x) x + 1
```

## Empty nests!

Nesting in R is the act of calling one function inside the call to another function, like `rnorm(sample(seq(1, 1000, 2)+3))`. This is OK for _shallow_ nests, meaning a function call in a function call, at least when used sparingly, but you should avoid _deep_ nests, or a function call in a function call in a function call in..., you get the idea. In general, deep nests make your code really, really hard to read, so instead, you should assign the results of the _inner_ functions to intermediate objects and then use those objects in the _outer_ functions.  


```r
# Bad
sort(rnorm(100, mean = mean(sample(seq(1, 1000, 2), 50))))

# Good
samples <- sample(seq(1, 1000, 2), 50)

randos <- rnorm(100, mean = mean(samples))

result <- sort(randos)
```


## Be open

In general, lots of white space makes it easier to read and comprehend just about any string of text, whether in books, articles, or R scripts! 

### Spacing

Use lots of spaces in your code, just as you would with regular texts. That means spaces after commas, spaces around the assignment operator `<-`, and spaces around the equal sign `=` in your function call. 


```r
# Good
bob <- mean(1:5, na.rm = TRUE)

# Bad
bob<-mean(1:5,na.rm=TRUE)
```

### Line Length

Think of your R script as having a giant cliff somewhere in the middle, right around 80 characters. And your job is to never go full _Wiley E. Coyote_ with your code! Instead, return and start a new line. 


```r
# Good
bob <- glm(y ~ x,
           family = gaussian,
           data = my_ten_thousand_observations)

# Bad
bob <- glm(y ~ x, family = gaussian, data = my_ten_thousand_observations)
```

## Be organized

You should use commenting to give your script _structure_ that makes it easier to navigate and to understand its intent. Intuitively, providing structure to your R script is a lot like providing structure to a term paper or a thesis. 

* __Title__. You will want to include a title that indicates the aim or goal of the script, the date you wrote the script, the author(s), and where necessary, any additional notes about the intent of the script or its status. 
* __Sections__. If the script is sufficiently long or complex, you will also want to carve it into named sections using section headers. 
* __Outline__. If you have a lot of those sections, you might also consider adding an outline section at the beginning.
* __Preamble__. Very importantly, make sure to include an R "preamble" section where you attach all the R packages you are using, define any global options you might want to recycle throughout the script, and then source any helper functions you might want to use.


```r
# Aim: What should the script achieve
# Date: 2020-01-13

# Author(s): Blake, Thor, Spiderman

# Note(s): 
# 1. Make sure to pick up more toothpaste at the store.

# OUTLINE -----------------------------------------------

# 1. R PREAMBLE 
# 2. IMPORT DATA
# 3. EXPLORE DATA
# 4. ...

# 1 R PREAMBLE ------------------------------------------

# attach packages
library(dplyr)
library(sf)

# define global options
proj_crs <- st_crs(26912)

# source functions
source("plot_helpers.R")


# 2 IMPORT DATA -----------------------------------------

nc <- st_read(system.file("shape/nc.shp", package = "sf"))

# 3 EXPLORE DATA ----------------------------------------
```

