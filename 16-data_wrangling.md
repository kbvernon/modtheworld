# Data Wrangling {#data-wrangling}



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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To teach students how to clean, shape, and transform raw tabular data to make it suitable for statistical analysis. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Wrangling data is challenging in any context, but at least it's reproducible in R. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>reshaping data.frames between wide and long format,</li>
<li>arranging data.frames by ordering along one or more variables or columns,</li>
<li>transforming data.frames by adding or changing variable or column values,</li>
<li>subsetting data.frames by filtering rows and selecting columns,</li>
<li>summarizing data.frames by aggregating factor variables,</li>
<li>combining data.frames by binding rows and/or columns, and</li>
<li>cleaning data.frames by handling missing values.</li>
</ol> </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Datasets__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [Tables](https://tidyr.tidyverse.org/reference/table1.html) [@Wickham] </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Requirements__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [Chapter 6: R Basics](#r-basics)<br>[Chapter 8: Vector Types](#vector-types)<br>[Chapter 9: Workspace Management](#workspace-management) </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Further Reading__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [R For Data Science](https://r4ds.had.co.nz/index.html) [@Wickham] </td>
  </tr>
</tbody>
</table>

Data pre-processing, colloquially referred to as data _wrangling_, is the work you do to prepare your data for analysis in R. Typically, this involves getting your data into R, making sure it's in the right shape or format, and making sure you have the right variables and observations. The first of these we already covered in [Chapter 9: Workspace Management](#workspace-management). Here, we will focus on the latter aspects of data wrangling, shaping our data and transforming it. While these are far less glamorous than other parts of a statistical workflow, they are no less important. They will also gobble up the greater part of your research effort, even when done efficiently. So, we will spend quite a bit of time on these aspects of data wrangling. Please note that the focus here will be on wrangling data.frames.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">This chapter borrows heavily from the tidy framework as detailed in _R for Data Science_ [@Wickham], especially the arguments for a tidy format in the next section. The big difference is that it covers base R tools for tidying data, rather than those provided by the `tidyverse` family of R packages, which are in many ways more expressive and user-friendly. You can learn more about them at the [tidyverse website](https://www.tidyverse.org/).</div>\EndKnitrBlock{rmdnote}


## Shaping data

_How should you organize your data in a table?_ This might seem like a no-brainer. I mean, are there really that many options for structuring a table? The answer is Yes, there are, and each alternative confronts you with important trade-offs that affect the efficiency and reproducibility of your code. Consider these tables: 




```r
table1
##       country year  cases population
## 1 Afghanistan 1999    745   19987071
## 2 Afghanistan 2000   2666   20595360
## 3      Brazil 1999  37737  172006362
## 4      Brazil 2000  80488  174504898
## 5       China 1999 212258 1272915272
## 6       China 2000 213766 1280428583
table2
##        country year       type      count
## 1  Afghanistan 1999      cases        745
## 2  Afghanistan 1999 population   19987071
## 3  Afghanistan 2000      cases       2666
## 4  Afghanistan 2000 population   20595360
## 5       Brazil 1999      cases      37737
## 6       Brazil 1999 population  172006362
## 7       Brazil 2000      cases      80488
## 8       Brazil 2000 population  174504898
## 9        China 1999      cases     212258
## 10       China 1999 population 1272915272
## 11       China 2000      cases     213766
## 12       China 2000 population 1280428583
table3 # count of cases
##       country   1999   2000
## 1 Afghanistan    745   2666
## 2      Brazil  37737  80488
## 3       China 212258 213766
table4 # population
##       country       1999       2000
## 1 Afghanistan   19987071   20595360
## 2      Brazil  172006362  174504898
## 3       China 1272915272 1280428583
```

Each shows the same data (counts of tuberculosis and total population for Afghanistan, Brazil, and China between 1999 and 2000), but each represents that data in a slightly different way, with slightly different consequences for your downstream workflow.  

So, what tabular format should we choose? Here, I would like to recommend what Hadley @Wickham2018 refers to as a _tidy_ format (that's `table1` above). For rectangular data to be in a tidy format, it must satisfy these three rules:

1. Each variable must have its own column.  
2. Each observation must have its own row.  
3. Each value must have its own cell.  

These are represented graphically in our toy table, as shown in Fig. \@ref(fig:r-tidy-data).  

<div class="figure" style="text-align: center">
<img src="images/r-tidy_df.png" alt="Graphical representation of tidy terms."  />
<p class="caption">(\#fig:r-tidy-data)Graphical representation of tidy terms.</p>
</div>

Why care about making your data tidy? As @Wickham points out, there are two primary reasons:

1. Having a consistent format for your data means you can rely on a consistent set of tools for managing it.  
2. Constraining each column to a single variable means you can take advantage of R's vectorized functions. For instance, if you are trying to scale and center a variable, you will find this easier to achieve if its values are contained in a single column rather than spread out across multiple columns. 

So, now we know what the tidy format is and why we should use it. The obvious question to ask next is how we actually get our data into that format. If you find yourself in the position of trying to get your data into a tidy format, this implies that it is currently _not_ in a tidy format, not necessarily _messy_, _per se_, just untidy. The two big ways that a dataset can be untidy are 

1. Having observations spread out across multiple rows (like `table2`).
2. Having variables spread out across multiple columns (like `table3` and `table4`).

Base R provides the `reshape()` function to tidy tables that commit these sins. Before reviewing this function, let's first be honest about it. It's poorly written (or at least, it's written with a very narrowly defined motivation, namely, longitudinal data), and it behaves in a very strange and usually frustrating way. For these reasons, I am reluctant to explain how to use it. It's a bit like teaching someone English using common expressions from Victorian England. But, I'm going to do it anyway, if only to make you familiar with it. So, hold your nose now and let's forge ahead. 

When you use `reshape()`, you are doing one of two things: (a) making the table _longer_ by _stacking_ columns containing values for the same variable, thus increasing the number of rows, or (b) making the table _wider_ by _unstacking_ columns containing values for multiple variables, thus increasing the number of columns. This is shown graphically in \@ref(fig:r-pivoting).

<div class="figure" style="text-align: center">
<img src="images/r-pivoting.png" alt="Graphical representation of reshaping a data.frame."  />
<p class="caption">(\#fig:r-pivoting)Graphical representation of reshaping a data.frame.</p>
</div>


As an example, let's consider `table3`, which has values of the `year` variable stored as column names, specifically `1999` and `2000`, and the values of the `cases` variable stored across both columns. To get this into a tidy format, we need to (a) combine those column _names_ into a single variable and place that variable in a column with the name _year_ and (b) combine the column _values_ into a single variable and place that variable in a column with the name _cases_. In terms of `reshape()` parameters, we need to do the following:

1. Point to the columns we are collapsing using the `varying` argument, 
2. Specify the name of the new column we are going to move the original column _names_ to using the `timevar` parameter,
2. Define the values of that column (which are the original column names) using the `times` parameter, 
2. Specify what column we are going to move the column _values_ to using the `v.names` argument, and
2. Specify the `direction` in which we are reshaping, in this case _long_. 


```r
long_table3 <- reshape(table3, 
                       varying = c('1999', '2000'), 
                       v.names = "cases", 
                       timevar = "year",
                       times = c(1999, 2000),
                       direction = "long")


long_table3
##            country year  cases id
## 1.1999 Afghanistan 1999    745  1
## 2.1999      Brazil 1999  37737  2
## 3.1999       China 1999 212258  3
## 1.2000 Afghanistan 2000   2666  1
## 2.2000      Brazil 2000  80488  2
## 3.2000       China 2000 213766  3
```

This has two unwanted side effects: (i) row names, which you should never ever use, and (ii) an additional `id` column, which is redundant considering we have the `country` column. Given the limitations of `reshape()`, it is not easy to address these side effects within the function call itself, so our best bet is to remove these manually like so:


```r
row.names(long_table3) <- NULL

long_table3$id <- NULL

long_table3
##       country year  cases
## 1 Afghanistan 1999    745
## 2      Brazil 1999  37737
## 3       China 1999 212258
## 4 Afghanistan 2000   2666
## 5      Brazil 2000  80488
## 6       China 2000 213766
```

It is rare that you will want or need to `reshape()` in the _wide_ direction, but here is an example just in case:


```r
wide_table3 <- reshape(long_table3,
                       v.names = "cases",
                       idvar = "country",
                       timevar = "year",
                       direction = "wide")

names(wide_table3) <- c("country", "1999", "2000")

wide_table3
##       country   1999   2000
## 1 Afghanistan    745   2666
## 2      Brazil  37737  80488
## 3       China 212258 213766
```

Basically, you are undoing the reverse of `reshape()` in the _long_ direction. You tell the function which column is providing the values of the new columns with `v.names`, which column is providing the names of the new columns with `timevar`, and which column is providing the objects being described by the data with `idvar`. Finally, you set `direction = "wide"`.   



## Transforming data

Let's start with something simple like changing the order of rows in a data.frame.

### Arrange  

On occasion you might want to re-order a data.frame, specifically changing the order in which rows appear. One would prefer that base R provide a simple function that does just that, taking a data.frame as input, along with a specification of which variable or variables should be used to re-order rows, and returning the re-ordered data.frame as output. Unfortunately, that does not exist. The base solution, thus, requires some finagling. Specifically, you need to create an index vector of the re-ordered rows and use that on the data.frame. To create the index vector, we use the `order()` function. The entire procedure looks like this:


```r
df <- data.frame("c1" = c(4, 3, 77, 19, 25),
                 "c2" = c("A", "B", "C", "D", "E"),
                 "c3" = c(TRUE, TRUE, FALSE, TRUE, FALSE))

# create index vector
i <- order(df$c1, decreasing = FALSE)

df$c1
## [1]  4  3 77 19 25
i
## [1] 2 1 4 5 3
df[i, ]
##   c1 c2    c3
## 2  3  B  TRUE
## 1  4  A  TRUE
## 4 19  D  TRUE
## 5 25  E FALSE
## 3 77  C FALSE
```

Note, that you can order by increasing values of the variable (`decreasing = FALSE`) or decreasing values of the variable (`increasing = TRUE`). 


```r
i <- order(df$c1, decreasing = TRUE)

i
## [1] 3 5 4 1 2
df[i, ]
##   c1 c2    c3
## 3 77  C FALSE
## 5 25  E FALSE
## 4 19  D  TRUE
## 1  4  A  TRUE
## 2  3  B  TRUE
```


### Change  

[`transform()`]  

### Filter  

[`subset()`]  

### Select  

[`subset()`]  

### Combine  

[`rbind()`, `cbind()`, `merge()`]  

<div class="figure" style="text-align: center">
<img src="images/r-join_dfs.png" alt="Results of different merge parameters and their SQL equivalents." width="90%" />
<p class="caption">(\#fig:r-join-dfs)Results of different merge parameters and their SQL equivalents.</p>
</div>

### Clean



