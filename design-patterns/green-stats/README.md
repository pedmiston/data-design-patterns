# Green stats

This is a design pattern for writing results sections in knitr.

## Description

* **Intent**. Write results sections without copy & paste.
* **Scenario**. You discover an outlier in your data, and need to redo all the stats after you have a manuscript written. Or, you decide to present your stats in a different format, for example, you decide you want to add 95% CIs to all results.
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
