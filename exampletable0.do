```{r}
library(Statamarkdown)
```


# Some Stata `table` basics

# Collections

Perhaps surprisingly, the first thing to learn about creating tables in Stata 7,  is how to use the `collect` command and how to understand `collection`.

A **collection** is an aggregate object with **data**, **labels for data** and **style** information.  The information is organised by the use of **tags**.  **Collect** takes the results of a computation and then organises the values in the results by associating each with appropriate tags, such as any associated levels of categorical variables.  A tag combines the identifier for a **dimension** of the collection and the identifier for a **level** of that dimension.

## A first example

We start with a simple table summary

```{stata}
use https://www.ucl.ac.uk/~ccaajim/results
collect clear
sort gender teacher
quietly collect: by gender teacher: summarize maths
collect layout (gender) (teacher) (result[mean])

```

We see immediately from the result that **layout** takes the results of the `summarize` command and makes a table such that levels of `gender` are in rows and levels of `teacher` in columns.  The cells of layout are filled with the computation specified in 'result[]`.

### Information about a collection

#### Dimensions of your collection

```{stata}
use https://www.ucl.ac.uk/~ccaajim/results

table (gender) (teacher), ///
       statistic(frequency) ///
       statistic(percent) ///
       statistic(mean maths) ///
       statistic(sd maths) ///
       nototals ///
       nformat(%9.0fc frequency) ///
       sformat("%s%%" percent) ///
       nformat(%6.2f  mean sd) ///
       sformat("(%s)" sd) ///
	     style(table-1)

collect dims
```


The output from `collect dims` tells us the names of the dimensions in out table and the levels associated with each.  We can modify dimension labels:

```
collect label levels gender 1 "girl" 2 "boy"
```

Having made the modification we can view the change with `collect preview`.

To view the list of labels of a dimension we can use, for example

```
collect label list result, all
```

Which tells us what has been collect by the result dimension in our table.

The dimension `result` is not associated with any variable in our data set, but calculated by the `statistic()` function in our `collection` command.


## Modification 1

We will first improve the display of the decimals in `result[]` by adding a `style cell` specification:

```{stata}
use https://www.ucl.ac.uk/~ccaajim/results
collect clear
sort gender teacher
quietly collect: by gender teacher: summarize maths
collect style cell result[mean], nformat(%5.2f)
collect layout (gender) (teacher) (result[mean])
collect dims
```

## Modification 2

We will switch the place of the rows and columns.  This involves no recalculation of any kind:

```
collect style cell result[mean], nformat(%5.2f)
collect layout (teacher) (gender) (result[mean])
```

## Adding a title

```
collect style cell result[mean], nformat(%5.2f)
collect title "Some summary statistics"
collect layout (teacher) (gender) (result[mean])
```

### Adding a note

```
collect style cell result[mean], nformat(%5.2f)
collect title "Some summary statistics"
collect notes "These are not very useful"
collect layout (teacher) (gender) (result[mean])
```

## Saving labels and styles

Once we like the look of our table, we can type collect label save to save our custom labels, and we can type collect style save to save our custom style.

. collect label save MyLabels, replace
(labels from Table saved to file MyLabels.stjson)

. collect style save MyStyle, replace
(style from Table saved to file MyStyle.stjson)
Then, we can apply our labels and style to future tables using the style() and label() options in our table commands.

. table (sex) (highbp),
>       statistic(frequency)
>       statistic(percent)
>       statistic(mean age)
>       statistic(sd age)
>       nototals
>       nformat(%9.0fc frequency)
>       sformat("%s%%" percent)
>       nformat(%6.2f  mean sd)
>       sformat("(%s)" sd)
>       style(MyStyle, override)
>       label(MyLabels)

---------------------------------
                   Hypertension
                     No       Yes
---------------------------------
Sex
  Male
    Freq.         2,611     2,304
    Percent      25.22%    22.26%
    Mean (Age)    42.86     52.59
    SD (Age)    (16.97)   (15.88)
  Female
    Freq.         3,364     2,072
    Percent      32.50%    20.02%
    Mean (Age)    41.62     57.62
    SD (Age)    (16.60)   (13.26)
---------------------------------

Exporting tables to documents with collect export

We can use collect export to export our table to many different file formats, including Microsoft Word and Excel, HTML 5 with CSS files, Markdown, PDF, LaTeX, SMCL, and plain text.

I have used collect style putdocx in the example below to add a title to our table and to automatically fit the table within a Microsoft Word document. Then, I have used collect export to export the table to a Microsoft Word document.

. collect style putdocx, layout(autofitcontents)
>         title("Table 1: Descriptive Statistics by Hypertension Status")

. collect export MyTable1.docx, as(docx) replace
(collection Table exported to file MyTable1.docx)