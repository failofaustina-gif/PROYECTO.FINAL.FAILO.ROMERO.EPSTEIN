# =======================================================================
# 04_eda.R
# Análisis exploratorio: estructura, NA, primeras observaciones,
# histogramas básicos.
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

if (!dir.exists(here("output","tables"))) {
  dir.create(here("output","tables"), recursive = TRUE)
}
if (!dir.exists(here("output","figures"))) {
  dir.create(here("output","figures"), recursive = TRUE)
}

# Dimensiones
dim_df <- data.frame(
  n_filas = nrow(base),
  n_columnas = ncol(base)
)
write_csv(dim_df, here("output","tables","dimensiones_base.csv"))

# Primeras filas
write_csv(head(base, 20), here("output","tables","head_base.csv"))

# NA por variable
na_summary <- base %>% summarise(across(everything(), ~sum(is.na(.))))
write_csv(na_summary, here("output","tables","na_processed_summary.csv"))

# Histogramas clave

p_gdp <- ggplot(base, aes(x = gdp_growth)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del crecimiento del PBI",
    x = "Crecimiento del PBI (% anual)",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_gdp_growth.png"), p_gdp, width = 6, height = 4)

p_trade <- ggplot(base, aes(x = trade_pct_gdp)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución de la apertura comercial",
    x = "Comercio total (% del PBI)",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_trade_pct_gdp.png"), p_trade, width = 6, height = 4)

p_gl <- ggplot(base, aes(x = gl_index)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del índice de Grubel-Lloyd",
    x = "Índice GL",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_gl_index.png"), p_gl, width = 6, height = 4)

cat("04_eda.R: EDA completado (tablas y tres histogramas).\n")
