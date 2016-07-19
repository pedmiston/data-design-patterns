source("setup.R")

# ---- error-plot
ggplot(question_first, aes(x = mask_c, y = is_error)) +
  geom_bar(stat = "summary", fun.y = "mean") +
  facet_wrap("feat_label")

# ---- rt-plot
ggplot(question_first, aes(x = mask_c, y = rt)) +
  geom_bar(stat = "summary", fun.y = "mean") +
  facet_wrap("feat_label")