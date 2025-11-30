library(dplyr)
library(here)

vol <- read.csv(here("datos","processed","volatilidad.csv"))

desc <- vol %>%
  summarise(
    sd_import_reliance = sd(import_reliance_avg, na.rm = TRUE),
    sd_volatility = sd(vol_growth, na.rm = TRUE),
    min_import_reliance = min(import_reliance_avg, na.rm = TRUE),
    max_import_reliance = max(import_reliance_avg, na.rm = TRUE),
    min_vol = min(vol_growth, na.rm = TRUE),
    max_vol = max(vol_growth, na.rm = TRUE)
  )

write.csv(desc, here("output","tables","descriptivas.csv"), row.names = FALSE)
