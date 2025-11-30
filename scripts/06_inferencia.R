# ================================================================
# 06_inferencia.R
# Test de hipótesis y regresión: apertura vs volatilidad
# ================================================================

library(dplyr)
library(readr)
library(here)

vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}

# Grupos por apertura (alta vs baja según mediana)
mediana_ap <- median(vol$openness_avg, na.rm = TRUE)

vol_group <- vol %>%
  mutate(
    group = ifelse(openness_avg >= mediana_ap, "Alta apertura", "Baja apertura")
  )

tabla_comparativa <- vol_group %>%
  group_by(group) %>%
  summarise(
    promedio_volatilidad = mean(vol_growth, na.rm = TRUE),
    sd_volatilidad       = sd(vol_growth,   na.rm = TRUE),
    n_paises             = n(),
    .groups = "drop"
  )

write_csv(tabla_comparativa,
          here("output", "tables", "tabla_comparativa_apertura.csv"))

# Test t de diferencia de medias
test_medias <- t.test(vol_growth ~ group, data = vol_group)

capture.output(
  test_medias,
  file = here("output", "tables", "test_apertura_volatilidad.txt")
)

# Regresión simple: volatilidad ~ apertura
modelo <- lm(vol_growth ~ openness_avg, data = vol)

capture.output(
  summary(modelo),
  file = here("output", "tables", "regresion_apertura_volatilidad.txt")
)

cat("06_inferencia.R: tabla comparativa, test t y regresión generados\n")
