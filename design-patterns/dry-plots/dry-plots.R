library(propertyverificationdata)
data("question_first")

library(magrittr)
library(ggplot2)
library(scales)
library(lme4)
library(AICcmodavg)
library(dplyr)

question_first %<>%
  tidy_property_verification_data %>%
  recode_mask_type %>%
  recode_feat_type

base <- ggplot(question_first, aes(x = mask_c, y = is_error)) +
  scale_x_continuous("", breaks = c(-0.5, 0.5),
                     labels = c("Blank screen", "Visual interference")) +
  scale_y_continuous("Error rate", labels = percent) +
  scale_alpha_manual(values = c(0.9, 0.5)) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    axis.ticks = element_blank()
  )

# Overall
base +
  geom_bar(aes(alpha = mask_type, fill = feat_type, width = 1),
           stat = "summary", fun.y = "mean") +
  facet_wrap("feat_label") +
  ggtitle("Overall means")

# By subj
base +
  geom_line(aes(color = subj_id, group = subj_id),
            stat = "summary", fun.y = "mean") +
  facet_wrap("feat_label") +
  ggtitle("By subject")

# Model preds
mod <- glmer(is_error ~ feat_c * mask_c + (1|subj_id),
             family = binomial, data = question_first)
x_preds <- expand.grid(mask_c = c(-0.5, 0.5), feat_c = c(-0.5, 0.5))
y_preds <- predictSE(mod, x_preds, se = TRUE)
preds <- cbind(x_preds, y_preds) %>%
  rename(is_error = fit, se = se.fit) %>%
  recode_mask_type %>%
  recode_feat_type

base +
  geom_bar(aes(alpha = mask_type, fill = feat_type, width = 1),
           stat = "identity", data = preds) +
  geom_linerange(aes(ymin = is_error-se, ymax = is_error+se), data = preds) +
  facet_wrap("feat_label") +
  ggtitle("Model predictions")
