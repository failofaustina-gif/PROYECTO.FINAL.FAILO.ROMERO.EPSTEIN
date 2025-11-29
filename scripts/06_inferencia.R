# =======================================================================
# 06_inferencia.R
# Test de hipótesis + regresión vinculada a hipótesis del trabajo
# =======================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos","processed","base_processed.csv"))

# Cuartiles GL
base <- base %>%
  mutate(gl_group = ntile(gl_index,2)) # divide en "bajo" vs "alto"

# Test de medias (GL bajo vs alto en crecimiento)
grupo_bajo <- base %>% filter(gl_group == 1) %>% pull(gdp_growth)
grupo_alto <- base %>% filter(gl_group == 2) %>% pull(gdp_growth)

test <- t.test(grupo_bajo, grupo_alto)

sink(here("output","tables","test_medias_GL.txt"))
print(test)
sink()

# Regresión
modelo <- lm(gdp_growth ~ trade_pct_gdp + ied_pct_gdp + gl_index, data=base)

sink(here("output","tables","regresion_principal.txt"))
print(summary(modelo))
sink()

cat("Inferencia completada.\n")
