# Merge recode

This is a design pattern for recoding variables using merges.

## Description

* **Intent**. Provide a single, authoritative place for recoding variables.
* **Scenario**. You create different contrast variables during modeling fitting and want to put all of your recoding in a single place.
* **Solution**. Create functions that recode variables by merging observations with keys.

## Recoders

Here is an example recoder function:

```R
recode_feat_type <- function(frame) {
  feat_type_map <- data_frame(
    feat_type = c("visual", "nonvisual"),
    feat_c = c(-0.5, 0.5)
  )

  left_join(frame, feat_type_map)
}
```

Here's how to use it:

```R
data <- data_frame(feat_type = c("visual", "visual", "nonvisual", "visual"))
data <- recode_feat_type(data)
```
