# Vector Indexing {#vector-indexing}



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






## Overview

<table class="table-intro table table-hover table-striped" style="margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Goal__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To explain how to index vectors. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Like when you use your index finger to _point_ at something. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>vectors used for indexing (here called _indexing vectors_), and</li>
<li>how to use them to index atomic and complex vectors.</li>
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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
</tbody>
</table>

Consider these scenarios: 

* You have a global dataset detailing movie theater attendance rates for the last decade, but you want to compare trends in Brazil to those in, say, France.
* You have an enormous pollen record going back some 15,000 years, but you're only interested in the terminal Pleistocene (say, 11 to 10,000 years ago).
* You have age and mortality data for all of the United States, but you have discovered that your Utah data has some errors, which you need to fix.  

To achieve any of these goals, whether to retrieve data or update it, you need a way of _referring to the relevant parts_ of your complete dataset. This is known as _indexing_. While R provides many tools and methods for indexing vectors, the core method involves three essential ingredients: 

1. A vector to be _indexed_ (obviously), 
2. Brackets, either single `[` or double `[[`, and
3. A vector for _indexing_, which we'll refer to here as an _indexing vector_ and denote with `i`.

The basic syntax is this:

```r
a_vector[i]
```

So, you have your vector name, which is immediately followed by brackets (no spaces), and those brackets contain the indexing vector.  

## Index vector types

There is some subtlety to the use of brackets, but for now just focus on the indexing vector. Ask yourself, specifically, _What do we know about vectors_? Well, we know for one thing that a vector can hold different data types (e.g., character, numeric, logical, etc.). This fact alone should clue you into something important about indexing vectors, namely, that we can define them using different data types. In fact, you can, strictly speaking, use _any_ data type to define one. However, the three that are most useful (and the three that you will use most often) are:

- __Integer__, which indexes by _position_.  
- __Character__, which indexes by _name_.  
- __Logical__, which indexes by _condition_.  

Let's walk through some examples of each.


### Integer Indexing

With integer indexing, you select elements by their literal or numeric position in a vector (see Fig. \@ref(fig:r-vector-position)).

<div class="figure" style="text-align: center">
<img src="images/r-objects_vector_position.png" alt="Using brackets, `[]`, and a vector, `4`, to index the fourth element, `'d'`." width="30%" />
<p class="caption">(\#fig:r-vector-position)Using brackets, `[]`, and a vector, `4`, to index the fourth element, `'d'`.</p>
</div>

As you can see, this contains five scalars (the letters 'a' through 'b'), with the position of each just being a numbered location, starting with one for the first scalar and increasing by one for each additional scalar. We can create this vector in the usual way.


```r
a_vector <- c('a', 'b', 'c', 'd', 'e')
```

Now, we can create an integer index, `i`, and apply it to our vector like so.


```r
i <- 4

a_vector[i]
## [1] "d"
```

We can also provide multiple integers as an index.


```r
i <- c(1, 3, 5)

a_vector[i]
## [1] "a" "c" "e"
```

For brevity, we can also supply the indexing vectors directly.


```r
a_vector[4]
## [1] "d"
a_vector[c(1, 3, 5)]
## [1] "a" "c" "e"
```

Because these are numbers, we can also perform arithmetic operations on them (like addition and subtraction) to get new indexing vectors. (Note that the parentheses are not necessary and are only added to increase readability.)


```r
i <- (4 - 1) 

a_vector[i]
## [1] "c"
```


Finally, we can also supply _negative_ integers to identify positions we do _not_ want to return.


```r
i <- 2

a_vector[-i]
## [1] "a" "c" "d" "e"
```


### Character Indexing

With character indexing, you reference objects in a vector by their given name. Suppose, for example, that our toy vector came with these names: 


```r
avengers <- c("spiderman", "blackwidow", "hulk", "ironman", "scarlet_witch")

names(a_vector) <- avengers
```

We could then assemble a subset of our vector by defining a character index like so.


```r
i <- c("spiderman", "blackwidow", "ironman") 

a_vector[i] # Natasha Lives
##  spiderman blackwidow    ironman 
##        "a"        "b"        "d"
```

Note that this also prints the vector names.


### Logical Indexing

Perhaps the most powerful form of indexing is logical indexing. With it, you are indexing a vector according to a condition, such that each element in the vector that satisfies that condition is returned and each element that fails is discarded. How do we evaluate elements in a vector according to a condition? By including the vector in a statement that R can evaluate for its truth or falsity. The result is a logical vector, which can be used as our logical index.  

Consider this numeric vector:


```r
a_vector <- c(1.1, 0.2, 3.1, 4, 5.2)
```

Now, perhaps, we want to return only those elements that are, say, greater than 3. 


```r
i <- (a_vector > 3)

i
## [1] FALSE FALSE  TRUE  TRUE  TRUE
a_vector[i]
## [1] 3.1 4.0 5.2
```

As before, we can supply the logical condition directly with `a_vector[a_vector > 3]`. We can also invert our logical condition using the negation operator, `!` (sometimes pronounced "bang"), similar to how `-` works for numeric vectors.


```r
!i
## [1]  TRUE  TRUE FALSE FALSE FALSE
a_vector[!i]
## [1] 1.1 0.2
```

Logical indexing offers an important advantage over integer indexing, namely, that you do not have to know the exact position of elements beforehand. This is especially true when your vectors are quite large. I mean, just try and appreciate the difficulty that would surely accompany manually specifying the position of more than ten elements, more than one hundred elements, or even a thousand! No thanks.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">For completeness, it is perhaps worth noting that indexing with a blank space " ", as in `a_vector[ ]`, indexes _every_ element in the vector.</div>\EndKnitrBlock{rmdnote}


### R functions

Because many R functions return integer, character, and logical vectors, we can also use them to define our indexing vectors, rather than specifying those manually. For example, you can use `length()` to index the last element of a vector.


```r
i <- length(a_vector)

i
## [1] 5
a_vector[i]
## [1] 5.2
```



## Assignment and Replacement

Now that we know how to index into a vector, it's worth pausing briefly to think about what we can do with our index. For starters, we can use them to assign the indexed elements to a new object.


```r
i <- c(1, 3, 5)

new_object <- a_vector[i]
```

But, less obviously, we can replace the indexed elements with new ones.


```r
a_vector[i] <- c(2.3, 4.1, 3.8)
```

We'll give some more examples of this below.  


## Complex Indexing

What about complex vectors, like matrices, lists, and data.frames? For demonstration purposes, let's reuse our vectors from a previous chapter to define examples of these complex vector types.


```r
integer_vector <- c(1L, 2L, 3L, 4L, 5L)

double_vector <- c(1.1, 0.2, 3.1, 4, 5.2)

character_vector <- c('a', 'b', 'c', 'd', 'e')

logical_vector <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
```


### Matrix


```r
my_matrix <- matrix(integer_vector, 
                    nrow = 2, 
                    ncol = 3,
                    byrow = TRUE)

my_matrix
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    1
```

As you see, a matrix has "dimensions," meaning rows and columns. Thus, specifying a unique index requires a little more thought, for depending on your needs, you can return an entire row(s), an entire column(s), or specific cells. The trick is to know how to refer to rows and columns within your brackets `[ ]`. This is achieved by separating rows and columns with a comma, with row index coming first, column index second. In dummy code, that looks like this:

```r
matrix[row, column]
```

When it comes to indexing matrices, the basic rules are these:

1. Specifying _a single row AND a single column_ will return a scalar vector.  
2. Specifying _a single row OR a single column_ will return a vector.
2. Specifying _multiple rows AND/OR multiple columns_ will return a matrix.

These are somewhat intuitive, but here are some examples too.  


```r
row_i <- 1
col_i <- 2

my_matrix[row_i, col_i]
## [1] 2
my_matrix[row_i, ]
## [1] 1 2 3
my_matrix[, col_i]
## [1] 2 5
# multiple columns
my_matrix[, c(2, 3)]
##      [,1] [,2]
## [1,]    2    3
## [2,]    5    1
```

As noted above, once we have these indices, we can use them to replace the values at the specified positions.


```r
my_matrix[row_i, ] <- c(7, 8, 9)

my_matrix
##      [,1] [,2] [,3]
## [1,]    7    8    9
## [2,]    4    5    1
```



### Data.frame


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

A data.frame is indexed like a matrix, and has very similar, though importantly different, rules for indexing rows and columns:

1. Specifying _a single row AND a single column_ will return a scalar vector.  
2. Specifying _a single row_ will return a data.frame.
2. Specifying _a single column_ will return a vector.
2. Specifying _multiple rows AND/OR multiple columns_ will return a data.frame.



```r
row_i <- 2
col_i <- 3

my_dataframe[row_i, col_i]
## [1] "b"
my_dataframe[row_i, ]
##   c1  c2 c3   c4
## 2  2 0.2  b TRUE
my_dataframe[, col_i]
## [1] "a" "b" "c" "d" "e"
my_dataframe[c(2, 3), c(2, 4)]
##    c2    c4
## 2 0.2  TRUE
## 3 3.1 FALSE
```

Note, too, that you can index a column by its name:


```r
my_dataframe[, "c3"]
## [1] "a" "b" "c" "d" "e"
```

To say the same thing in a slightly different way, R provides the very useful dollar operator `$`:


```r
my_dataframe$c3
## [1] "a" "b" "c" "d" "e"
```

As with matrices and other vectors, we can leverage these indexing techniques to replace values.


```r
my_dataframe[c(2, 3), 'c3'] <- c("X", "Y")

my_dataframe
##   c1  c2 c3    c4
## 1  1 1.1  a  TRUE
## 2  2 0.2  X  TRUE
## 3  3 3.1  Y FALSE
## 4  4 4.0  d FALSE
## 5  5 5.2  e  TRUE
```

But, remember the super-rule for data.frames! Columns must be vectors of the same length!


```r
my_dataframe$c3 <- c(1, 5, 7, 8, 10, 25)
#### Error in `$<-.data.frame`(`*tmp*`, c3, value = c(1, 5, 7, 8, 10, 25)): replacement has 6 rows, data has 5
```

Being able to access a specific column of a data.frame in this way also means you can index rows _by that specific column_. You might, for example, want the rows of `my_dataframe` where the double column, `c2`, is greater than 2:


```r
row_i <- (my_dataframe$c2 > 2)

row_i
## [1] FALSE FALSE  TRUE  TRUE  TRUE
my_dataframe[row_i, ]
##   c1  c2 c3    c4
## 3  3 3.1  Y FALSE
## 4  4 4.0  d FALSE
## 5  5 5.2  e  TRUE
```

This example only skims the surface of indexing and subsetting tabular data in R, but don't worry! We'll devote all of [Chapter 11: Data Wrangling](#data-wrangling) to that very important topic. 


### List


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

List _components_ have positions like scalars in a vector, so you can access them with `[` in the same way, using either name or position.


```r
my_list[c(1, 2, 3)]
## $c1
## [1] 1 2 3 4
## 
## $c2
## [1] 1.1 0.2 3.1 4.0 5.2
## 
## $c3
## [1] "a" "b" "c"
my_list[c('c1', 'c2', 'c3')]
## $c1
## [1] 1 2 3 4
## 
## $c2
## [1] 1.1 0.2 3.1 4.0 5.2
## 
## $c3
## [1] "a" "b" "c"
```

Note that this simply returns a smaller list. What if we wanted just a vector back? This is the purpose of the double-brackets `[[`, at least when the indexing vector is a scalar (i.e., a vector with a single value).  


```r
my_list[[2]]
## [1] 1.1 0.2 3.1 4.0 5.2
my_list[['c2']]
## [1] 1.1 0.2 3.1 4.0 5.2
```

The dollar operator `$` does the same thing. Returning one of the vectors initially used to create the list. Here, however, instead of providing the numeric position of the component, you supply the name of the desired component in the list, similar to how you would supply names of columns in a data.frame.  


```r
my_list$c2
## [1] 1.1 0.2 3.1 4.0 5.2
```

## Indexing indexed vectors

One last point is perhaps worth mentioning ever so briefly. Because the result of indexing is often a multi-valued vector or a more complex object like a list or data.frame, you can actually index the indexed vector. Meaning, it's turtles all the way down! 


```r
new_vector <- my_dataframe[, 3]

new_vector
## [1] "a" "X" "Y" "d" "e"
new_vector[2]
## [1] "X"
```

Can you think of a simpler (or more compact) way to write this? 

Now, here we go with lists:


```r
new_vector <- my_list[[2]]

new_vector
## [1] 1.1 0.2 3.1 4.0 5.2
new_vector[3]
## [1] 3.1
```

Is there a simplere way to write this? Sort of, but it's a tad unseemly:


```r
my_list[[2]][3]
## [1] 3.1
```

And, in fact, if we wanted to write some exceptionally heinous looking code, we could even:


```r
my_list$c5 <- my_list

my_list[['c5']][[2]][3] <- 75
```

But, try to avoid this. It gets really hard to follow what's actually happening. Can you describe this code does? 
