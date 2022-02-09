Data Wrangling in R, Lesson 2
================
Christy Garcia, Ph.D. and Christopher Prener, Ph.D.
(February 09, 2022)

## Introduction

This is the notebook for the second data wrangling lesson. Today, we’ll
be covering how to create and manipulate variables, using various
functions in the `dplyr` package.

## Dependencies

This notebook requires three packages from the `tidyverse` as well as
one additional package:

``` r
# tidyverse packages
library(dplyr)     # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)     # read and write csv files
library(stringr)   # manipulating string data 

# manage file paths
library(here)      # manage file paths
```

    ## here() starts at /Users/prenercg/GitHub/slu-dss/wrangling-02

## Read in Data

Last time we reviewed how to read `.csv` files into `R`. Today we’ll use
the cleaner versions of the same two files, which are in the `data/`
subdirectory of our project:

1.  `mpg.csv` - the `mpg` data from `ggplot2`
2.  `starwars.csv` - the `starwars` data from `dplyr`

To read `.csv` files into `R`, we’ll use the `readr` package’s
`read_csv()` function.

``` r
mpg <- read_csv(here("data", "mpg.csv"))
```

    ## Rows: 234 Columns: 11

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (6): manufacturer, model, trans, drv, fl, class
    ## dbl (5): displ, year, cyl, cty, hwy

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Now, review the `read_csv()` syntax to import the `starwars.csv` data
from the same source:

``` r
starwars <- read_csv(here("data", "starwars.csv"))
```

    ## Rows: 87 Columns: 10

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): name, hair_color, skin_color, eye_color, gender, homeworld, species
    ## dbl (3): height, mass, birth_year

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

\*Note: We could also call these data frames directly instead of
importing them since they are available within R packages, but we wanted
you to practice reading in!

## Quickly Exploring Data

Remember to quickly explore data, we can use `utils::str()`:

``` r
str(mpg)
```

    ## spec_tbl_df [234 × 11] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
    ##  $ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
    ##  $ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
    ##  $ year        : num [1:234] 1999 1999 2008 2008 1999 ...
    ##  $ cyl         : num [1:234] 4 4 4 4 6 6 6 4 4 4 ...
    ##  $ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
    ##  $ drv         : chr [1:234] "f" "f" "f" "f" ...
    ##  $ cty         : num [1:234] 18 21 20 21 16 18 18 18 16 20 ...
    ##  $ hwy         : num [1:234] 29 29 31 30 26 26 27 26 25 28 ...
    ##  $ fl          : chr [1:234] "p" "p" "p" "p" ...
    ##  $ class       : chr [1:234] "compact" "compact" "compact" "compact" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   manufacturer = col_character(),
    ##   ..   model = col_character(),
    ##   ..   displ = col_double(),
    ##   ..   year = col_double(),
    ##   ..   cyl = col_double(),
    ##   ..   trans = col_character(),
    ##   ..   drv = col_character(),
    ##   ..   cty = col_double(),
    ##   ..   hwy = col_double(),
    ##   ..   fl = col_character(),
    ##   ..   class = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
str(starwars)
```

    ## spec_tbl_df [87 × 10] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ name      : chr [1:87] "Luke Skywalker" "C-3PO" "R2-D2" "Darth Vader" ...
    ##  $ height    : num [1:87] 172 167 96 202 150 178 165 97 183 182 ...
    ##  $ mass      : num [1:87] 77 75 32 136 49 120 75 32 84 77 ...
    ##  $ hair_color: chr [1:87] "blond" NA NA "none" ...
    ##  $ skin_color: chr [1:87] "fair" "gold" "white, blue" "white" ...
    ##  $ eye_color : chr [1:87] "blue" "yellow" "red" "yellow" ...
    ##  $ birth_year: num [1:87] 19 112 33 41.9 19 52 47 NA 24 57 ...
    ##  $ gender    : chr [1:87] "male" NA NA "male" ...
    ##  $ homeworld : chr [1:87] "Tatooine" "Tatooine" "Naboo" "Tatooine" ...
    ##  $ species   : chr [1:87] "Human" "Droid" "Droid" "Human" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   name = col_character(),
    ##   ..   height = col_double(),
    ##   ..   mass = col_double(),
    ##   ..   hair_color = col_character(),
    ##   ..   skin_color = col_character(),
    ##   ..   eye_color = col_character(),
    ##   ..   birth_year = col_double(),
    ##   ..   gender = col_character(),
    ##   ..   homeworld = col_character(),
    ##   ..   species = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

Last time we identified and fixed several issues in these data sets.
Today we are going to use the already clean data sets to look at
creating new variables, combining variables, and other such mutations.

## Creating new variables

### With `mutate`

One of the basic functions of the `dplyr` package is `mutate`. It is
essentially used just to create new variables. When using this function,
we have to specify three things:

1.  the name of the data frame to be modified
2.  the name of the new variable that you want to create
3.  the value you’d like to assign to this new variable

So let’s say we wanted to make a new variable in the `mpg` data frame
that reflects the age of the cars instead of which year they were made.

``` r
mpg_new <- mutate(mpg, age = 2022-year) 
```

Another thing we might want to do is average the city and highway MPG
rates for each vehicle.

``` r
mpg_new <- mutate(mpg, avg = (cty+hwy)/2) 
```

NOTE: The `mutate` function does not automatically change the input data
frame, so that is why we have to use the assignment operator to either
save the change to a new data frame or the existing one.

Remember we can also do both of these steps in one by using a
*pipeline*.

``` r
mpg %>%
  mutate(
    age = 2022-year,
    avg = (cty/hwy)/2
  ) -> mpg_new
```

This reads as:

1.  First, we take the `mpg` data, *then*
2.  we make a new variable called `age`, *then*
3.  we make another new variable called `avg`, *then*
4.  we save the output to `mpg_new`.

Now try making some new variables in the `starwars` data frame using the
`mutate` function. (For example, converting the height variable to
inches from cm.)

``` r
starwars_new <- mutate(starwars, inches = height*0.39) 
```

### With `mutate` and `case_when`

Another function, `case_when` can be helpful when embedded in `mutate`
in order to recode an existing variable, creating a new variable with
different values.

``` r
mpg_new %>%
  mutate(
    highEfficiency = case_when(
      hwy > 23 ~ TRUE,
      hwy <  23 ~  FALSE
    )
  ) -> mpg_new
```

You may have noticed that this leaves out vehicles which have a highway
mpg of exactly 23. We can fix this by including an equal sign (&lt;=),
to mean ‘less than or equal to’:

``` r
mpg_new %>%
  mutate(
    highEfficiency = case_when(
      hwy > 23 ~ TRUE,
      hwy <=  23 ~  FALSE
    )
  ) -> mpg_new
```

We can also use `case_when` to recode character variables.

``` r
mpg_new %>%
  mutate(
    origin = case_when(
      manufacturer %in% c("dodge", "chevrolet", "ford", "jeep", "lincoln", "mercury", "pontiac") ~ "domestic",
      manufacturer %in% c("audi", "hyundai", "honda", "land rover", "nissan", "subaru", "toyota", "volkswagen") ~  "foreign"
    )
  ) -> mpg_new
```

Now try recoding one numeric and one character variable in the
`starwars` data set using the `mutate` and `case_when` functions. (For
example, if you wanted to create a variable of which characters are tall
or categorize their eye colors.)

``` r
starwars_new %>%
  mutate(
    tall = case_when(
      height > 174 ~ TRUE,
      height <=  174 ~  FALSE
    )
  ) -> starwars_new

starwars_new %>%
  mutate(
    eye_category = case_when(
      eye_color %in% c("blue", "blue-gray", "green, yellow", "hazel", "orange", "white", "yellow", "gold", "pink", "red", "red, blue") ~ "light",
      eye_color %in% c("black", "brown", "dark") ~  "dark"
    )
  ) -> starwars_new
```

### Adding column ID with `mutate`

You’ll notice that neither one of our data frames has a column for row
IDs (although `starwars` does have character names). We can easily add
this with the `mutate` function.

``` r
mpg_new <- mutate(mpg_new, id = rownames(mpg_new))
```

Repeat the above for the `starwars` data frame:

``` r
starwars_new <- mutate(starwars_new, id = rownames(starwars_new))
```

### Splitting a variable with `str_split`

If you have a character variable that is made up of multiple strings,
you can split it by using the function `str_split` in the `stingr`
package. For this to work, the strings within a variable must be
separated by the same thing (space, comma, slash, etc.).

Within `str_split()`, we must first specify the variable that we would
like to split (`name`) and then tell R how to split this column. In this
case, the strings are separated by spaces, so we just put a space in the
parentheses that follow. At the end of the function, we specify which
string (in this case the first one) we would like to single out.

``` r
starwars_new %>%
  mutate(first = str_split(name, " ", simplify = TRUE)[, 1]
   ) -> starwars_new
```

Now repeat the use of `str_split` to make a new variable which is the
second name of each Star Wars character (if they have one).

``` r
starwars_new %>%
  mutate(second = str_split(name, " ", simplify = TRUE)[, 2]
   ) -> starwars_new
```

## Write Data

We have made several modifications to our data frames, and while not
strictly necessary, we might want to save these changes to a .csv to be
able to access them outside of R. We use the `write_csv` function from
`readr` to do this:

``` r
write_csv(mpg_new, here("data", "mpg_new.csv"))
```

Now export the `starwars_new` data frame to the “data” folder:

``` r
write_csv(starwars_new, here("data", "starwars_new.csv"))
```
