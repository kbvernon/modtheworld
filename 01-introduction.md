# Introduction {#intro}



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





This book provides an advanced introduction to doing statistics with R [@rcoreteam2020language], equipping the reader with the programming skills necessary to do statistics cheaply, efficiently - and perhaps most importantly - in a reproducible fashion.

## Who is this book for?

It is primarily geared toward students who have some familiarity with basic statistical concepts. In the United States, that would be advanced undergraduates and beginning graduate students. While it does cover much of the same ground as an introductory course, it covers those topics in greater detail and with an eye toward exploring those statistical concepts within R. The hope is that being a better R programmer will make you a better statistician and that being a better statistician will make you a better R programmer.    
 
## Why this book?

Lots of really good books on R and statistics exist, for example, 

- Cetinkaya-Rundel and Hardin (2020) "[Introduction to Modern Statistics](https://openintro-ims.netlify.app/)"
- Ismay and Kim (2020) "[Statistical Inference via Data Science](https://moderndive.com/index.html)"
- Phillips (2018) "[YaRrr! The Pirate's Guide to R](https://bookdown.org/ndphillips/YaRrr/)"
- Wickham and Grolemund (2017) "[R for Data Science](https://r4ds.had.co.nz/index.html)"

So, why write another one? The best way to answer that question is probably with the big idea motivating the book, specifically the intuition that statistics is, in the first place, a framework for building and evaluating _models_ of the world. This idea guides the book's layout and content, providing a fresh approach to statistics and statistical programming.

It may be juxtaposed with a common strategy for teaching introductory statistics, which goes something like this. First, you introduce students to some _descriptive_ statistics, beginning with properties of a single variable, including measures of its central tendency, its variability, and its shape and skew. From there, you move on to discussing various significance tests, like Student's T. Finally, you reach the topic of modeling, covering such things as ordinary least squares and perhaps generalized linear modeling. If you had to give it a name, you might call this breezy strategy the _Describe-Test-Model_ (DTM) paradigm of statistics pedagogy.  

As an alternative to DTM, this book adopts an _Everything-is-a-Model_ (EM) approach. EM has many advantages over DTM, but perhaps the two most important are these: 

1. __It is more intuitive__. It starts from the idea that when we use statistics, our primary goal is to understand an empirical (or _data generating_) process, be it the efficacy of a medical treatment, the causes of ocean fishery collapse, or simply differences in the height of actors who auditioned for the roles of Aragorn and Gimli in the timeless cinematic classic, _The Lord of the Rings_. We do that by first proposing a model of the target process (this is statistical description) and then to ask if our proposed model is better at describing that process than alternatives (this is statistical inference).  
2. __It emphasizes critical thinking__. A fundamental weakness of the DTM approach is its emphasis on rote learning. Students are trained to be, as it were, statistical _parrots_, able to reliably squawk "aark! t-test!" in the correct circumstances without ever understanding that test's _meaning_. By emphasizing statistical inference as a method for choosing between models, the EM approach invites the student to move beyond this simple statistical parroting, to actively think about what it is they are doing when they apply a statistical test.  
3. And, for the statistical purists out there, EM _ruthlessly_ enforces the distinction between statistical description and statistical inference.   

\BeginKnitrBlock{rmdnote}<div class="rmdnote">
To see how someone might take the EM approach and run off a cliff with it, have a look at Jonas Kristoffer Lindelov's very insightful and very enjoyable article [Common statistical tests are linear models (or: how to teach stats)](https://lindeloev.github.io/tests-as-linear/).
</div>\EndKnitrBlock{rmdnote}

Now, if I'm being honest, there are a few additional reasons to prefer this book over others. First, it's brief. That's because it doesn't try to do _everything_. At the end of the day, there's no substituting for the guiding hand of a thoughtful teacher. This book embraces that idea, offloading a lot of what is "unsaid" into the classroom. For instance, there's no discussion of how to install R! Second, the book does not shy away from mathematical notation, which seems to be more in vogue these days, though it does so sparingly. Third, it doesn't treat you like a child. As far as we are concerned, you're an adult, so we treat you like you one. Of course, that's not to say this book doesn't have a sense of humor. It very much does, which brings me to the final reason you should prefer this book. The humor in it is mine.  

## Pedagogy

To understand the pedagogy adopted here, consider by analogy the plight of an exchange student venturing abroad to learn a new language. What we might call the _pure inquiry-based approach_ to the student's situation would be to, well, parachute them into the heart of a foreign land, perhaps offering them a swift kick and a lackadaisical "good luck!" on their way out. Alternatively, we could adopt a _pure instructor-driven approach_. You know the kind, drills, repetition, and rote memorization, Monday Tuesday Wednesday Thursday Friday, always the same, until you've snuffed out the last spark of curiosity. With the former approach, the student will almost assuredly become hopelessly lost. With the latter, of course, they will simply check out.

To avoid these unwanted outcomes, we adopt a hybrid approach to teaching statistics and statistical programming in R, starting with traditional _instructor-driven_ factual knowledge to present basic R concepts and then moving to a more _inquiry-based_ or question-oriented approach^[It should be noted that we are not applying an inquiry-based approach in the strictest of senses, for we are not using "active" learning here. That is simply beyond the scope of what this document can deliver at the present time, though it is worth thinking more about integrating interactive programming into the text, using something like the [__learnr__](https://rstudio.github.io/learnr/index.html) package. Maybe a project for the future...] to explore statistical concepts. So, we provide the reader with some basic R scaffolding, which they can then extend and enrich through their question-directed, deep-dive into fundamental statistics.  

Of course, that's not to say that the R introduction is entirely declarative, or the statistics introduction entirely interrogative. For we encourage the reader to think about R programming tools in terms of how they complement the scientific method. And, we also provide explanations of statistical concepts, too. I mean, we're not going to ask the reader to interrogate their way from Pythagoras to R.A. Fisher. The idea is, instead, to always draw their attention to and ask them to think deeply about how one uses quantitative methods to choose between alternative statistical models of the underlying process we hope to understand.  

## The Abelson Principle

A lot of instruction in programming seems to focus on how one _must_ write it, without ever explaining how one _should_ write it. This is a mistake, akin to teaching someone to speak a language but not how to communicate with it effectively. We want to avoid this, so we provide a style guide right away ([Chapter 5](#r-style-guide)). Obviously, such a guide cannot avoid being _arbitrary_ (in the sense of lacking an objective "foundation"), but that doesn't mean it can't still be _reasonable_. To ensure its reasonableness, we emphasize with our guide the writing of code that promotes _reproducible_ research, where 'reproducibility' refers to the ability of different individuals to obtain the same or similar results when implementing the same or similar methods. 

With respect to reproducible programming, perhaps the most important thing you can do is ensure that your code satisfies what we refer to as the _Abelson Principle_^[Though a good alternative might be the [Apollo Principle](https://en.wikipedia.org/wiki/Apollonian_and_Dionysian)]:

> Programs must be written for people to read, and only incidentally for machines to execute.  
-Hal Abelson, _The Structure and Interpretation of Computer Programs_ 

To unpack that a little, we might say that R code should be (i) clear, (ii) concise, and (iii) organized.

i. __Clear__ code wears its meaning on its sleeve. While code can and often does get very complicated, one should always take care to ensure that discerning its intent is as easy as possible.
i. __Concise__ code sticks to the main purpose of the analysis and does not include extraneous operations.  
i. __Organized__ code has a clear order and direction. An outline is provided, and sections of the outline are clearly identified within the script.  

Throughout this book, we have tried, as far as possible, to satisfy this Abelson Principle. We also encourage the reader to do so as well.   


## Book layout

At its core, the book is designed to satisfy one mighty constraint. Specifically, it aims to cover content that _advanced_ students and instructors should - at least, hypothetically - be able to cover in a semester-length course (that's roughly 14 weeks in the United States). Our strategy for satisfying this time-constraint is twofold. First, Part I provides __a broad but shallow introduction to R__. Consequently, readers are introduced to basic programming skills and given indications of where to look for more depth. For example, the book excludes any discussion of R Markdown, focusing instead on basic scripts as a tool for reproducibility. Conversely, Part II provides __a deep but narrow introduction to introductory statistics__. So, the text foregoes discussion of such things as ensemble modeling and dimensional reduction, opting instead to provide greater detail about probability distributions, significance tests, and multivariate models (both simple linear models and generalized linear models). This strategy also conforms to the pedagogy outlined above.   
<!--
The book itself consists of three parts: an introduction to the book, an introduction to R, and an introduction to statistics. 

1. __Introduction to book__. This section covers the core software (R and RStudio), provides an example workflow to give the reader a general sense of what the book is about, explains how to find help with R, and introduces our style guide.    
2. __Introduction to R__. This section provides a broad outline of core R programming skills and syntax, including statistical graphics, data types, importing and exporting, indexing, and wrangling. 
3. __Introduction to Statistics__. This section offers a narrow but deep dive into fundamental statistical concepts. It is divided roughly into statistical description and inference for (i) univariate and (ii) multivariate data.   
-->


### Chapter overviews  

At the beginning of each chapter, you will find a table with a chapter overview. These tables enable you to get a sense of what the chapter will cover _at a glance_. Here is the overview table for [Chapter 6: R Basics](#r-basics):

<table class="table-intro table table-hover table-striped" style="margin-left: auto; margin-right: auto;">
<tbody>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Goal__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> To provide a brief overview of basic R functionality. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __tl;dr__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> It's a calculator. </td>
  </tr>
  <tr>
   <td style="text-align:left;border: 0 solid transparent; padding-right: 0px; vertical-align: top;"> __Outcomes__ </td>
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> Here, you will learn about<br><ol>
<li>what R is,</li>
<li>why you should use it, and</li>
<li>what a stereotypical workflow with it looks like.</li>
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
   <td style="text-align:left;border: 0 solid transparent; padding-left: 9px; text-align: justify; text-justify: inter-word;"> [An Introduction to R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html) [@rcoreteam2020introduction]<br>[R FAQ](https://CRAN.R-project.org/doc/FAQ/R-FAQ.html) [@hornik2020faq] </td>
  </tr>
</tbody>
</table>

As you can see, it includes these six components:

1. __Goal__. A short statement regarding the general lesson to be learned.  
2. __tl;dr__. Reddit-speak for "too long, didn't read." This provides a short summary description of the actual lesson.  
3. __Outcomes__. A numerical list of the specific skills and concepts you will learn.  
4. __Data sets__. The specific data you will need to run the R code used in the chapter. We try hard to provide citations for the data and links to web pages that provide more details.    
5. __Requirements__. A list of the skills and concepts you need to know already in order to follow along.  
6. __Further Reading__. Some suggestions regarding where one can look for more information about the chapter topic. Full citations are added at the end of each chapter. Where possible, links to the references are provided.  


## R code formatting

In this section, we just want to touch briefly on two important formatting choices for R code. First, you will on occasion see _inline_ code that looks like this: `seq(2, 200, by = 2)`. This code is gray shaded and has a code font. We typically use this inline code when we want to refer to a specific object or function. For longer code sequences, including multiple object and function calls, we use code chunks that look like this: 


```r
1 + 1
## [1] 2
```

Note, however, that on your own computer, the code that you run will look like this:


```r
> 1 + 1
[1] 2
```

There are two big differences here. First, on your computer, but not in this book, code will always begin with the "prompt," i.e., the greater-than symbol `>`. Second, in this book, but not on your computer, the results of executing some bit of code will be commented out with two pound signs `##`. These two differences facilitate copying code directly from the book and onto your computer. 

You will notice, too, that many of the code chunks in this book are littered with comments. These begin with a single pound sign `#`, for example,


```r
# hey look, I'm a comment in R
1 + 1
## [1] 2
```

These are provided in code chunks as a source of additional guidance, though we try to provide most of the explanation for what we are doing outside of the code chunk, in the primary flow of the prose.  

Throughout the book, we have also chosen to follow a consistent set of conventions for referring to R code proposed by Hadley Wickham and Garrett Grolemund in their _R for Data Science_ book (see [Chapter 1.5 Running R Code](https://r4ds.had.co.nz/introduction.html)). These include:

1. Referring to functions using code font and parantheses, e.g., `mean()` and `seq()`.  
2. Referring to function arguments using code font without parantheses, e.g., `na.rm`.
2. Referring to R objects (like data and classes) using code font without parantheses, e.g., `penguins` and `raster`.  
3. Referring to packages using code font without parantheses, e.g., `dplyr` and `mgcv`. 
5. And, if we need to make it clear what package a function or dataset is from, we will refer to it using the package name and the function/data separated by two colons, e.g., `dplyr::mutate()` and `palmerpenguins::penguins`. (Using colons in this way is also proper R syntax.)  


## Exercises and data  

Chapter exercises are built on a separate platform, specifically Canvas, including all necessary data. Eventually, we hope to bundle the data and exercises into an R package. Unfortunately, that won't be happening any time soon... 
