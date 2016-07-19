# ---- setup
library(magrittr)
library(lme4)
library(broom)
library(dplyr)
library(ggplot2)

library(propertyverificationdata)
data("question_first")

question_first %<>%
  tidy_property_verification_data %>%
  recode_feat_type %>%
  recode_mask_type