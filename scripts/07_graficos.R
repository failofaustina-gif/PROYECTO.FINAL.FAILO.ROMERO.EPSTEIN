# ================================================================
# 07_graficos.R
# Gráficos editorializados del trabajo
# ================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "figures"))) {
  dir.create(here("output", "figures"), recursive = TRUE)
}

# --- Gráfico 1: Scatter dependencia vs volatilidad ----------------

g1 <- ggplot(vol, aes(x = import_reliance_avg, y = vol_growth)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(
    title = "Dependencia externa y volatilidad del crecimiento",
    x     = "Dependencia externa (Import Reliance promedio)",
    y     = "Volatilidad del crecimiento (% PBI)",
    caption = "Fuente: World Development Indicators"
  )

ggsave(here("output", "figures", "grafico_dependencia_vs_volatilidad.png"),
       g1, width = 7, height = 5)

# --- Gráfico 2: Boxplot por grupos -------------------------------

vol_group <- vol %>%
  mutate(
    group = case_when(
      import_reliance_avg >= 0.6 ~ "Alta dependencia",
      import_reliance_avg <= 0.4 ~ "Baja dependencia",
      TRUE                       ~ NA_character_
    )
  ) %>%
  filter(!is.na(group))

g2 <- ggplot(vol_group, aes(x = group, y = vol_growth, fill = group)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Volatilidad del crecimiento: países según dependencia externa",
    x     = "Grupo de países",
    y     = "Volatilidad del PBI (%)",
    caption = "Fuente: World Development Indicators"
  ) +
  scale_fill_manual(values = c("Alta dependencia" = "#F4A3B4",
                               "Baja dependencia" = "#81C7D4")) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(here("output", "figures", "grafico_boxplot_grupos.png"),
       g2, width = 7, height = 5)

# --- Gráfico 3: Top 20 países más volátiles ----------------------

top20 <- vol %>%
  arrange(desc(vol_growth)) %>%
  slice(1:20)

g3 <- ggplot(top20,
             aes(x = reorder(country_name, vol_growth),
                 y = vol_growth,
                 fill = import_reliance_avg)) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(low = "steelblue", high = "tomato") +
  labs(
    title = "Los 20 países más volátiles y su dependencia externa",
    x     = "País",
    y     = "Volatilidad del PBI (%)",
    fill  = "Dependencia externa",
    caption = "Fuente: World Development Indicators"
  ) +
  theme_minimal()

ggsave(here("output", "figures", "grafico_top20_volatilidad.png"),
       g3, width = 7, height = 6)

cat("07_graficos.R: gráficos editoriales generados\n")
