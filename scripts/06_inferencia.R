# ================================================================
# 06_inferencia.R
# Test de hipótesis y regresión
# ================================================================

library(dplyr)
library(readr)
library(here)

vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}

# Clasificación por grupos de dependencia externa
vol_group <- vol %>%
  mutate(
    group = case_when(
      import_reliance_avg >= 0.6 ~ "Alta dependencia",
      import_reliance_avg <= 0.4 ~ "Baja dependencia",
      TRUE                       ~ NA_character_
    )
  ) %>%
  filter(!is.na(group))

# Tabla comparativa de grupos
tabla_comparativa <- vol_group %>%
  group_by(group) %>%
  summarise(
    promedio_volatilidad = mean(vol_growth, na.rm = TRUE),
    sd_volatilidad       = sd(vol_growth,   na.rm = TRUE),
    n_paises             = n(),
    .groups = "drop"
  )

write_csv(tabla_comparativa,
          here("output", "tables", "tabla_comparativa_dependencia.csv"))

# Test t de diferencia de medias
test_medias <- t.test(vol_growth ~ group, data = vol_group)

capture.output(
  test_medias,
  file = here("output", "tables", "test_dependencia.txt")
)

# Regresión simple: volatilidad ~ dependencia externa
modelo <- lm(vol_growth ~ import_reliance_avg, data = vol)

capture.output(
  summary(modelo),
  file = here("output", "tables", "regresion_dependencia.txt")
)

cat("06_inferencia.R: tabla comparativa, test t y regresión generados\n")
