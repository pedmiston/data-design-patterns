# DRY plots

![DRY plots](/design-patterns/dry-plots/dry-plots.png)

- Don't Repeat Yourself.
- Relies heavily on ``ggplot2`` "facets" (Tufte's [small multiples](https://en.wikipedia.org/wiki/Small_multiple)).
- Allows exploratory plots to grow into final versions.

## Creating the base plot

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

```R
(base_plot %+% filter(df, version == 2)) +
  geom_point(stat = "summary", fun.y = "mean")
```
