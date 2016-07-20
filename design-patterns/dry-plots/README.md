![DRY plots](/design-patterns/dry-plots/dry-plots.png)

**DRY** is Don't Repeat Yourself and **DRY plots** are sets of plots that inherit the same style without that style being repeated.

## Description

* **Intent**. Style different plots in the same way without repeating.
* **Scenario**. A publication's guidelines dictate stylistic
  changes to all figures in a manuscript. How quickly can the changes be
  made?
* **Solution**. Write complicated R code in normal .R files and load it into
  dynamic reports using the `knitr::read_chunk` function.

## Don't Repeat Yourself

It's tempting to build each plot on its own.

```R
ggplot(df, aes(x, y1, color=group)) +
  geom_point() +
  theme_minimal()

ggplot(df, aes(x, y2, color=group)) +
  geom_point() +
  theme_minimal()
```

But building each plot separately makes it tedious to change any of the features that are in common across the plots. A different approach is to let the ggplots inherit from one another. The result is a cascading style sheet for plots.

```R
base <- ggplot(df, aes(x, color=group)) +
  theme_minimal()

base + geom_point(aes(y = y1))
base + geom_point(aes(y = y2))
```

## Facets and small multiples

Although the basic idea of inheriting ggplots is very general, it can be used to implement a very powerful data visualization technique: small multiples. In the base plot, the main axis and styling elements are established, and then different factors are used to group the data for the different facets.

Create a base plot without any layers.

```R
base_plot <- ggplot(df, aes(x, y))
```

Then split the data in different ways for facets.

```R
base_plot +
  geom_bar(stat = "summary", fun.y = "mean") +
  facet_wrap("grouper")

base_plot +
  geom_point(stat = "summary", fun.y = "mean") +
  facet_wrap("grouper")
```

## Replace the data

Sometimes it's necessary to refit a plot on a subset of the data.

```R
(base_plot %+% filter(df, version == 2)) +
  geom_point(stat = "summary", fun.y = "mean")
```
