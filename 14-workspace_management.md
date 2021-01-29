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

## The Working Directory


## Data Import and Export

