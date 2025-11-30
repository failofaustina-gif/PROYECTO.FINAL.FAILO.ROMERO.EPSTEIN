# ================================================================
# 03_procesamiento.R
# Crea indicadores: comercio total, dependencia externa y
# volatilidad del crecimiento por país
# ================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos", "clean", "base_clean2.csv"))

base_processed <- base %>%
  mutate(
    trade_total      = exports_pct_gdp + imports_pct_gdp,
    import_reliance  = ifelse(trade_total > 0,
                              imports_pct_gdp / trade_total,
                              NA_real_)
  )

# Volatilidad y dependencia promedio por país
vol_country <- base_processed %>%
  group_by(country_code, country_name) %>%
  summarise(
    n_obs              = sum(!is.na(gdp_growth)),
    vol_growth         = sd(gdp_growth, na.rm = TRUE),
    mean_growth        = mean(gdp_growth, na.rm = TRUE),
    import_reliance_avg = mean(import_reliance, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  # descartamos países con muy pocos datos para que la volatilidad tenga sentido
  filter(n_obs >= 10)

if (!dir.exists(here("datos", "processed"))) {
  dir.create(here("datos", "processed"), recursive = TRUE)
}

write_csv(base_processed, here("datos", "processed", "base_processed.csv"))
write_csv(vol_country,   here("datos", "processed", "vol_country.csv"))

cat("03_procesamiento.R: base_processed.csv y vol_country.csv creados\n")
