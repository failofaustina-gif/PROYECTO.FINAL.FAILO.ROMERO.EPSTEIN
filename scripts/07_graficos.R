library(ggplot2)
library(dplyr)
library(here)

vol <- read.csv(here("datos","processed","volatilidad.csv"))

# Gráfico editorial 1: Import reliance vs volatilidad
g1 <- ggplot(vol, aes(import_reliance_avg, vol_growth)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Dependencia externa y volatilidad del crecimiento",
    x = "Dependencia externa (Import Reliance)",
    y = "Volatilidad del crecimiento (%)"
  )

ggsave(here("output","figures","grafico_dependencia_vs_volatilidad.png"), g1, width = 7, height = 5)

# Gráfico editorial 2: Comparación de grupos
vol_group <- vol %>%
  mutate(group = case_when(
    import_reliance_avg >= 0.6 ~ "Alta dependencia",
    import_reliance_avg <= 0.4 ~ "Baja dependencia",
    TRUE ~ NA
  )) %>%
  filter(!is.na(group))

g2 <- ggplot(vol_group, aes(group, vol_growth, fill = group)) +
  geom_boxplot(alpha = 0.6) +
  labs(
    title = "Volatilidad del crecimiento: países abiertos vs dependientes",
    x = "Grupo",
    y = "Volatilidad del PBI (%)"
  ) +
  theme(legend.position = "none")

ggsave(here("output","figures","grafico_boxplot_grupos.png"), g2, width = 7, height = 5)
