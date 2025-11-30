# ================================================================
# 07_graficos.R
# Gráficos editoriales: apertura y volatilidad
# ================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "figures"))) {
  dir.create(here("output", "figures"), recursive = TRUE)
}

# Quitamos países sin apertura promedio
vol <- vol %>% filter(!is.na(openness_avg))

# 1) Scatter apertura vs volatilidad
g1 <- ggplot(vol, aes(x = openness_avg, y = vol_growth)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(
    title   = "Apertura comercial y volatilidad del crecimiento",
    x       = "Apertura comercial promedio (% PBI)",
    y       = "Volatilidad del PBI (%)",
    caption = "Fuente: World Development Indicators"
  )

ggsave(here("output", "figures", "grafico_apertura_vs_volatilidad.png"),
       g1, width = 7, height = 5)

# 2) Boxplot por grupo de apertura (sin NA)
mediana_ap <- median(vol$openness_avg, na.rm = TRUE)

vol_group <- vol %>%
  mutate(
    group = ifelse(openness_avg >= mediana_ap, "Alta apertura", "Baja apertura")
  )

g2 <- ggplot(vol_group, aes(x = group, y = vol_growth, fill = group)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title   = "Volatilidad del PBI según nivel de apertura",
    x       = "Grupo de países",
    y       = "Volatilidad del PBI (%)",
    caption = "Fuente: World Development Indicators"
  ) +
  scale_fill_manual(values = c("Alta apertura" = "#81C7D4",
                               "Baja apertura" = "#F4A3B4")) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(here("output", "figures", "grafico_boxplot_grupos_apertura.png"),
       g2, width = 7, height = 5)

# 3) Top 20 más volátiles (ya sin NA)
top20 <- vol %>%
  arrange(desc(vol_growth)) %>%
  slice(1:20)

g3 <- ggplot(top20,
             aes(x = reorder(country_name, vol_growth),
                 y = vol_growth,
                 fill = openness_avg)) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(low = "steelblue", high = "tomato") +
  labs(
    title   = "20 países con mayor volatilidad y su apertura comercial",
    x       = "País",
    y       = "Volatilidad del PBI (%)",
    fill    = "Apertura promedio",
    caption = "Fuente: World Development Indicators"
  ) +
  theme_minimal()

ggsave(here("output", "figures", "grafico_top20_volatilidad.png"),
       g3, width = 7, height = 6)

cat("07_graficos.R: gráficos generados sin grupo NA\n")
