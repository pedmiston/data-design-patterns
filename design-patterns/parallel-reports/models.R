source("setup.R")

# ---- error-mod
error_mod <- glmer(is_error ~ feat_c * mask_c + (1|subj_id),
                   family = binomial, data = question_first)

# ---- rt-mod
rt_mod <- lmer(rt ~ feat_c * mask_c + (1|subj_id),
               data = question_first)