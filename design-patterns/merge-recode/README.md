![Merge recode](design-patterns/merge-recode/merge-recode.png)

This is a design pattern for recoding variables using merges.

## Description

* **Intent**. Provide a single, authoritative place for recoding variables.
* **Scenario**. You create different contrast variables during modeling fitting and want to put all of your recoding in a single place.
* **Solution**. Create functions that recode variables by merging observations with keys.

## Recoders

Here is an example recoder function:

```R
recode_feat_type <- function(frame) {
  feat_type_map <- data.frame(
    feat_type = c("visual", "nonvisual"),
    feat_c = c(-0.5, 0.5)
  )

  merge(frame, feat_type_map, all.x = TRUE)
}
```

Here's how to use it:

```R
data <- data.frame(feat_type = c("visual", "visual", "nonvisual", "visual"))
data <- recode_feat_type(data)
```

## Recoding multiple variables

The `dplyr` package exports a `%>%` function, which is very useful for chaining multiple recodings together:

```R
library(dplyr)  # dplyr imports the `%>%` function from `magrittr`

clean_data <- dirty_data %>%
  recode_var1 %>%
  recode_var2 %>%
  recode_var3
```

## Use case

Plotting model predictions on top of raw means. See "use-case.R".
