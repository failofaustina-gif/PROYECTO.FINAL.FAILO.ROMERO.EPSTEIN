library(dplyr)
library(here)

vol <- read.csv(here("datos","processed","volatilidad.csv"))

summary_table <- vol %>%
  summarise(
    mean_import_reliance = mean(import_reliance_avg, na.rm = TRUE),
    mean_vol_growth = mean(vol_growth, na.rm = TRUE)
  )

write.csv(summary_table, here("output","tables","eda_summary.csv"), row.names = FALSE)
