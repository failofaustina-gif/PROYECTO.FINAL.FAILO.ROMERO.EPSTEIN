# =======================================================================
# 05_descriptivas.R (versión simplificada)
# Estadísticas descriptivas + pocos boxplots
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

# Tabla de descriptivas para variables numéricas
desc <- base %>%
  summarise(across(
    where(is.numeric),
    list(media = ~mean(.x, na.rm = TRUE),
         mediana = ~median(.x, na.rm = TRUE),
         sd = ~sd(.x, na.rm = TRUE))
  ))

write_csv(desc, here("output","tables","descriptivas.csv"))

# --- Boxplots mínimos -----------------------------------------------------

# 1) Boxplot crecimiento
p_box_gdp <- ggplot(base, aes(y = gdp_growth)) +
  geom_boxplot() +
  labs(
    title = "Crecimiento del PBI – Boxplot",
    y = "Crecimiento del PBI (% anual)"
  )
ggsave(here("output","figures","boxplot_gdp_growth.png"),
       p_box_gdp, width = 5, height = 4)

# 2) Boxplot apertura comercial
p_box_trade <- ggplot(base, aes(y = trade_pct_gdp)) +
  geom_boxplot() +
  labs(
    title = "Apertura comercial – Boxplot",
    y = "Comercio total (% del PBI)"
  )
ggsave(here("output","figures","boxplot_trade_pct_gdp.png"),
       p_box_trade, width = 5, height = 4)

cat("Descriptivas simplificadas generadas.\n")
