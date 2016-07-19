# Parallel reports

## Problems

1. Interactive development of reports is hard to do right, in a way that encourages you to write the best code with the greatest payoffs down the road.
2. There will always be more code than room on the final report or presentation.
3. It's hard to reuse code used for literate documentation.

## Introducing read_chunk

The solution I have discovered is to write normal .R scripts and use the knitr function `read_chunk` to load them into my dynamic documents:

    # report.Rmd

    ```{r}
    library(knitr)
    read_chunk("report.R")
    ```

    ```{r report}
    ```

`read_chunk` looks at .R scripts and loads chunk by label looking for comments like:

    # ---- label

Then, these chunks can be used in Rmd reports:

    ```{r label}
    ```

## Principles of chunk files

The point of separating chunk files from the Rmd report is that sometimes you want to be able to jump in and run all of the code easily, move things around, and refactor at will. Make sure you can always open up any of the chunk files and run them without issue in an empty environment.

## Caveats

- Parallel reports is basically undoing some of what is great about interleaving documentation and code. Use only if you find it difficult to be productive on long documents.
- There is some inevitable duplication. Keep chunk labels as unique as you can.
