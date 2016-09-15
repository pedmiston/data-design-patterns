# Green stats

This is a design pattern for writing results sections in knitr.

## Description

* **Intent**. Write results sections without copy & paste.
* **Scenario**. Any time you've ever redone your stats ever.
* **Solution**. Create functions for formatting model results.

## Formatters

A simple formatting function looks like this:

```R
report_lm <- function(lm_mod, param) {
  lm_coefs <- tidy(lm_mod)[, param]

  b <- lm_coefs["estimate"]
  se <- lm_coefs["error"]
  df <- lm_coefs["df"]
  t <- lm_coefs["t"]
  p <- lm_coefs["p"]

  sprintf("b = %f (%f), t(%f) = %f, p = %f",
          b, se, df, t, p)
}
```

Use it in a knitr chunk like this:

    ```{r mod}
    mod <- lm(y ~ x, data = d)
    ```

    We found a significant effect of x, `r report_lm(mod, "x")`.

## Formatters and egg projects

Wondering where to put your green stats formatters? Put them in your egg projects!

    .
    └── my-proj
        ├── analysis.Rproj
        └── projdata
            ├── DESCRIPTION
            ├── NAMESPACE
            ├── projdata.Rproj
            └── R
                └── formatters.R

Now reinstall and load the package and you will have access to any functions in "formatters.R".