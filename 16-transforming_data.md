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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To learn how to transform tabular data to make it suitable for statistical analysis. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Transforming data is challenging in any context, but at least it's reproducible in R. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>arranging data.frames by ordering along one or more variables,</li>
<li>combining data.frames by binding rows and columns,</li>
<li>transforming data.frames by adding variables or changing values, and</li>
<li>summarizing data.frames by aggregating factor variables.</li>
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

Often times, getting your data ready for analysis will require you to transform it in one way or another, though not, of course, in ways that would imply you are cooking the books! To explore the various tools R provides for doing this, we'll return again to our penguins data.


```r
penguins <- read.csv("penguins.csv")

str(penguins)
## 'data.frame':	344 obs. of  7 variables:
##  $ species          : chr  "Adelie" "Adelie" ...
##  $ island           : chr  "Torgersen" "Torgersen" ...
##  $ bill_length_mm   : num  39.1 39.5 40.3 NA 36.7 ...
##  $ flipper_length_mm: int  181 186 195 NA 193 ...
##  $ body_mass_g      : int  3750 3800 3250 NA 3450 ...
##  $ sex              : chr  "male" "female" ...
##  $ year             : int  2007 2007 2007 2007 2007 ...
```

## Order table 

Suppose we want to re-arrange the rows of our penguins data by sorting in terms of body mass. Ideally, base R would provide us a function that takes a data.frame as input, along with a specification of which variable or variables should be used to re-order rows, and return the re-ordered data.frame as output. Unfortunately, that does not exist, not in base R anyway. So, ordering a data.frame requires some finagling. Specifically, you need to create an _index vector_ of the re-ordered rows and apply that to the data.frame. In this case, the sorting vector needs to have a length equal to the number of rows in the table. This is because we are not subsetting or filtering the rows, but simply returning them in a different order. To create such a vector, we use the `order()` function, passing it the variable we want to order the table with. It is probably easiest to see how `order()` works by first considering a vector of un-ordered letters.


```r
unordered_letters <- c("b", "d", "e", "a", "c")

(i <- order(unordered_letters))
## [1] 4 1 5 2 3
```

The vector `order()` returns here is a vector of numeric positions. These numeric positions line up with the letters in the `unordered_letters` vector like so:

* `4` refers to `"a"` 
* `1` refers to `"b"`, 
* `5` refers to `"c"`, 
* `2` refers to `"d"`, and 
* `3` refers to `"e"`. 

We can, thus, use the result of `order()` to put the letters of `unordered_letters` into their proper alphabetic order.


```r
unordered_letters[i]
## [1] "a" "b" "c" "d" "e"
```

When applied to a variable in a table, the numeric positions returned are also the row numbers. Hence, we can use the result of `order()` to re-arrange rows in a table by the specified variable.


```r
# create index vector
row_order <- order(penguins$body_mass_g)

row_order[1:5]
## [1] 315  59  65  55  99
order_penguins <- penguins[row_order, ]

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

Note, that you can order by increasing (`decreasing = FALSE`) or decreasing (`increasing = TRUE`) values of the variable. 


```r
row_order  <- order(penguins$body_mass_g, decreasing = TRUE)

order_penguins <- penguins[row_order , ]

head(order_penguins)
##     species island bill_length_mm flipper_length_mm body_mass_g  sex year
## 170  Gentoo Biscoe           49.2               221        6300 male 2007
## 186  Gentoo Biscoe           59.6               230        6050 male 2007
## 230  Gentoo Biscoe           51.1               220        6000 male 2008
## 270  Gentoo Biscoe           48.8               222        6000 male 2009
## 232  Gentoo Biscoe           45.2               223        5950 male 2008
## 264  Gentoo Biscoe           49.8               229        5950 male 2009
```

You can also order a table by multiple variables.


```r
row_order <- order(penguins$species,
                   penguins$island,
                   penguins$body_mass_g)

order_penguins <- penguins[row_order , ]

head(order_penguins)
##     species island bill_length_mm flipper_length_mm body_mass_g    sex year
## 59   Adelie Biscoe           36.5               181        2850 female 2008
## 65   Adelie Biscoe           36.4               184        2850 female 2008
## 55   Adelie Biscoe           34.5               187        2900 female 2008
## 105  Adelie Biscoe           37.9               193        2925 female 2009
## 103  Adelie Biscoe           37.7               183        3075 female 2009
## 29   Adelie Biscoe           37.9               172        3150 female 2007
```


## Combine tables 

You will often find yourself wanting to combine multiple tables together. Sometimes this is because of the way that you collected data in the field, like having multiple forms with multiple tables that make data collection easier. Other times it is probably owing to the fact that you collected some data, then someone else collected some more, and now you need to put the two together. There are two primary ways to do this in R. Which one you should use depends on the circumstances of your data.  

* If you have two tables with the __same variables__ but __new observations__, then you will combine the observations or rows of each table together. If you had, for example, gone out a year or two after the initial phases of penguins data collection and measured the same variables as before (flipper length, bill length, and body mass), you would want to ensure that the newly measured values remain _bound_ to the same variables in your original table. This is achieved with `rbind()`.  
* If you have two tables with __new variables__ but the __same observations__, then you will combine the variables or columns of each table together. If you had, for example, identified the same penguins during the same years as in the initial phases of penguin data collection and, say, measured their heights in centimeters and the size of their feet in millimeters, you would want to ensure that these values are _bound_ to the same penguins in the same years as your other variables. This is achieved  with `cbind()`.  
 

```r
penguins <- rbind(penguins, new_observations)

penguins <- cbind(penguins, new_variables)
```


## Change variable  

Sometimes you will want to change the values of a variable. The simple, friendly way to do this involves the `transform()` function. 


```r
# single variable
penguins <- transform(penguins, 
                      body_mass_g = body_mass_g * 10)

# multiple variables
penguins <- transform(penguins, 
                      body_mass_g = scale(body_mass_g),
                      bill_length_mm = scale(bill_length_mm),
                      flipper_length_mm = scale(flipper_length_mm))
```

\BeginKnitrBlock{rmdnote}<div class="rmdnote">As with `subset()`, you do not have to quote variable names when referring to them within the `transform()` function. Again, this is because R knows that you are referring to the variables within the specified table.  </div>\EndKnitrBlock{rmdnote}

You can achieve the same result with the `[` and `$` operators, though in a less elegant way, especially for multiple variables.  


```r
# bracket operator
penguins[ , "body_mass_g"] <- scale(penguins$body_mass_g)
penguins[ , "bill_length_mm"] <- scale(penguins$bill_length_mm)
penguins[ , "flipper_length_mm"] = scale(penguins$flipper_length_mm)

# dollar operator
penguins$body_mass_g <- scale(penguins$body_mass_g)
penguins$bill_length_mm <- scale(penguins$bill_length_mm)
penguins$flipper_length_mm = scale(penguins$flipper_length_mm)
```


## Add variable

The `transform()` function also allows you to append new variables to your table. This is most useful when you want to use other variables in the table to define a new variable. For instance, if we wanted to find the ratio of bill length to body mass for each individual penguin and add that ratio as a new column, we could do this:


```r
original_variables <- names(penguins)

# add ratio variable
penguins <- transform(penguins, 
                      ratio_bill_mass = bill_length_mm / body_mass_g)

new_variables <- names(penguins)

setdiff(new_variables, original_variables)
## [1] "ratio_bill_mass"
```

The `setdiff()` function (short for _set difference_) here is simply asking for the names of variables in the modified penguins table that are _not_ in the original penguins table, so this is just a way of showing that we have in fact added a new variable.  

As above, you can achieve the same result with the `[` and `$` operators, though again in a far less friendly way.


```r
penguins$ratio_bill_mass <- penguins$bill_length_mm / penguins$body_mass_g

penguins[ , "body_mass_zs"] <- penguins$bill_length_mm / penguins$body_mass_g
```

Using these subset operators can get exceptionally tedious when you want to add many new variables based on values of the original variables.


```r
new_penguins <- transform(penguins, 
                          ratio_bill_mass = bill_length_mm / body_mass_g,
                          ratio_bill_fipper = bill_length_mm / flipper_length_mm,
                          normalized_body_mass = body_mass_g / max(body_mass_g))

setdiff(names(new_penguins), names(penguins))
## [1] "ratio_bill_fipper"    "normalized_body_mass"
```



## Aggregate factors

Suppose you want to know the mean body mass of penguins _on each island_ or the median bill length _of each species_. To find these values, you need a way of summarizing your data relative to one or more groups. To achieve this, R provides the `aggregate()` function. This is a powerful, albeit quirky, function. The parameters you will mosty likely interact with on a regular basis are these:  

* `data` = the data.frame containing the variable you want to summarize,  
* `formula` = an R formula of the form `y ~ c1 + c2` that specifies the variable (`y`) to be summarized as a function of one or more factor variables (`c1`, `c2`, ..., `cn`), and   
* `FUN` = the R function that you use to compute the summary statistic.  

As a simple case, consider the scenario where we want to get mean body mass for each island.


```r
aggregate(formula = (body_mass_g ~ island),
          data = penguins,
          FUN = mean)
##      island body_mass_g
## 1    Biscoe    4716.018
## 2     Dream    3712.903
## 3 Torgersen    3706.373
```

And median bill length of each species.


```r
aggregate(formula = (bill_length_mm ~ species),
          data = penguins,
          FUN = median)
##     species bill_length_mm
## 1    Adelie          38.80
## 2 Chinstrap          49.55
## 3    Gentoo          47.30
```

And, finally, mean body mass for each species on each island.


```r
aggregate(formula = (body_mass_g ~ island + species),
          data = penguins,
          FUN = mean)
##      island   species body_mass_g
## 1    Biscoe    Adelie    3709.659
## 2     Dream    Adelie    3688.393
## 3 Torgersen    Adelie    3706.373
## 4     Dream Chinstrap    3733.088
## 5    Biscoe    Gentoo    5076.016
```

