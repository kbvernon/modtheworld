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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To introduce students to the idea of a computing workspace. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> It's just like your kitchen! Keeping it clean won't necessarily make you a great cook, but it will make you a _better_ one. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>environments, specifically the workspace,</li>
<li>workspace management,</li>
<li>the working directory,</li>
<li>absolute and relative file paths,</li>
<li>directory management, and</li>
<li>importing and exporting data.</li>
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

## The Workspace

When we create an object in R, _where does it go_?!!! This is a question that a lot of smart people find themselves asking when first learning R. While the answer is a tad on the esoteric side, it is perhaps useful to peel back the curtain ever so slightly, so you can see what is happening when you create an object in R. To do that, we need to talk about environments, in particular, the "global" environment, which is your default "workspace." You can think of an environment like the workspace as a special sort of named list. 


```r
bob <- list(a = 1:5,
            add_one = function(x){ x + 1 },
            b = LETTERS[1:10],
            c = "quotidian",
            d = TRUE)

# coerce list to environment object
digital_zoo <- as.environment(bob)
```

When you create an object, you do not have to go through these steps explicitly for R adds any objects you define to your global environment by default. The key here is just to recognize that when you use `<-`, you are in effect adding an element to a list, the environment list. 

If you want to know what objects currently reside in your workspace, you can try `ls()`, which works like `names()` does for lists, printing the names of its denizens.


```r
names(bob)
## [1] "a"       "add_one" "b"       "c"       "d"
ls(digital_zoo)
## [1] "a"       "add_one" "b"       "c"       "d"
```

Because the global environment is treated as your default workspace, you do not have to specify the environment in the `ls()` call. In the example above, we specify the environment explicitly to emphasize the list-analogy, so that when you call `ls()`, you are doing something very similar to checking the names of a list.  

One other function you might find useful is `ls.str()`. This is a combination of `ls()` and `str()`, which you were introduced to in the previous chapter. This function lists all the elements in the workspace and provides information about their structure.


```r
ls.str(digital_zoo)
## a :  int [1:5] 1 2 3 4 5
## add_one : function (x)  
## b :  chr [1:10] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J"
## c :  chr "quotidian"
## d :  logi TRUE
```

\BeginKnitrBlock{rmdnote}<div class="rmdnote">The information provided by `ls.str()` is more or less what you will find in RStudio's Environment pane, by default the pane in the upper right corner of the RStudio window.  </div>\EndKnitrBlock{rmdnote}



### Workspace Management

As a general rule, you should keep your workspace clean and orderly when conducting any analysis, just as you should keep your kitchen clean and orderly when cooking. There are two big reasons for this. First, it will help prevent careless mistakes (like running operations on the wrong objects or adding a cup of salt when the recipe calls for sugar). It will also make it easier to manage your workflow, to make it more efficient and intelligible. Right now, I have this horrifying image of that college roommate, you know, the one that never does the dishes, leaves food stains on the counter, lets food rot in the fridge, and for some reason you can't quite fathom, spends several weeks conducting an experiment involving molds growing beneath the sink. And now that person is somehow, by some miracle, in charge of - I don't know - Katz's Deli in New York! One shudders at the thought! I mean, talk about a kitchen nightmare. By all that is good, you ought to avoid this. You want to avoid workspace nightmares. 

One way to do that is to regularly remove objects that you will not re-use - meaning, you should banish them from your workspace. This is achieved with the `rm()` or _remove_ function.


```r
rm(a, envir = digital_zoo) # read this as: remove object a from the digital zoo environment

ls(digital_zoo)
## [1] "add_one" "b"       "c"       "d"
```

Just as we noted with `ls()`, when you're removing objects from your workspace (and not the toy environment that I just created as an example), it is sufficient to type `rm(<object>)` without specifying the environment, since it defaults to the global environment anyway.  


### Save source!

## Working directory

<div class="figure" style="text-align: center">
<img src="images/r-working_directory.png" alt="Leslie has two folders on her computer: (i) scrap_book_folder and (ii) NPS_project_folder. She wants to read the file _data.csv_ into R, but something has gone wrong..." width="90%" />
<p class="caption">(\#fig:unnamed-chunk-8)Leslie has two folders on her computer: (i) scrap_book_folder and (ii) NPS_project_folder. She wants to read the file _data.csv_ into R, but something has gone wrong...</p>
</div>

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

