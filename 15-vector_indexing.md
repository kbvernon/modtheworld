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






## Exploring your data

## Indexing your data

You will often need to access specific elements of a vector you have created, rather than use the whole vector itself. To do access those elements, however, we need some way of referring to or _indexing_ them. That's where _indexing vectors_ come in, which we supply to the object we want to index using the single brackets operator `[`. Strictly speaking you can use any data type to define an indexing vector, but the three that are most useful (and really the only three you should ever use) are:

- __Integer__. This indexes by _position_.  
- __Logical__. This indexes by _condition_.  
- __Character__. This indexes by _name_.  


### Integer Indexing

With integer indexing, you select elements by their literal position in a vector (see \@ref(fig:r-objects_vector_position)).

<img src="images/r-objects_vector_position.png" width="30%" style="display: block; margin: auto;" />

As you see, this contains five scalars (the letters 'a' through 'b'), with the position of each just being a numbered location, starting with one for the first scalar and increasing by one for each additional scalar. We can create this vector in the usual way.


```r
a_vector <- c('a', 'b', 'c', 'd', 'e')
```

Now, we can create an integer index, `i`, and apply it to our vector like so.


```r
i <- 3

a_vector[i]
## [1] "c"
```

We can also provide multiple integers as an index.


```r
i <- c(1, 3, 5)

a_vector[i]
## [1] "a" "c" "e"
```

For brevity, we can also supply the vector directly.


```r
a_vector[3]

a_vector[c(1, 3, 5)]
```

Finally, we can also supply _negative_ integers to identify positions we do _not_ want to return.


```r
a_vector[-i]
## [1] "b" "d"
```


### Logical Indexing

With logical indexing, you are indexing a vector according to a condition, such that each element in the vector that satisfies that condition is returned and each element that fails is discarded. How do we evaluate elements in a vector according to a condition? By including the vector in a statement that R can evaluate for its truth or falsity. The result is a logical vector, which can be used as our logical index.

Consider this numeric vector:


```r
a_vector <- c(1.1, 0.2, 3.1, 4, 5.2)
```

Now, perhaps, we want to return only those elements that are, say, greater than 3. 


```r
i <- a_vector > 3

i
## [1] FALSE FALSE  TRUE  TRUE  TRUE
a_vector[i]
## [1] 3.1 4.0 5.2
```

As before, we can supply the logical condition directly with `a_vector[a_vector > 3]`. And we can  invert our logical condition using the negation operator, `!` (sometimes pronounced "bang").


```r
!i
## [1]  TRUE  TRUE FALSE FALSE FALSE
a_vector[!i]
## [1] 1.1 0.2
```


\BeginKnitrBlock{rmdnote}<div class="rmdnote">Logical indexing offers an important advantage over integer indexing, namely, that you do not have to know the exact position of elements beforehand. This is especially true when your vectors are quite large. I mean, just try and appreciate the difficulty that would surely accompany specifying the position of more than ten elements, more than one hundred elements, or even a thousand! No thanks.</div>\EndKnitrBlock{rmdnote}

### Character Indexing

With character indexing, you reference objects in a vector by their given name. Suppose, for example, that our toy vector came with these names: 


```r
avengers <- c("spiderman", "blackwidow", "hulk", "ironman", "scarlet_witch")

names(a_vector) <- avengers
```

We could then assemble a subset of our vector by defining a character index.


```r
i <- c("spiderman", "blackwidow", "ironman") 

a_vector[i] # Natasha Lives
##  spiderman blackwidow    ironman 
##        1.1        0.2        4.0
```

\BeginKnitrBlock{rmdnote}<div class="rmdnote">For completeness, it is perhaps worth noting that indexing with a blank space " ", as in `a_vector[ ]`, indexes _every_ element in the vector.</div>\EndKnitrBlock{rmdnote}

### Assignment and Replacement

Now that we know how to index into a vector, it's worth pausing briefly to think about what we can do with our index. For one, we can use them to assign the indexed elements to a new object.


```r
new_object <- a_vector[i]
```

But, less obviously, we can replace the indexed elements with new ones.


```r
a_vector[i] <- c(2.3, 4.1, 3.8)
```

### Complex Indexing

What about complex vectors, like matrices, lists, and data.frames?


```r
integer_vector <- c(1L, 2L, 3L, 4L, 5L)

double_vector <- c(1.1, 0.2, 3.1, 4, 5.2)

character_vector <- c('a', 'b', 'c', 'd', 'e')

logical_vector <- c(TRUE, TRUE, FALSE, FALSE, TRUE)

my_vector <- c(1, 2, 3, 4, 5)

my_matrix <- matrix(my_vector, nrow = 2, ncol = 3)

my_list <- list('c1' = c(1L, 2L, 3L, 4L),
                'c2' = double_vector,
                'c3' = c('a', 'b', 'c'),
                'c4' = c(TRUE, TRUE))

my_dataframe <- data.frame('c1' = integer_vector,
                           'c2' = double_vector,
                           'c3' = character_vector,
                           'c4' = logical_vector)
```






### Matrix

Because a matrix has "dimensions," a unique index requires a little more work. As noted above, we need to specify both the row and column subscripts. Well, actually, if you specify no row, but just a column, R will return _all_ rows. Similarly, if you specify one row, but no columns, R will return _all_ columns. Some examples,


```r
# just a reminder
my_matrix
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    1
my_matrix[1, 2]
## [1] 3
my_matrix[1, ]
## [1] 1 3 5
my_matrix[, 3]
## [1] 5 1
```

Note that indexing a matrix in this way returns a vector. In fact, when you index a matrix, you are, in effect, unfolding its vector.


### List

List _components_ have positions like scalars in a vector, so you can access them with `[` in the same way.


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
```

Note that this simply returns a smaller list. What if we wanted just a vector back? This is the purpose of the double-brackets `[[`.


```r
my_list[[2]]
## [1] 1.1 0.2 3.1 4.0 5.2
```

The dollar `$` does the same thing. Returning one of the vectors initially used to create the list. Here, however, instead of providing the numeric position of the component, you supply the name of the desired component in the list.  


```r
my_list$c2
## [1] 1.1 0.2 3.1 4.0 5.2
```

Now, because these return a vector, we can also subset that with `[`!


```r
my_list[[2]][3]
## [1] 3.1
```

This is R reminding you that a list has "depth," that it is a vector of vectors (of vectors of vectors...).

### Data.frame

A data.frame is indexed like a matrix, with subscripts for rows and columns.


```r
my_dataframe[2, 4]
## [1] TRUE
my_dataframe[1, ]
##   c1  c2 c3   c4
## 1  1 1.1  a TRUE
my_dataframe[, 3]
## [1] "a" "b" "c" "d" "e"
```

Notice that when you index a row, it returns a data.frame with just that row, but when you index a column, it returns the vector that column contains.


```r
# my_dataframe[, 3] is equivalent to

my_dataframe$c3
## [1] "a" "b" "c" "d" "e"
```
