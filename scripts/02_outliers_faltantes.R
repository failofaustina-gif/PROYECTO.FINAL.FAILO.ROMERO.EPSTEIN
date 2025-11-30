# =================================================================
# 02_outliers_faltantes.R
# Analiza datos faltantes y outliers, documenta decisiones
# =================================================================

library(dplyr)
library(readr)
library(here)

base <- read_csv(here("datos", "clean", "base_clean.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}

# Resumen de NA por variable
na_summary <- base %>%
  summarise(across(everything(), ~ sum(is.na(.))))

write_csv(na_summary, here("output", "tables", "na_summary.csv"))

# Detección simple de outliers por regla IQR (numéricas)
detect_outliers <- function(x) {
  if (!is.numeric(x)) return(rep(FALSE, length(x)))
  q1  <- quantile(x, 0.25, na.rm = TRUE)
  q3  <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  x < (q1 - 1.5 * iqr) | x > (q3 + 1.5 * iqr)
}

outliers_flags <- base %>%
  mutate(across(where(is.numeric), detect_outliers, .names = "{.col}_outlier"))

write_csv(outliers_flags %>% select(ends_with("_outlier")),
          here("output", "tables", "outliers_flags.csv"))

# Limpieza mínima: no permitimos porcentajes negativos
base_clean2 <- base %>%
  mutate(
    exports_pct_gdp = ifelse(exports_pct_gdp < 0, NA, exports_pct_gdp),
    imports_pct_gdp = ifelse(imports_pct_gdp < 0, NA, imports_pct_gdp),
    gdp_growth      = gdp_growth
  )

na_summary2 <- base_clean2 %>%
  summarise(across(everything(), ~ sum(is.na(.))))

write_csv(na_summary2, here("output", "tables", "na_processed_summary.csv"))

write_csv(base_clean2, here("datos", "clean", "base_clean2.csv"))

cat("02_outliers_faltantes.R: base_clean2.csv creado en datos/clean\n")
