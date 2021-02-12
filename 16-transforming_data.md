# Transforming data {#transforming-data}



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
<a href="https://github.com/allisonhorst/stats-illustrations" target="_blank"><img src="https://raw.githubusercontent.com/allisonhorst/stats-illustrations/master/rstats-artwork/data_cowboy.png" alt="Artwork by Allison Horst contributed to Hadley Wickham's talk &quot;The Joy of Functional Programming (for Data Science).&quot;" width="70%" /></a>
<p class="caption">(\#fig:unnamed-chunk-2)Artwork by Allison Horst contributed to Hadley Wickham's talk "The Joy of Functional Programming (for Data Science)."</p>
</div>

## Overview

<table class="table-intro table table-hover table-striped" style="margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Goal__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To teach students how to transform raw tabular data to make it suitable for statistical analysis. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Wrangling data is challenging in any context, but at least it's reproducible in R. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>arranging data.frames by ordering along one or more variables or columns,</li>
<li>subsetting data.frames by filtering rows and selecting columns,</li>
<li>transforming data.frames by adding or changing variable or column values,</li>
<li>summarizing data.frames by aggregating factor variables, and</li>
<li>combining data.frames by binding rows and/or columns.</li>
</ol> </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Datasets__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [Palmer Penguins](https://allisonhorst.github.io/palmerpenguins/) [@horst2020palmer] </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Requirements__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Further Reading__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
</tbody>
</table>

Data _wrangling_ refers to all the work you do to prepare your data for analysis in R. Typically, this involves getting your data into R, making sure it's in the right shape or format, making sure you have the right variables and observations, and changing those to fit the analysis where needed. The first of these we already covered in [Chapter 9: Workspace Management](#workspace-management). Here, we will focus on the latter aspects of data wrangling, specifically subsetting and transforming data. While these are far less glamorous than other parts of a statistical workflow, they are no less important. They will also gobble up the greater part of your research effort, even when done efficiently. So, we will spend quite a bit of time on these aspects of data wrangling. Please note that the focus here will be on wrangling data.frames.


## Order  

Let's start with something simple like changing the order of rows in a data.frame. For this, we'll use our penguins data.


```r
penguins <- read.csv("penguins.csv")

str(penguins)
## 'data.frame':	344 obs. of  7 variables:
##  $ species          : chr  "Adelie" "Adelie" "Adelie" "Adelie" ...
##  $ island           : chr  "Torgersen" "Torgersen" "Torgersen" "Torgersen" ...
##  $ bill_length_mm   : num  39.1 39.5 40.3 NA 36.7 39.3 38.9 39.2 34.1 42 ...
##  $ flipper_length_mm: int  181 186 195 NA 193 190 181 195 193 190 ...
##  $ body_mass_g      : int  3750 3800 3250 NA 3450 3650 3625 4675 3475 4250 ...
##  $ sex              : chr  "male" "female" "female" NA ...
##  $ year             : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...
```

Suppose we want to re-arrange the rows of this data.frame by sorting them from the smallest penguin to the largest. One would prefer that base R provide a simple function that does this for us. Ideally, it would take a data.frame as input, along with a specification of which variable or variables should be used to re-order rows, and return the re-ordered data.frame as output. Unfortunately, that does not exist, not in base R anyway. So, ordering a data.frame requires some finagling. Specifically, you need to create an _index vector_ of the re-ordered rows and apply that to the data.frame. To create such a vector, we use the `order()` function. To see how this work:


```r
# create index vector
i <- order(df$c1, decreasing = FALSE)
#### Error in df$c1: object of type 'closure' is not subsettable
df$c1
#### Error in df$c1: object of type 'closure' is not subsettable
i
#### Error: object 'i' not found
df[i, ]
#### Error: object 'i' not found
```

Note, that you can order by increasing values of the variable (`decreasing = FALSE`) or decreasing values of the variable (`increasing = TRUE`). 


```r
i <- order(df$c1, decreasing = TRUE)
#### Error in df$c1: object of type 'closure' is not subsettable
i
#### Error: object 'i' not found
df[i, ]
#### Error: object 'i' not found
```


### Change  

[`transform()`]  


### Combine  






