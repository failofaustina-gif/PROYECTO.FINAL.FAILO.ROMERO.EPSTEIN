library(dplyr)
library(here)

vol <- read.csv(here("datos","processed","volatilidad.csv"))

# Dividir países en alta y baja dependencia externa
vol <- vol %>%
  mutate(group = case_when(
    import_reliance_avg >= 0.6 ~ "Alta dependencia",
    import_reliance_avg <= 0.4 ~ "Baja dependencia",
    TRUE ~ NA
  )) %>%
  filter(!is.na(group))

# Test t de diferencia de medias
test_medias <- t.test(vol_growth ~ group, data = vol)

capture.output(test_medias, file = here("output","tables","test_dependencia.txt"))

# Regresión simple
modelo <- lm(vol_growth ~ import_reliance_avg, data = vol)

capture.output(summary(modelo), file = here("output","tables","regresion_dependencia.txt"))
