library(dplyr)
library(here)

base <- read.csv(here("datos","clean","base_clean2.csv"))

# Crear dependencia externa (Import Reliance)
base <- base %>%
  mutate(
    trade_total = exports_pct_gdp + imports_pct_gdp,
    import_reliance = ifelse(trade_total > 0, imports_pct_gdp / trade_total, NA)
  )

# Volatilidad del crecimiento por país
volatilidad <- base %>%
  group_by(country_code, country_name) %>%
  summarise(vol_growth = sd(gdp_growth, na.rm = TRUE),
            import_reliance_avg = mean(import_reliance, na.rm = TRUE),
            .groups = "drop")

write.csv(base, here("datos","processed","base_processed.csv"), row.names = FALSE)
write.csv(volatilidad, here("datos","processed","volatilidad.csv"), row.names = FALSE)
