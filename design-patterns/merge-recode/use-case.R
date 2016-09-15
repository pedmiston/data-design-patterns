# A use case for merge-recorder functions
# ---------------------------------------
# Overlaying raw means and model preds on the same plot.

recode_feat_type <- function(frame) {
  feat_type_map <- data.frame(
    feat_type = c("visual", "nonvisual"),
    feat_c = c(-0.5, 0.5)
  )
  
  merge(frame, feat_type_map)
}

from_labels <- data.frame(feat_type = c("visual", "visual", "nonvisual", "missing"))
recode_feat_type(from_labels)

from_values <- data.frame(feat_c = c(-0.5, -0.5, 0.5, 0.999))
recode_feat_type(from_values)
