# Here is an easy way to find a file path. Go to environment -> import -> from text. This will import the data
# name it as an object. However, this is not reproducable because there is no script. However, this way will give
# you the file path which you can then copy and paste into your script.

## ---------------------------------------------------------------------------------------------------------------------------

# Here is a simply function to add two numbers. The first part is defining and naming the function and telling are
# to return the result. THe second part is actually putting values into the function and running it will now return
# a value or a result

function_name <- function(argument_1, argument_2) {
  result <- argument_1 + argument_2
  return(result)
}

function_name(argument_1 = 1, argument_2 = 2)
## ---------------------------------------------------------------------------------------------------------------------------

# both arguments will be contained within the function's scope
good_sum <- function(addend_1, addend_2) {
  result <- addend_1 + addend_2
  return(result)
}

good_sum(addend_1 = 1, addend_2 = 2)

# addend_1 provided in the global environment which is inherited by the function
bad_sum <- function(addend_2) {
  result <- addend_1 + addend_2
  return(result)
}

addend_1 <- 2
bad_sum(addend_2 = 2)

# the function's scope supersedes the global environment
good_sum(addend_1 = 3, addend_2 = 2)

## ---------------------------------------------------------------------------------------------------------------------------

two_averages <- function(x) {
  # calculate the mean and median
  mean <- mean(x)
  median <- median(x)
  # put all of the results we want into a list
  return_list <- list(mean, median)
  # optionally provide names to the list elements so we know exactly what they are
  names(return_list) <- c("the_mean", "the_median")
  return(return_list)
}

two_averages(x = c(1, 2, 3, 4, 5.5))

## ---------------------------------------------------------------------------------------------------------------------------
unsafe_divide <- function(x, y) {
  result <- x/y
  return(result)
}

# returns Infinity which is not a useful value
unsafe_divide(x = 1, y = 0)

safe_divide <- function(x, y) {
  if (y == 0) {
    result <- "You can't divide by 0"
  } else {
    result <- x/y
  }
  return(result)
}

safe_divide(x = 1, y = 0)


## ---------------------------------------------------------------------------------------------------------------------------
# attach the packages we will need
library(tidyverse)

# return the results in the form of a list
# \ is the same as function
#purr cheatsheet for different forms
purrr::map(
  .x = c(1, 2, 3),
  .f = \(x) {
    result <- x + 1
    return(result)
  }
)

# return a numeric vector instead
map_dbl(
  .x = c(1, 2, 3),
  .f = function(x) {
    result <- x + 1
    return(result)
  }
)


# map along two vectors
map2(
  .x = c(1, 2, 3),
  .y = c("The first result is ",
         "The second result is ",
         "The final result is "),
  .f = function(x, y) {
    result <- x + 1
    return(paste0(y, result))
  }
)

# map along an arbitrary number of lists or vectors

pmap(
  .l = list(
    x = c(1, 2, 3),
    begin_text = c("The first result is ",
                   "The second result is ",
                   "The final result is "),
    end_text = c(" apples", " bananas", " cherries")
  ),
  .f = function(x, begin_text, end_text) {
    result <- x + 1
    return(paste0(begin_text, result, end_text))
  }
)
 #  you can also add a fixed text like so. The fixed text is the final text which is a period

pmap(
  .l = list(
    x = c(1, 2, 3),
    begin_text = c("The first result is ",
                   "The second result is ",
                   "The final result is "),
    end_text = c(" apples", " bananas", " cherries")
  ),
  .f = function(x, begin_text, end_text, final_text = ".") {
    result <- x + 1
    return(paste0(begin_text, result, end_text, final_text))
  }
)



## ---------------------------------------------------------------------------------------------------------------------------
# example data
as_tibble(iris)

# make the plot framework
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length))




## ---------------------------------------------------------------------------------------------------------------------------
# add a basic geom
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_jitter()



## ---------------------------------------------------------------------------------------------------------------------------
# change the look of points
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2)



## ---------------------------------------------------------------------------------------------------------------------------
#  add some mean and standard error
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2)





## ---------------------------------------------------------------------------------------------------------------------------
# add some statistical testing
# add some packages first

library(datascience.curriculum)
install.packages("ggpubr")
install.packages("cowplot")
install.packages("rstatix")


library(ggpubr)
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica")))



## ---------------------------------------------------------------------------------------------------------------------------
# change the colors
# Rcolorbrewer
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_brewer(palette = "Dark2", aesthetics = c("fill", "color"))



## ---------------------------------------------------------------------------------------------------------------------------
# set your own colors manually
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_manual(values = c("setosa" = "red3",
                               "versicolor" = "green4",
                               "virginica" = "blue3"),
                    aesthetics = c("fill", "color"))



## ---------------------------------------------------------------------------------------------------------------------------
library(cowplot)
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_manual(values = c("setosa" = "red3",
                               "versicolor" = "green4",
                               "virginica" = "blue3"),
                    aesthetics = c("fill", "color")) +
  theme_cowplot() +
  theme(legend.position = "none")



## ---------------------------------------------------------------------------------------------------------------------------
# statistical ttest using base statistical test
t.test(x  = iris |>
         filter(Species == "setosa") |>
         pull(Sepal.Length),
       y = iris |>
         filter(Species == "versicolor") |>
         pull(Sepal.Length),
       var.equal = FALSE)




## ---------------------------------------------------------------------------------------------------------------------------
library(rstatix)
# print out a table of descriptive values
iris |>
  group_by(Species) |>
  get_summary_stats()

# do the t-test
iris |>
  t_test(formula = Sepal.Length ~ Species)


library(ggpubr)
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica")))



## ---------------------------------------------------------------------------------------------------------------------------
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_brewer(palette = "Dark2", aesthetics = c("fill", "color"))



## ---------------------------------------------------------------------------------------------------------------------------
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_manual(values = c("setosa" = "red3",
                               "versicolor" = "green4",
                               "virginica" = "blue3"),
                    aesthetics = c("fill", "color"))



## ---------------------------------------------------------------------------------------------------------------------------
library(cowplot)
ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, color = Species, fill = Species)) +
  geom_jitter(shape = 21, alpha = 0.4, size = 2) +
  stat_summary(fun.data = mean_se,
               geom = "crossbar",
               color = "black",
               alpha = 0.2) +
  stat_compare_means(method = "t.test",
                     label = "p.signif",
                     comparisons = list(c("setosa", "versicolor"),
                                        c("versicolor", "virginica"),
                                        c("setosa", "virginica"))) +
  scale_fill_manual(values = c("setosa" = "red3",
                               "versicolor" = "green4",
                               "virginica" = "blue3"),
                    aesthetics = c("fill", "color")) +
  theme_cowplot() +
  theme(legend.position = "none")



## ---------------------------------------------------------------------------------------------------------------------------
t.test(x  = iris |>
         filter(Species == "setosa") |>
         pull(Sepal.Length),
       y = iris |>
         filter(Species == "versicolor") |>
         pull(Sepal.Length),
       var.equal = FALSE)




## ---------------------------------------------------------------------------------------------------------------------------
library(rstatix)
# print out a table of descriptive values
iris |>
  group_by(Species) |>
  get_summary_stats()

# do the t-test
iris |>
  t_test(formula = Sepal.Length ~ Species)



