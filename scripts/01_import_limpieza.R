library(dplyr)
library(readr)
library(here)

# Importar bases SDMX (exportaciones, importaciones, crecimiento, IED)
exp <- read_csv(here("datos","raw","WB_WDI_NE_EXP_GNFS_ZS.csv")) %>%
  transmute(country_code = REF_AREA,
            country_name = REF_AREA_LABEL,
            year = as.integer(TIME_PERIOD),
            exports_pct_gdp = as.numeric(OBS_VALUE))

imp <- read_csv(here("datos","raw","WB_WDI_NE_IMP_GNFS_ZS.csv")) %>%
  transmute(country_code = REF_AREA,
            country_name = REF_AREA_LABEL,
            year = as.integer(TIME_PERIOD),
            imports_pct_gdp = as.numeric(OBS_VALUE))

growth <- read_csv(here("datos","raw","WB_WDI_NY_GDP_MKTP_KD_ZG.csv")) %>%
  transmute(country_code = REF_AREA,
            country_name = REF_AREA_LABEL,
            year = as.integer(TIME_PERIOD),
            gdp_growth = as.numeric(OBS_VALUE))

# Unificar
base <- exp %>%
  full_join(imp,  by = c("country_code","country_name","year")) %>%
  full_join(growth, by = c("country_code","country_name","year"))

write_csv(base, here("datos","clean","base_clean.csv"))
