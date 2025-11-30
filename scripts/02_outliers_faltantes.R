# =======================================================================
# 02_outliers_faltantes.R
# Analiza NA y outliers, documenta decisiones y guarda base_clean2.csv
# =======================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos","clean","base_clean.csv"))

if (!dir.exists(here("output","tables"))) {
  dir.create(here("output","tables"), recursive = TRUE)
}

# Resumen de NA (cuántos faltan por variable)
na_summary <- base %>% summarise(across(everything(), ~sum(is.na(.))))
write_csv(na_summary, here("output","tables","na_summary.csv"))

# Detección de outliers con regla IQR (solo numéricas)
detect_outliers <- function(x){
  if (!is.numeric(x)) return(rep(FALSE, length(x)))
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  x < (q1 - 1.5*iqr) | x > (q3 + 1.5*iqr)
}

outlier_flags <- base %>%
  mutate(across(where(is.numeric), detect_outliers, .names = "{.col}_outlier"))

write_csv(outlier_flags %>% select(ends_with("_outlier")),
          here("output","tables","outliers_flags.csv"))

# DECISIÓN:
# - eliminamos solo valores IMPOSIBLES (porcentaje negativo en comercio o IED)
# - mantenemos valores extremos plausibles de crecimiento

base_clean2 <- base %>%
  mutate(
    exports_pct_gdp = ifelse(exports_pct_gdp < 0, NA, exports_pct_gdp),
    imports_pct_gdp = ifelse(imports_pct_gdp < 0, NA, imports_pct_gdp),
    trade_pct_gdp   = ifelse(trade_pct_gdp   < 0, NA, trade_pct_gdp),
    ied_pct_gdp     = ifelse(ied_pct_gdp     < 0, NA, ied_pct_gdp)
  )

# Nuevo resumen de NA tras tratamiento
na_summary2 <- base_clean2 %>% summarise(across(everything(), ~sum(is.na(.))))
write_csv(na_summary2, here("output","tables","na_processed_summary.csv"))

write_csv(base_clean2, here("datos","clean","base_clean2.csv"))

cat("02_outliers_faltantes.R: base_clean2.csv creado en datos/clean/\n")
