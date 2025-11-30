# =======================================================================
# 03_procesamiento.R
# Crea variables derivadas (GL, desequilibrio) y guarda base_processed.csv
# =======================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos","clean","base_clean2.csv"))

base_processed <- base %>%
  mutate(
    sum_xm  = exports_pct_gdp + imports_pct_gdp,
    dif_xm  = abs(exports_pct_gdp - imports_pct_gdp),
    gl_index = ifelse(sum_xm > 0, 1 - dif_xm / sum_xm, NA_real_)
  )

if (!dir.exists(here("datos","processed"))) {
  dir.create(here("datos","processed"), recursive = TRUE)
}

write_csv(base_processed, here("datos","processed","base_processed.csv"))

cat("03_procesamiento.R: base_processed.csv creado en datos/processed/\n")
