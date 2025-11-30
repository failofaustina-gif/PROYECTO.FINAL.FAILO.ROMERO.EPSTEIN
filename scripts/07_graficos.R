# =======================================================================
# 07_graficos.R
# Gráficos editorializados para el storytelling:
# 1) Boxplot de apertura por grupo GL
# 2) Dispersión GL promedio vs apertura promedio
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

if (!dir.exists(here("output","figures"))) {
  dir.create(here("output","figures"), recursive = TRUE)
}

# Reutilizamos el resumen por país
gl_groups <- base %>%
  group_by(country_code, country_name) %>%
  summarise(
    gl_prom        = mean(gl_index,      na.rm = TRUE),
    apertura_prom  = mean(trade_pct_gdp, na.rm = TRUE),
    desequilibrio_prom = mean(abs(exports_pct_gdp - imports_pct_gdp), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  filter(!is.na(gl_prom))

mediana_gl <- median(gl_groups$gl_prom, na.rm = TRUE)

gl_groups <- gl_groups %>%
  mutate(
    grupo_gl = ifelse(gl_prom >= mediana_gl, "GL alto", "GL bajo")
  )

# 1) Boxplot editorializado: apertura por grupo GL
p_box_grupo <- ggplot(gl_groups, aes(x = grupo_gl, y = apertura_prom, fill = grupo_gl)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title   = "Apertura comercial según nivel de comercio intraindustrial",
    x       = "Grupo de países según GL",
    y       = "Apertura comercial promedio (% del PBI)",
    caption = "Fuente: World Development Indicators"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(here("output","figures","boxplot_apertura_por_grupo_gl.png"),
       p_box_grupo, width = 7, height = 5)

# 2) Dispersión GL vs apertura promedio
p_disp <- ggplot(gl_groups, aes(x = gl_prom, y = apertura_prom)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title   = "Comercio intraindustrial (GL) y apertura comercial",
    x       = "Índice de Grubel-Lloyd promedio",
    y       = "Apertura comercial promedio (% del PBI)",
    caption = "Fuente: World Development Indicators"
  ) +
  theme_minimal()

ggsave(here("output","figures","dispersion_gl_vs_apertura.png"),
       p_disp, width = 7, height = 5)

cat("07_graficos.R: gráficos editorializados generados.\n")
