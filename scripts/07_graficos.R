# =======================================================================
# 07_graficos.R
# Gráficos editoriales para storytelling
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

# 1) GL vs crecimiento
p1 <- ggplot(base, aes(gl_index, gdp_growth)) +
  geom_point(alpha=.6, color="steelblue") +
  geom_smooth(method="lm", se=FALSE, color="black") +
  labs(
    title="Crecimiento económico y equilibrio comercial (GL)",
    x="Índice de Grubel-Lloyd",
    y="Crecimiento del PBI (%)",
    caption="Fuente: World Development Indicators"
  )

ggsave(here("output","figures","grafico_GL_vs_growth.png"), p1, width=7, height=5)

# 2) Apertura vs crecimiento
p2 <- ggplot(base, aes(trade_pct_gdp, gdp_growth)) +
  geom_point(alpha=.6, color="darkred") +
  geom_smooth(method="lm", se=FALSE, color="black") +
  labs(
    title="Apertura comercial y crecimiento económico",
    x="Apertura (% PBI)",
    y="Crecimiento del PBI (%)",
    caption="Fuente: World Development Indicators"
  )

ggsave(here("output","figures","grafico_trade_vs_growth.png"), p2, width=7, height=5)

cat("Gráficos editorializados creados.\n")
