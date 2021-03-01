# Univariate Description {#univariate-description}



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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To learn how to model an outcome using properties of the outcome itself. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> For a single variable model, Expectation = central tendency, Error = variability. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>measures of central tendency, and</li>
<li>measures of variability.</li>
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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> NONE </td>
  </tr>
</tbody>
</table>

As a way of priming you for the topics we'll cover here, consider this somewhat bland adaptation of an already bland scenario. You have six balls, with four of them being red, two gray, as shown in Fig. \@ref(fig:balls-and-urn). You can think of these balls as being the result of an _experiment_, with the outcome of interest being their color. Let's stipulate, as well, that you have no information about _why_ they are these colors. You don't know, for example, that the author has a preference for dark reds and grays.    

<div class="figure" style="text-align: center">
<img src="images/balls_and_urn.png" alt="Colored balls and urn. Outcome of an unknown process." width="40%" />
<p class="caption">(\#fig:balls-and-urn)Colored balls and urn. Outcome of an unknown process.</p>
</div>

As part of this thought experiment, suppose we plop them in a jar, shake it up, then have you select one at random. Without looking, what color do you expect to draw? The answer, I hope, is red. Why? Because there are more of them! So, you are more _likely_ to draw red just by chance. Now, think about what you just did. Lacking any information about how this particular outcome came to be, you still managed to form a pretty reasonable expectation about it solely on the basis of the value it _tends_ toward or is _more likely to take_. This value of the outcome is commonly referred to as its __central tendency__, though you will sometimes hear it described as the _location_ of your data. As the name suggests, this is the value around which observations of your outcome tend to cluster.  

Fortunately, that is not the _only_ information we can extract from this scenario, for suppose now that we had you repeat this exercise, say, a hundred times, replacing the ball each time. How often do you think, having guessed red, that gray would actually be the color to come up? Roughly a third of the time, right? And, why is that? Because the _proportion_ of squares that are gray is one-third! That is to say, in spite of your expectation, and just by chance, you should draw a gray ball one-third of the time. Thus, you have won this additional bit of new knowledge, a precise, quantitative expectation about your own error, otherwise known as __variability__, _dispersion_ in the outcome, or your _uncertainty_. This is a measure not just of the actual but of the _expected_ disagreement between your estimate and the observed outcome.  

To make this a little more tangible and perhaps a little more relevant to you, think about how many hours of sleep you _tend_ to get each night. Whatever it happens to be, this number defines your, shall we say, slumbering expectation. Obviously, this is going to be affected by a lot of variables, like the oceans of coffee you regularly consume, or the way time seems to drag you, despite your protestations, into unavoidable collisions with looming deadlines. Even without that knowledge, though, you can still get a pretty good sense of your sleep _habits_ by looking just at your sleep _tendencies_.  

<div class="figure" style="text-align: center">
<img src="22-univariate_description_files/figure-html/sleep-pattern-1.png" alt="Observed hours of sleep per night over the last thirty days, relative to the expectation of seven hours of sleep per night." width="624" />
<p class="caption">(\#fig:sleep-pattern)Observed hours of sleep per night over the last thirty days, relative to the expectation of seven hours of sleep per night.</p>
</div>

You can even use that expectation to measure variability in the length of "great nature's second course," to quote one of the more infamous regicides. If you know, for example, that you tend to get seven hours of sleep each night, and you conveniently - at least for our purposes - recorded your hours of sleep over the last 30 days, your sleep pattern might look like that shown in Fig \@ref(fig:sleep-pattern). From these observations, you can see that your un-waking life tends to last between five and nine hours (nine blessed hours!) each night. This then allows you to formulate an expectation about your error, that it tends to be two hours more or two hours less than your expectation. We can actually say even more about your expected error, but we're building up to that!   

Just note for now all that you have already gleaned from these simple observations. In particular, you now have the makings of an empirical model. On the one hand, you have your expectation about the outcome, which you have identified with its central tendency. And, on the other hand, you have your expectation of the error, or uncertainty. Because these descriptions involve a single random variable, you have just engaged in what we will refer to as __univariate description__, defined as the building of a model of an outcome in terms of its central tendency and variability. Framed in terms of our fundamental formula

$$ y = E[y] + \epsilon $$
you have just specified that   

* $E[y] =$ central tendency and  
* $\epsilon \sim$ variability.

Obviously, this is going to take some unpacking.

Before we get to that, however, we need to emphasize two important limitations of these very simple univariate models, both owing to the fact that the models describe a _sample_ consisting of a _single variable_. First, because they describe a sample, they can only _approximate_ the true central tendency and variability of the _population_. And second, because the sample consists of a single variable, the models cannot in any meaningful sense _explain_ variability in the outcome. Why, you might wonder, did I sleep two more hours than expected that one Monday last month? Answering with "because that's what I did," while technically true, is not terribly informative. One might even describe it as being _viciously circular_. As we will learn later on, it also lacks _generality_, meaning I cannot use it to form an expectation about what will happen the _next time_ I go to sleep.  

That being said, univariate models offer us some powerful tools for getting a handle on our data. They'll also play an important role in how we evaluate more complex multivariate models later on, where the goal really is to explain variability in a population, so let's dive into just how exactly we generate these descriptions.  

\BeginKnitrBlock{rmdwarning}<div class="rmdwarning">Instead of using $y$ as our variable, we are going to switch to using $x$, as it is common when covering these topics to use that notation. However, nothing hangs on this, and if it helps, you can simply imagine that all the $x$'s are actually $y$'s.</div>\EndKnitrBlock{rmdwarning}


## Central tendency

The two most common measures of central tendency are the mean and the median. Their slightly less popular sibling is the mode, which is typically reserved for categorical data. 

### Mean

If you recall, we are defining our expectation for an outcome, $x$, in terms of its central tendency. In this case, we measure the central tendency using the mean, hence our expectation is: 

$$ E[x] = \mu $$

where $\mu$ is the __population mean__. Given the practical limitations of ever measuring this value directly, we must estimate it using the __sample mean__, by convention denoted $\bar{x}$. Suppose, for instance, we did a study of the sleep behavior of college students on US campuses, using a phone app to measure various aspects of their sleep through a normal semester. To keep this simple, we'll assume a sample size of ten. And the primary outcome we are measuring is hours of sleep per night.  




```r
x <- sample(population, size = 10)

x
##  [1] 6.96 7.53 5.04 7.65 9.70 5.97 8.04 5.84 5.94 6.26
```

Assuming that these are independent outcomes (that no student in our study affected the sleep habits of any other student in the study), we can measure the sample mean with this simple formula:


$$ \bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_{i} $$

where $n$ is the size of the sample and each $x_{i}$ is a value of an individual $i$ in the sample.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">The sample mean, $\bar{x}$, and the population mean, $\mu$, are calculated using the same function - it's just the average after all, but with slightly different notation. Where $\bar{x}$ uses small $n$ to denote the total number of individuals in a _sample_, $\mu$ uses big $N$ to denote the total number of individuals in a _population_.</div>\EndKnitrBlock{rmdnote}


```r
# number of observations in the sample
n <- length(x)

# sum of the observations
Ex <- sum(x)

# mean of the sample
(1/n) * Ex
## [1] 6.893
```

This can be done more compactly with the `mean()` function provided by base R.


```r
mean(x)
## [1] 6.893
```

This sample mean is our estimate of the population mean, it is the number of hours of sleep we expect a _typical_ college student to get. Of course, other details about a student might inform on whether they get more or less sleep than expected. You don't have to look all that hard for the usual suspects:  

* diet: are they, perhaps, subsisting on cheetos and soda?,  
* exercise: or lack thereof?, 
* stress: are they working two jobs? late on rent?, facing important deadlines?, 
* disease: are they sick or otherwise unwell?.  

These are all critical factors that will affect the amount of sleep an individual is getting. I'm sure you can come up with more with a little thought. Unfortunately, our study - our overly simplistic study - didn't give us that information! All we know is the amount of sleep per night reported in our sample, and that is the only basis we have for forming any expectation about the amount of sleep a random college student should get on any given night. But, don't let that get you down! Even if we had those other variables available and wanted to use them to explain some of that variation around the mean, we would still need the mean to do it!   

Note that you will on occasion encounter variables that include missing or `NA` values. Because we do not know those values, we cannot _technically_ know the mean of the variable. The function `mean()` registers this fact by returning `NA` in such cases. To avoid this, and to calculate the mean of the _known_ values of the variable, we can specify the parameter `na.rm = TRUE`, which means "remove the NA values before computing the value of the variable." 




```r
x_NA
##  [1] 6.96 5.04   NA 8.04 5.94 7.65 9.70   NA   NA 7.53 5.97 5.84 6.26   NA
mean(x_NA)
## [1] NA
mean(x_NA, na.rm = TRUE)
## [1] 6.893
```

<img src="22-univariate_description_files/figure-html/unnamed-chunk-11-1.png" width="192" style="display: block; margin: auto;" />




### Median

$$ 
med(x) =
\begin{cases}
  x\left[i = \frac{n+1}{2}\right] & \text{if n is odd} \\\\
  \frac{1}{2}\left(x\left[i = \frac{n}{2}\right] + x\left[i = \frac{n}{2}+1\right]\right) & \text{if n is even} 
\end{cases} 
$$

__Odd number of observations__




```r
# sort the value from lowest to highest
x <- sort(x_odd)

# count the number of values
n <- length(x)

# find the middle position
i <- (n + 1)/2

# now retrieve the value at that position
x[i]
## [1] 176.3583
```

But, there's actually a function for this in R.


```r
median(x_odd)
## [1] 176.3583
```

__Even number of observations__


```r
x <- sort(x_even)

n <- length(x)

i_left <- n/2
i_right <- i_left + 1

# now we find the value half way between 
# the center left and center right positions
(x[i_left] + x[i_right])/2
## [1] 180.1667
median(x)
## [1] 180.1667
```


### Mode



## Variability

<div class="figure" style="text-align: center">
<img src="22-univariate_description_files/figure-html/expected-error-1.png" alt="Expected error in sleep pattern." width="624" />
<p class="caption">(\#fig:expected-error)Expected error in sleep pattern.</p>
</div>

All samples are discrete, regardless of the nature of the population random variable!

### Variance

The expected amount of difference between (the square of) the observed and the mean values.

$\sigma^{2}$ = population variance

$s^{2}$ = sample variance


For discrete variables, the population variance is given by:

$$ \sigma^{2} = \frac{1}{N} \sum_{i=1}^{N} (x_{i}-\mu)^{2} $$


Sample variance is _always_ discrete, hence we define the sample variance as

$$ s^{2} = \frac{1}{n-1} \sum_{i=1}^{n} (x_{i} - \bar{x})^{2} $$


### Standard deviation




## Quantiles




