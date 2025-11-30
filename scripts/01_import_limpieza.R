# ============================================================
# 01_import_limpieza.R
# Importa datos crudos del WDI y arma base panel limpia básica
# ============================================================

library(dplyr)
library(readr)
library(here)

# Exportaciones (% PBI)
exp <- read_csv(here("datos", "raw", "WB_WDI_NE_EXP_GNFS_ZS.csv")) %>%
  transmute(
    country_code    = REF_AREA,
    country_name    = REF_AREA_LABEL,
    year            = as.integer(TIME_PERIOD),
    exports_pct_gdp = as.numeric(OBS_VALUE)
  )

# Importaciones (% PBI)
imp <- read_csv(here("datos", "raw", "WB_WDI_NE_IMP_GNFS_ZS.csv")) %>%
  transmute(
    country_code    = REF_AREA,
    country_name    = REF_AREA_LABEL,
    year            = as.integer(TIME_PERIOD),
    imports_pct_gdp = as.numeric(OBS_VALUE)
  )

# Crecimiento del PBI real (%)
growth <- read_csv(here("datos", "raw", "WB_WDI_NY_GDP_MKTP_KD_ZG.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year         = as.integer(TIME_PERIOD),
    gdp_growth   = as.numeric(OBS_VALUE)
  )

# Unificar en una sola base panel
base_clean <- exp %>%
  full_join(imp,    by = c("country_code", "country_name", "year")) %>%
  full_join(growth, by = c("country_code", "country_name", "year"))

# Crear carpeta si no existe
if (!dir.exists(here("datos", "clean"))) {
  dir.create(here("datos", "clean"), recursive = TRUE)
}

write_csv(base_clean, here("datos", "clean", "base_clean.csv"))

cat("01_import_limpieza.R: base_clean.csv creado en datos/clean\n")
