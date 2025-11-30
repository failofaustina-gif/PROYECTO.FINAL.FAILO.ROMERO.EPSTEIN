# ================================================================
# 03_procesamiento.R
# Crea indicadores: apertura comercial y volatilidad del crecimiento
# ================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos", "clean", "base_clean2.csv"))

base_processed <- base %>%
  mutate(
    trade_total = exports_pct_gdp + imports_pct_gdp  # apertura (% PBI)
  )

# Indicadores por país
vol_country <- base_processed %>%
  group_by(country_code, country_name) %>%
  summarise(
    n_obs          = sum(!is.na(gdp_growth)),
    vol_growth     = sd(gdp_growth, na.rm = TRUE),     # volatilidad
    mean_growth    = mean(gdp_growth, na.rm = TRUE),   # crecimiento promedio
    openness_avg   = mean(trade_total, na.rm = TRUE),  # apertura promedio
    .groups = "drop"
  ) %>%
  filter(n_obs >= 10)  # descartamos países con muy pocos datos

if (!dir.exists(here("datos", "processed"))) {
  dir.create(here("datos", "processed"), recursive = TRUE)
}

write_csv(base_processed, here("datos", "processed", "base_processed.csv"))
write_csv(vol_country,   here("datos", "processed", "vol_country.csv"))

cat("03_procesamiento.R: base_processed.csv y vol_country.csv creados\n")
