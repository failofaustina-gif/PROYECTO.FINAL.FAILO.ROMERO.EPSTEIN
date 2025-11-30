# =======================================================================
# 05_descriptivas.R
# Estadísticas descriptivas y boxplots básicos
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

# Descriptivas de variables numéricas clave
desc <- base %>%
  summarise(
    exports_media = mean(exports_pct_gdp, na.rm = TRUE),
    imports_media = mean(imports_pct_gdp, na.rm = TRUE),
    trade_media   = mean(trade_pct_gdp,   na.rm = TRUE),
    gdp_growth_media = mean(gdp_growth,   na.rm = TRUE),
    ied_media     = mean(ied_pct_gdp,     na.rm = TRUE),
    gl_media      = mean(gl_index,        na.rm = TRUE),
    
    exports_sd = sd(exports_pct_gdp, na.rm = TRUE),
    imports_sd = sd(imports_pct_gdp, na.rm = TRUE),
    trade_sd   = sd(trade_pct_gdp,   na.rm = TRUE),
    gdp_growth_sd = sd(gdp_growth,   na.rm = TRUE),
    ied_sd     = sd(ied_pct_gdp,     na.rm = TRUE),
    gl_sd      = sd(gl_index,        na.rm = TRUE)
  )

write_csv(desc, here("output","tables","descriptivas.csv"))

# Boxplots resumidos

p_box_gdp <- ggplot(base, aes(y = gdp_growth)) +
  geom_boxplot() +
  labs(
    title = "Crecimiento del PBI – Boxplot",
    y = "Crecimiento del PBI (% anual)"
  )
ggsave(here("output","figures","boxplot_gdp_growth.png"), p_box_gdp, width = 5, height = 4)

p_box_trade <- ggplot(base, aes(y = trade_pct_gdp)) +
  geom_boxplot() +
  labs(
    title = "Apertura comercial – Boxplot",
    y = "Comercio total (% del PBI)"
  )
ggsave(here("output","figures","boxplot_trade_pct_gdp.png"), p_box_trade, width = 5, height = 4)

p_box_gl <- ggplot(base, aes(y = gl_index)) +
  geom_boxplot() +
  labs(
    title = "Índice de Grubel-Lloyd – Boxplot",
    y = "Índice GL"
  )
ggsave(here("output","figures","boxplot_gl_index.png"), p_box_gl, width = 5, height = 4)

cat("05_descriptivas.R: descriptivas y boxplots generados.\n")
