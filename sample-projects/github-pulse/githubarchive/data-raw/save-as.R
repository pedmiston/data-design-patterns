library(devtools)
library(dplyr)
library(readr)

csvs <- list.files("data-raw", pattern = "*.csv", full.names = TRUE)
activity <- read_csv(csvs)

use_data(activity, overwrite = TRUE)
