# =======================================================================
# 04_eda.R (versión simplificada)
# EDA: estructura, NA, primeras observaciones, algunos gráficos
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

# Dimensiones
write_csv(
  as.data.frame(dim(base)),
  here("output","tables","dimensiones_base.csv")
)

# Primeras observaciones
write_csv(
  head(base, 20),
  here("output","tables","head_base.csv")
)

# Resumen de NA
na_df <- base %>% summarise(across(everything(), ~sum(is.na(.))))
write_csv(na_df, here("output","tables","na_processed_summary.csv"))

# --- Gráficos exploratorios mínimos --------------------------------------

# 1) Histograma crecimiento del PBI
p_gdp <- ggplot(base, aes(x = gdp_growth)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del crecimiento del PBI",
    x = "Crecimiento del PBI (% anual)",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_gdp_growth.png"),
       p_gdp, width = 6, height = 4)

# 2) Histograma apertura comercial
p_trade <- ggplot(base, aes(x = trade_pct_gdp)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución de la apertura comercial",
    x = "Comercio total (% del PBI)",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_trade_pct_gdp.png"),
       p_trade, width = 6, height = 4)

# 3) Histograma índice GL
p_gl <- ggplot(base, aes(x = gl_index)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribución del índice de Grubel-Lloyd",
    x = "Índice GL",
    y = "Frecuencia"
  )
ggsave(here("output","figures","hist_gl_index.png"),
       p_gl, width = 6, height = 4)

cat("EDA simplificado completado. Pocas figuras exploratorias generadas.\n")

