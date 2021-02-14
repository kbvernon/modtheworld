# Transforming Data {#transforming-data}



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

For this, we'll use our penguins data.


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

## Order  

Suppose we want to re-arrange the rows of our penguins by sorting them in terms of body mass. Ideally, base R would provide us a function that takes a data.frame as input, along with a specification of which variable or variables should be used to re-order rows, and return the re-ordered data.frame as output. Unfortunately, that does not exist, not in base R anyway. So, ordering a data.frame requires some finagling. Specifically, you need to create an _index vector_ of the re-ordered rows and apply that to the data.frame. To create such a vector, we use the `order()` function. 


```r
# create index vector
row_i <- order(penguins$body_mass_g)

row_i[1:5]
## [1] 315  59  65  55  99
order_penguins <- penguins[row_i, ]

head(order_penguins)
##       species    island bill_length_mm flipper_length_mm body_mass_g    sex
## 315 Chinstrap     Dream           46.9               192        2700 female
## 59     Adelie    Biscoe           36.5               181        2850 female
## 65     Adelie    Biscoe           36.4               184        2850 female
## 55     Adelie    Biscoe           34.5               187        2900 female
## 99     Adelie     Dream           33.1               178        2900 female
## 117    Adelie Torgersen           38.6               188        2900 female
##     year
## 315 2008
## 59  2008
## 65  2008
## 55  2008
## 99  2008
## 117 2009
```

Note, that you can order by increasing values of the variable (`decreasing = FALSE`) or decreasing values of the variable (`increasing = TRUE`). 


```r
row_i <- order(penguins$body_mass_g, decreasing = TRUE)

order_penguins <- penguins[row_i, ]

head(order_penguins)
##     species island bill_length_mm flipper_length_mm body_mass_g  sex year
## 170  Gentoo Biscoe           49.2               221        6300 male 2007
## 186  Gentoo Biscoe           59.6               230        6050 male 2007
## 230  Gentoo Biscoe           51.1               220        6000 male 2008
## 270  Gentoo Biscoe           48.8               222        6000 male 2009
## 232  Gentoo Biscoe           45.2               223        5950 male 2008
## 264  Gentoo Biscoe           49.8               229        5950 male 2009
```


### Changing variables  



```r
new_penguins <- transform(penguins, 
                          body_mass_g = scale(body_mass_g))
```


```r
new_penguins <- transform(penguins, 
                          body_mass_g = scale(body_mass_g),
                          bill_length_mm = scale(bill_length_mm),
                          flipper_length_mm = scale(flipper_length_mm))
```


### Adding variables



```r
new_penguins <- transform(penguins, 
                          body_mass_zs = scale(body_mass_g))

setdiff(names(new_penguins), names(penguins))
## [1] "body_mass_zs"
```


```r
new_penguins$body_mass_zs <- scale(penguins$body_mass_g)

new_penguins[ , "body_mass_zs"] <- scale(penguins$body_mass_g)
```


### Combine  


```r
all_penguins <- rbind(penguins, new_penguins)

penguins <- cbind(penguins, new_variables)
```

You can also add new variables with `cbind()`.


```r
new_penguins <- cbind(penguins, "body_mass_z" = scale(penguins$body_mass_g))
```






