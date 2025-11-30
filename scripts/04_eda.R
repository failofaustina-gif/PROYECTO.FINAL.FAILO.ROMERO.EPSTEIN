# ================================================================
# 04_eda.R
# Análisis exploratorio básico
# ================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos", "processed", "base_processed.csv"))
vol  <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}
if (!dir.exists(here("output", "figures"))) {
  dir.create(here("output", "figures"), recursive = TRUE)
}

dims <- tibble(
  n_filas     = nrow(base),
  n_columnas  = ncol(base),
  n_paises    = n_distinct(base$country_code),
  n_anios     = n_distinct(base$year)
)

write_csv(dims, here("output", "tables", "dimensiones_base.csv"))
write_csv(head(base, 20), here("output", "tables", "head_base.csv"))

# Hist crecimiento anual
p_gdp <- ggplot(base, aes(x = gdp_growth)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del crecimiento del PBI",
    x     = "Crecimiento anual del PBI (%)",
    y     = "Frecuencia"
  )

ggsave(here("output", "figures", "hist_gdp_growth.png"),
       p_gdp, width = 6, height = 4)

# Hist apertura promedio país
p_open <- ggplot(vol, aes(x = openness_avg)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribución de la apertura comercial promedio",
    x     = "Apertura comercial promedio (% PBI)",
    y     = "Frecuencia"
  )

ggsave(here("output", "figures", "hist_openness_avg.png"),
       p_open, width = 6, height = 4)

cat("04_eda.R: EDA básico generado\n")
