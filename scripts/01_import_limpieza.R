# =======================================================================
# 01_import_limpieza.R
# Importa bases crudas, renombra, homogeniza, limpia tipologías y guarda
# datos limpios en datos/clean/
# =======================================================================

library(dplyr)
library(readr)
library(here)

# --- 1) Importar datos RAW -------------------------------------------------

exp <- read_csv(here("datos","raw","WB_WDI_NE_EXP_GNFS_ZS.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year = as.integer(TIME_PERIOD),
    exports_pct_gdp = as.numeric(OBS_VALUE)
  )

imp <- read_csv(here("datos","raw","WB_WDI_NE_IMP_GNFS_ZS.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year = as.integer(TIME_PERIOD),
    imports_pct_gdp = as.numeric(OBS_VALUE)
  )

trade <- read_csv(here("datos","raw","WB_WDI_NE_TRD_GNFS_ZS.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year = as.integer(TIME_PERIOD),
    trade_pct_gdp = as.numeric(OBS_VALUE)
  )

gdp_growth <- read_csv(here("datos","raw","WB_WDI_NY_GDP_MKTP_KD_ZG.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year = as.integer(TIME_PERIOD),
    gdp_growth = as.numeric(OBS_VALUE)
  )

ied <- read_csv(here("datos","raw","WB_WDI_BX_KLT_DINV_WD_GD_ZS.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year = as.integer(TIME_PERIOD),
    ied_pct_gdp = as.numeric(OBS_VALUE)
  )

# --- 2) Unir ---------------------------------------------------------------

base_clean <- exp %>%
  full_join(imp,  by=c("country_code","country_name","year")) %>%
  full_join(trade, by=c("country_code","country_name","year")) %>%
  full_join(gdp_growth, by=c("country_code","country_name","year")) %>%
  full_join(ied, by=c("country_code","country_name","year"))

# --- 3) Guardar base limpia -------------------------------------------------

write_csv(base_clean, here("datos","clean","base_clean.csv"))

cat("Base limpia creada en datos/clean/base_clean.csv\n")
