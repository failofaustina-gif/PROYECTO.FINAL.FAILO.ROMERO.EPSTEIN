# =======================================================================
# 06_inferencia.R
# Inferencia:
# 1) Test de diferencias de apertura entre países GL alto vs GL bajo
# 2) Regresión exploratoria del crecimiento
# =======================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos","processed","base_processed.csv"))

if (!dir.exists(here("output","tables"))) {
  dir.create(here("output","tables"), recursive = TRUE)
}

# ---- 1) Países según GL promedio -----------------------------------------

gl_groups <- base %>%
  group_by(country_code, country_name) %>%
  summarise(
    gl_prom        = mean(gl_index,        na.rm = TRUE),
    apertura_prom  = mean(trade_pct_gdp,   na.rm = TRUE),
    desequilibrio_prom = mean(abs(exports_pct_gdp - imports_pct_gdp), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  filter(!is.na(gl_prom))

mediana_gl <- median(gl_groups$gl_prom, na.rm = TRUE)

gl_groups <- gl_groups %>%
  mutate(
    grupo_gl = ifelse(gl_prom >= mediana_gl, "GL alto", "GL bajo")
  )

write_csv(gl_groups, here("output","tables","comparacion_grupos_gl.csv"))

# Test de diferencia de medias en apertura
test_apertura <- t.test(apertura_prom ~ grupo_gl, data = gl_groups)

capture.output(
  test_apertura,
  file = here("output","tables","test_diferencias_apertura_gl.txt")
)

# Opcional: test sobre desequilibrio
test_deseq <- t.test(desequilibrio_prom ~ grupo_gl, data = gl_groups)
capture.output(
  test_deseq,
  file = here("output","tables","test_diferencias_desequilibrio_gl.txt")
)

# ---- 2) Regresión exploratoria de crecimiento ----------------------------

base_reg <- base %>%
  filter(
    !is.na(gdp_growth),
    !is.na(trade_pct_gdp),
    !is.na(ied_pct_gdp),
    !is.na(gl_index)
  )

modelo_crec <- lm(
  gdp_growth ~ trade_pct_gdp + ied_pct_gdp + gl_index,
  data = base_reg
)

capture.output(
  summary(modelo_crec),
  file = here("output","tables","regresion_crecimiento.txt")
)

cat("06_inferencia.R: tests de grupos y regresión generados.\n")
