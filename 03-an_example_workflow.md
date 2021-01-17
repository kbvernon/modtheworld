# An Example Workflow {#example-workflow}



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
<img src="images/r-workflow.png" alt="An idealized workflow in R" width="60%" />
<p class="caption">(\#fig:04-workflow)An idealized workflow in R</p>
</div>

## In fits and starts

To give you a feel for what all can be done with R, let's walk through an example workflow, as shown in Fig. \@ref(fig:04-workflow). This typically involves importing data, reshaping and/or subsetting it to get it into a format necessary for analysis, doing some preliminary descriptive statistics to explore general properties of the data, doing some inferential statistics to investigate trends in the data, and summarizing the results of the analysis. At various stages, visualizing the data will be extremely helpful, either to explore the data further or to help communicate the results to others. A lot of the output of this process, we will also want to save for later, perhaps to include in a publication (like a figure or model summary), but maybe also to avoid repetition of difficult and time-consuming tasks.

Now, obviously, the diagram in Figure \@ref(fig:04-workflow) is meant to give you a feel for what a typical workflow _should_ look like, at least ideally. As you can see, it is very austere and organized, almost linear, with cool, pleasant colors. You might even call it inviting. Do not be fooled, however. For what you will actually encounter with your work will often look like this:  

<br>

<div class="figure" style="text-align: center">
<img src="images/rat_race.png" alt="The often circuitous and sometimes painful maze of statistical analysis in R." width="80%" />
<p class="caption">(\#fig:04-rmaze)The often circuitous and sometimes painful maze of statistical analysis in R.</p>
</div>

<br>

The path traversed through the maze in this figure has a disorienting, almost chaotic, feel to it.^[It should, anyway, because it's a random walk.] It suggests - correctly - that statistical programming involves lots and lots of false starts, dead-ends, and backtracking. Frankly, there's no avoiding these frustrations, but that's not because what you're doing is _statistical programming_ per se, but rather just _writing to express ideas_. And, like any writing exercise, you start with a blank page, add content here or there, and then, you know, revise, revise, revise, until you get something sufficiently polished that it conveys its intended meaning well. So, as I walk through this example workflow, maybe think about the idealized diagram more as a representation of your _final_ (or final-ish^[Can we really speak of _final_ drafts in this digital age?]) draft ("script," in code talk), and then the maze is just the frustrating, though ultimately rewarding, write-and-revise path to get there.  

## The whole shebang

### Load data


```r
penguins <- read.csv("penguins.csv")
#### Error in file(file, "rt"): cannot open the connection
head(penguins)
#### Error in head(penguins): object 'penguins' not found
```

### Do grunt work

Are observations of bill length missing for any penguins in this dataset? To answer this question, we can check for NA values. And if we really need that information, we can exclude those penguins from our analysis.


```r
any(is.na(penguins$bill_length_mm))
#### Error in eval(expr, envir, enclos): object 'penguins' not found
penguins <- subset(penguins, !is.na(bill_length_mm))
#### Error in subset(penguins, !is.na(bill_length_mm)): object 'penguins' not found
```

The exclamation point `!` (often called "bang") means "not," so you can read that second line as "subset the penguins table and give me the rows that do _not_ have NA values for bill length."  

Now, before moving on to the fun stuff, we might want to ask a few preliminary questions of our data.

_How many penguins are on each island?_


```r
counts <- table(penguins$island)
#### Error in table(penguins$island): object 'penguins' not found
counts
#### Error in eval(expr, envir, enclos): object 'counts' not found
```

_What does this distribution look like?_


```r
barplot(counts)
#### Error in barplot(counts): object 'counts' not found
```

_What is the mean bill length for each species?_


```r
aggregate(bill_length_mm ~ species, 
          FUN = mean,
          data = penguins)
#### Error in eval(m$data, parent.frame()): object 'penguins' not found
```

_And the standard deviation?_


```r
aggregate(bill_length_mm ~ species, 
          FUN = sd,
          data = penguins)
#### Error in eval(m$data, parent.frame()): object 'penguins' not found
```

_How is bill length distributed across species?_


```r
boxplot(bill_length_mm ~ species, 
        data = penguins,
        xlab = "Species",
        ylab = "Bill Length (mm)")
#### Error in eval(m$data, parent.frame()): object 'penguins' not found
```

### Do fun stuff


```r
penguin_model <- lm(flipper_length_mm ~ bill_length_mm, data = penguins)
#### Error in is.data.frame(data): object 'penguins' not found
summary(penguin_model)
#### Error in summary(penguin_model): object 'penguin_model' not found
```

Estimate flipper length using `penguin_model`.


```r
est_flipper_length <- predict(penguin_model)
#### Error in predict(penguin_model): object 'penguin_model' not found
obs_flipper_length <- penguins$flipper_length_mm
#### Error in eval(expr, envir, enclos): object 'penguins' not found
obs_bill_length <- penguins$bill_length_mm
#### Error in eval(expr, envir, enclos): object 'penguins' not found
```

Plot the estimated trend against the observed values:


```r
plot(obs_flipper_length ~ obs_bill_length,
     pch = 19,
     cex = 1.3,
     col = alpha("#949494", 0.4),
     xlab = "Bill Length (mm)",
     ylab = "Flipper Length (mm)")
#### Error in eval(predvars, data, env): object 'obs_flipper_length' not found
abline(penguin_model, col = "#850000")
#### Error in abline(penguin_model, col = "#850000"): object 'penguin_model' not found
mtext(text = "Palmer Penguin Model",
      side = 3, 
      line = 0.3, 
      adj = 0, 
      cex = 1.5)
#### Error in mtext(text = "Palmer Penguin Model", side = 3, line = 0.3, adj = 0, : plot.new has not been called yet
```

### Export results

Save the cleaned data and the linear model.^[Saving a figure in base R is a bit tricky, so we will leave that lesson for another time.]


```r
write.csv(penguins, "penguins.csv", row.names = FALSE)

save(penguin_model, file = "penguin_model.Rdata")
```

And that's it!

