# Vector Types {#vector-types}



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
<a href="https://en.wikipedia.org/wiki/Menagerie" target="_blank"><img src="images/r-menagerie.png" alt="The R Menagerie" width="100%" /></a>
<p class="caption">(\#fig:r-menagerie)The R Menagerie</p>
</div>

## Overview

<table class="table-intro table table-hover table-striped" style="margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Goal__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To familiarize students with the _ontology_ of the R Programming Environment. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> The beings of R are objects. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>R objects, specifically vectors,</li>
<li>how to create them,</li>
<li>what kinds there are, and</li>
<li>how to index them.</li>
</ol> </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Datasets__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Requirements__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Further Reading__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [An Introduction to R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html) [@rcoreteam2020introduction]<br>[Advanced R](https://adv-r.hadley.nz/) [@Wickham2015advanced] </td>
  </tr>
</tbody>
</table>
 
R contains a variety of _objects_, the most notable being _functions_ and _vectors_. These live in the R _environment_ (environments, actually). While there is a lot to say about functions and environments, those are mostly super-class 'A' R programming topics, verboten for an introductory text. The bulk of this chapter will, thus, be devoted to vectors. 

Vectors can take a number of different forms, for example, scalars and lists (see Fig. \@ref(fig:r-objects)). In a sense (a slightly misleading sense), these objects are vessels that hold different _data types_, the four primary ones being integer, double (i.e., fractions), logical, and character. Putting effort into understanding these vector forms and data types might at first blush feel like a foolhardy pursuit of the inconsequential and esoteric, a task best relegated to crusty old philosophers. It is, however, of the utmost importance, for the different statistical questions you might want to ask will require data in one or the other form and type to answer. If, for example, you want to get the mean of some distribution, say the average height of actors who auditioned for the part of Aragorn in the timeless cinematic classic _Lord of the Rings_, you will only need a simple vector of double values. If, however, you want to know whether height varies as a function of diet, you will want a more complex object, specifically a data.frame. And, if you prefer order to chaos, you will surely enjoy lists.  

<div class="figure" style="text-align: center">
<img src="images/r-objects.png" alt="One possible phylogeny of R objects." width="75%" />
<p class="caption">(\#fig:r-objects)One possible phylogeny of R objects.</p>
</div>

<br>

Fig. \@ref(fig:r-objects) might seem a little overwhelming at first, but don't let it intimidate you. Its meaning will become clear as we proceed. 


## Data types

There are four primary data types in R: integer, double, logical, and character. The first two are probably more important for statistics, the latter two for data processing (or 'wrangling', as it is often called). We will not discuss any of these in great detail here, pausing only to mention very briefly what each is, how to make them, how to catch one in the wild, and what they are for.  

As an honorable mention, we will also discuss _factors_ here. These are not strictly their own data type,^[They are actually just integers.] but they are ubiquitous and utilized quite often in statistical analyses. So, we'll treat them as an honorary data type in their own right, on a level with the others (even if they aren't, technically).

<br>

### Integer

_What is it?_ A whole number or a number without a fractional component (like 1 as opposed to 1.3).  

_What is it for?_ Counting things! For example, how many students are in this class? One would hope the answer to that is an integer.

_How do you make one?_ By appending an `L` to a number.  


```r
my_integer <- 3L
```

<br>

_How to catch one in the wild?_ By asking "Is this an integer?"


```r
is.integer(4.2)
## [1] FALSE
is.integer(my_integer)
## [1] TRUE
```

<br>

### Double

_What is it?_ A number with a fractional component (like 1.3 as opposed to 1).  

_What is it for?_ Measuring things! For example, how much coffee did I have this morning? Or, how much did it rain last year in Pasquotank County, North Carolina?

_How do you make one?_ By typing a number (with or without a fraction, but no `L`).  


```r
my_double <- 3.2
```

<br>

_How to catch one in the wild?_ By asking "Is this a double?"


```r
is.double(3L)
## [1] FALSE
is.double(my_double)
## [1] TRUE
```

<br>

### Character

_What is it?_ A string of symbols used to construct words in a natural language (by default, English letters).  

_What is it for?_ Saying things! For example, how many students are in this class? One would hope the answer to that is an integer.

_How do you make one?_ By quoting it, i.e., surrounding a string with double `"` or single `'` apostrophes.  


```r
my_character <- 'quotidian'
```

A quick warning: if you do not surround the character with apostrophes, R will think you are trying to call an object with that name. If that object does not exist, R will protest. 


```r
quotidian
#### Error in eval(expr, envir, enclos): object 'quotidian' not found
```

Similarly, if you use quote marks around a named object, R treats it as a character string, rather than a call to the object.


```r
"my_integer"
## [1] "my_integer"
my_integer
## [1] 3
```

<br>

_How to catch one in the wild?_ By asking "Is this a character?"


```r
is.character(4.2)
## [1] FALSE
is.character(my_character)
## [1] TRUE
```

<br>

### Logical

_What is it?_ A truth condition, i.e., TRUE or FALSE. Also known as a _boolean_.  

_What is it for?_ Implying things! Specifically, making conditional or hypothetical claims. For example, if it rains today, I will take my umbrella. Or, closer to home, "Hi R, if this is an integer, please add one to it." 

_How do you make one?_ By typing `TRUE`, `FALSE`, `T`, or `F`.  


```r
my_logical <- TRUE
```

You can also create logicals in R using statements that R can evaluate for their truth or falsity. For example,


```r
# is 2 greater than 5?
2 > 5
## [1] FALSE
# is 7 greater than or equal to itself?
7 >= 7
## [1] TRUE
# is 'cat' the same string as 'hat'
'cat' == 'hat'
## [1] FALSE
```

And the truth conditions of these statements can, of course, be assigned to names.


```r
jim_bob <- 'cat' == 'hat'
```

<br>

_How to catch one in the wild?_ By asking "Is this _a_ logical?"


```r
is.logical(my_double) 
## [1] FALSE
is.logical(my_logical)
## [1] TRUE
```

Did you notice that our `is.*` functions all return a `logical`?

<br>

### Factors

_What is it?_ Categories, typically represented in R as character strings with "levels."

_What is it for?_ Categorizing things! For example, "Tom is a _feline_" or "Jerry is a _mouse_."

_How do you make one?_ With the function `factor()`.


```r
my_factor <- factor("Australian")
```


```r
my_factor
## [1] Australian
## Levels: Australian
```

Notice that unlike a simple character, a factor has "levels." These levels are the categories of the factor variable. A good example is nationality. Nationality is a factor, with the specific levels or categories of that factor including, for instance, _American_, _Australian_, _Chinese_, and _French_.  

_How to catch one in the wild?_ By asking "Is this _a_ factor?"


```r
is.factor("quotidian")
## [1] FALSE
is.factor(my_factor)
## [1] TRUE
```

## Vector types

Vectors come in two general flavors: atomic and complex. These differ in one crucial respect. While atomic vectors are limited to one data type, complex vectors can contain many data types. As shown in Fig. \@ref(fig:r-objects), atomic vectors include scalars, vectors, and matrices. Complex vectors include lists and data.frames. 

<br>

### Scalar

A scalar-vector is an atomic vector that contains only one element. Hence, by definition, it can include only one data type. Here, we represent this with a square, which includes a value and is color-coded by its data type.

<img src="images/r-objects_scalar.png" width="30%" style="display: block; margin: auto;" />

Note that all the examples we have used so far have been scalar vectors. You can check this using the `length()` function.


```r
length(my_integer)
## [1] 1
```

<br>

### Vector

A vector-vector is an atomic vector that contains multiple elements. These multi-scalar atomic vectors do not really have a name like "list" or "scalar," but in common R parlance the word 'vector' is often used as a synonym, which is a tad confusing, like "Are you going to New York (the state) or New York (the city)?" In what follows, we'll just cross our fingers and hope the context is sufficient to tell the difference.

<img src="images/r-objects_vector.png" width="30%" style="display: block; margin: auto;" />

The standard way to create one of these is to use the concatenate function on scalars `c()`.


```r
my_vector <- c(1, 2, 3, 4, 5)

length(my_vector)
## [1] 5
```

Of course, you can have a vector of any data type, it just cannot be the case that any vector contains multiple data types.


```r
integer_vector <- c(1L, 2L, 3L, 4L, 5L)

double_vector <- c(1.1, 0.2, 3.1, 4, 5.2)

character_vector <- c('a', 'b', 'c', 'd', 'e')

logical_vector <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
```

What happens if you try to create a vector with different data types?


```r
c(1, 'a', TRUE)
## [1] "1"    "a"    "TRUE"
```

It converted them all to character strings! This is known as _implicit coercion_. It is a way of ensuring that all vector-vectors are atomic.

<br>

### Matrix

A matrix-vector is an atomic vector with _dimensions_, meaning the vector is "folded," so to speak, into rows and columns. As you can see, a matrix has the shape of a data table, like what you would find in an Excel spreadsheet.

<img src="images/r-objects_matrix.png" width="30%" style="display: block; margin: auto;" />

To create a matrix, you use the `matrix()` function by providing it with a vector and then specifying the number of rows and columns it should have.


```r
my_matrix <- matrix(my_vector, 
                    nrow = 2,  # number of rows
                    ncol = 3)  # number of columns

my_matrix
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    1
```

The odd, bracketed numbers printed above and to the left of the matrix are known as _subscripts_. They are like numeric names for columns and rows that can be used to reference specific locations in the matrix. For example, row one is `[1,]`, and column two is `[,2]`. So, if I want to refer to the cell containing the value `3`, I use `[1,2]`. 

If you want to know how many rows and columns a matrix has, you can use `nrow` and `ncol`.


```r
ncol(my_matrix)
## [1] 3
```


<br>

### List

A list-vector is a complex vector that may include other vectors of any data type and length. The gray box around each vector in the figure below is meant to suggest that the list is a single complex vector made up of other vectors, and the space between each vector is meant to show that they are still separate components of the list, unconstrained by the other components. So, yeah, a list...

<img src="images/r-objects_lists.png" width="30%" style="display: block; margin: auto;" />

To create a list, use the `list()` function and supply it with vectors. Be sure to assign list-names using the `name = vector` syntax.


```r
my_list <- list('c1' = c(1L, 2L, 3L, 4L),
                'c2' = double_vector,
                'c3' = c('a', 'b', 'c'),
                'c4' = c(TRUE, TRUE))

my_list
## $c1
## [1] 1 2 3 4
## 
## $c2
## [1] 1.1 0.2 3.1 4.0 5.2
## 
## $c3
## [1] "a" "b" "c"
## 
## $c4
## [1] TRUE TRUE
```

Each vector in the list is called a component. You can find out what list-names these components have using the `names()` function, which returns a character vector.


```r
names(my_list)
## [1] "c1" "c2" "c3" "c4"
```

You can also assign new names to a list with `names()` and the assignment arrow `<-`. 


```r
names(my_list) <- c("A", "B", "C", "D")

names(my_list)
## [1] "A" "B" "C" "D"
```


Now, we said above that lists can contain any vector type, and this is true. Lists can even contain other lists!


```r
my_super_list <- list('e' = my_list,
                      'f' = my_logical)
```

In this sense, you will sometimes hear people refer to lists as _recursive_ vectors [@rcoreteam2020introduction].  

<br>

### Data.frame

A data.frame-vector is a special sort of list with a super-restriction on it: all the vectors it includes must be of the same length. It is also not recursive.

<img src="images/r-objects_df.png" width="30%" style="display: block; margin: auto;" />

<br>

To create a data.frame, use the `data.frame()` function, supplying it with `name = vector` arguments as you would with `list()`.


```r
my_dataframe <- data.frame('c1' = integer_vector,
                           'c2' = double_vector,
                           'c3' = character_vector,
                           'c4' = logical_vector)

my_dataframe
##   c1  c2 c3    c4
## 1  1 1.1  a  TRUE
## 2  2 0.2  b  TRUE
## 3  3 3.1  c FALSE
## 4  4 4.0  d FALSE
## 5  5 5.2  e  TRUE
```

Notice that when you create the data.frame, the vectors become named columns. To extract those names, we can again use the `names()` function.


```r
names(my_dataframe)
## [1] "c1" "c2" "c3" "c4"
```

As with a matrix, you can also get the number of columns and rows with `nrow` and `ncol`.


```r
nrow(my_dataframe)
## [1] 5
```

## Coercion

R provides tools for transforming objects of one data or vector type to other data and vector types. This is known as _coercion_, which you were introduced to above in the form of _implicit_ coercion. But, what about _explicit_ coercion, meaning coercion you declare explicitly with R code? Well, R provides several functions for this, all having the form `as.*()` where the `*` is replaced with the name of the type that you wish to coerce your object to. 

Why care about coercion? Well, when it comes to coercion of data type, perhaps the most important reason is that you do not want to mistakenly compare apples and oranges. R's implicit coercion rules.

__Data Type Coercion__

Here is an example of data type coercion from integer to character.


```r
a_new_character <- as.character(integer_vector)

a_new_character
## [1] "1" "2" "3" "4" "5"
is.integer(a_new_character)
## [1] FALSE
```

As you see, it surrounds the numerals with quotation marks, indicating these are now character strings. Other data type coercion functions include `as.integer()`, `as.numeric()`, `as.logical()`, and `as.factor()`. But, notice that R can be somewhat finicky about this. I mean, converting from logical, numeric, or integer to character is obvious. Just wrap the elements in quotes. But, what should R do when you ask it to convert integers to logicals or doubles to integer? 


```r
double_vector
## [1] 1.1 0.2 3.1 4.0 5.2
as.integer(double_vector)
## [1] 1 0 3 4 5
```

In this case, it rounds the decimals to whole numbers.

__Vector Type Coercion__


```r
a_new_list <- as.list(my_dataframe)

a_new_list
## $c1
## [1] 1 2 3 4 5
## 
## $c2
## [1] 1.1 0.2 3.1 4.0 5.2
## 
## $c3
## [1] "a" "b" "c" "d" "e"
## 
## $c4
## [1]  TRUE  TRUE FALSE FALSE  TRUE
is.data.frame(a_new_list)
## [1] FALSE
```








## Environments

So, we now know how to create an object in R, but when we do, _where does it go_?!!! This is a question that a lot of smart people find themselves asking when first learning about R. While the answer is a tad on the esoteric side, it is perhaps useful to peel back the curtain ever so slightly, so you can see what is happening when you create an object in R. To do that, we need to talk about environments, in particular, the "global" environment or "workspace." You can think of an environment like the workspace as a special sort of named list. 


```r
bob <- list(a = 1:5,
            b = LETTERS[1:10],
            c = "quotidian",
            d = TRUE)

# coerce list to environment object
digital_zoo <- as.environment(bob)
```

When you create an object, you do not have to go through these steps explicitly for R adds objects assigned to names to your global environment by default. The key here is just to recognize that when you use `<-`, you are in effect adding an element to a list, the environment list. 

If you want to know what all lives in your R environment, you can try `ls()`, which works like `names()` does for lists, printing the names of its denizens.


```r
ls(digital_zoo)
## [1] "a" "b" "c" "d"
```

As a general rule, you should keep your environments clean and orderly. This will help prevent you from making careless mistakes (like running operations on the wrong objects) and also make it easier to manage your workflow. One way to do this is to let go of objects that you will not re-use - meaning, you should banish them from your environment. This is achieved with the `rm()` function.


```r
rm(a, envir = digital_zoo) # read this as: remove object a from the digital zoo environment
```

When you're removing objects from your global environment or workspace (and not the toy environment that I just created as an example), it is sufficient simply to type `rm(<object>)` without specifying the environment, since it defaults to the global environment anyway.  

