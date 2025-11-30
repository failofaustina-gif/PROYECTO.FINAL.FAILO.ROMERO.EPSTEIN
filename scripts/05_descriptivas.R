# ================================================================
# 05_descriptivas.R
# Estadísticas descriptivas de apertura y volatilidad
# ================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}
if (!dir.exists(here("output", "figures"))) {
  dir.create(here("output", "figures"), recursive = TRUE)
}

desc <- vol %>%
  summarise(
    media_apertura   = mean(openness_avg, na.rm = TRUE),
    sd_apertura      = sd(openness_avg,   na.rm = TRUE),
    min_apertura     = min(openness_avg,  na.rm = TRUE),
    max_apertura     = max(openness_avg,  na.rm = TRUE),
    media_volatilidad = mean(vol_growth,  na.rm = TRUE),
    sd_volatilidad    = sd(vol_growth,    na.rm = TRUE),
    min_volatilidad   = min(vol_growth,   na.rm = TRUE),
    max_volatilidad   = max(vol_growth,   na.rm = TRUE)
  )

write_csv(desc, here("output", "tables", "descriptivas.csv"))

p_box_vol <- ggplot(vol, aes(y = vol_growth)) +
  geom_boxplot() +
  labs(
    title = "Volatilidad del crecimiento del PBI – Boxplot",
    y     = "Volatilidad del PBI (%)"
  )

ggsave(here("output", "figures", "boxplot_volatilidad.png"),
       p_box_vol, width = 5, height = 4)

cat("05_descriptivas.R: descriptivas y boxplot generados\n")
