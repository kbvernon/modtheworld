# Workspace Management {#workspace-management}



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



<!-- 
make error messages closer to base R 
https://github.com/hadley/adv-r/blob/master/common.R
looks like it doesn't work because R no longer
let's users override s3 methods, so I changed the s3 to "simpleError"
-->






<div class="figure" style="text-align: center">
<img src="images/r-menagerie.png" alt="The R Environment" width="100%" />
<p class="caption">(\#fig:r-menagerie)The R Environment</p>
</div>

## Overview

<table class="table-intro table table-hover table-striped" style="margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Goal__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To familiarize students with the idea of a computing workspace. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> It's just like your kitchen! Keeping it clean won't necessarily make you a great cook, but it will make you a _better_ one. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>the working directory,</li>
<li>absolute and relative file paths,</li>
<li>directory management,</li>
<li>importing and exporting data,</li>
<li>environments, specifically the workspace, and</li>
<li>workspace management.</li>
</ol> </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Datasets__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Requirements__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [Chapter 6: R Basics](#r-basics)<br>[Chapter 8: Vector Types](#vector-types) </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Further Reading__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [An Introduction to R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html) [@rcoreteam2020introduction]<br>[Advanced R](https://adv-r.hadley.nz/) [@Wickham2015advanced] </td>
  </tr>
</tbody>
</table>

Think of the workspace as your kitchen. 

## Working directory

Describe the difference between a project directory and a working directory.

Explain how to identify the current working directory with `getwd()` and then to make the project directory the working directory with `setwd()`.

A question about reproducible code. To be reproducible, shouldn't it be true that you don't have to change _anything_ in an R script? But what about `setwd()`?

### File paths

Relative vs absolute file paths.


### Directory management

directory structure

file names


## Data Import and Export

Import and assign! In [R Basics](#r-basics) we learned how to create objects with some staying-power using assignment. Well, when we import data, we typically want it to have some staying power too, so we need to assign it to a name right away.  

## Environments

When we create an object in R, _where does it go_?!!! This is a question that a lot of smart people find themselves asking when first learning about R. While the answer is a tad on the esoteric side, it is perhaps useful to peel back the curtain ever so slightly, so you can see what is happening when you create an object in R (including functions!). To do that, we need to talk about environments, in particular, the "global" environment, which is your default "workspace." You can think of an environment like the workspace as a special sort of named list. 


```r
bob <- list(a = 1:5,
            b = LETTERS[1:10],
            c = "quotidian",
            d = TRUE,
            add_one = function(x) x + 1)

# coerce list to environment object
digital_zoo <- as.environment(bob)
```

When you create an object, you do not have to go through these steps explicitly for R adds objects assigned to names to your global environment by default. The key here is just to recognize that when you use `<-`, you are in effect adding an element to a list, the environment list. 

If you want to know what all lives in your R environment, you can try `ls()`, which works like `names()` does for lists, printing the names of its denizens.


```r
ls(digital_zoo)
## [1] "a"       "add_one" "b"       "c"       "d"
```

As a general rule, you should keep your environments clean and orderly. This will help prevent you from making careless mistakes (like running operations on the wrong objects) and also make it easier to manage your workflow. One way to do this is to let go of objects that you will not re-use - meaning, you should banish them from your environment. This is achieved with the `rm()` function.


```r
rm(a, envir = digital_zoo) # read this as: remove object a from the digital zoo environment
```

When you're removing objects from your global environment or workspace (and not the toy environment that I just created as an example), it is sufficient simply to type `rm(<object>)` without specifying the environment, since it defaults to the global environment anyway.  


### Save source!

