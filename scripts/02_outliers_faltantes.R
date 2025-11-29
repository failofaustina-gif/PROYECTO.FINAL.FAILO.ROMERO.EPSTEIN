# =======================================================================
# 02_outliers_faltantes.R
# Detecta NA, outliers, decisiones y guarda base_clean2.csv
# =======================================================================

library(dplyr)
library(here)
library(readr)

base <- read_csv(here("datos","clean","base_clean.csv"))

# --- NA -------------------------------------------------------------------

na_summary <- base %>%
  summarise(across(everything(), ~sum(is.na(.))))

write_csv(na_summary, here("output","tables","na_summary.csv"))

# --- OUTLIERS: método IQR -------------------------------------------------

detect_outliers <- function(x){
  if(!is.numeric(x)) return(rep(FALSE, length(x)))
  q1 <- quantile(x, 0.25, na.rm=TRUE)
  q3 <- quantile(x, 0.75, na.rm=TRUE)
  iqr <- q3 - q1
  x < (q1 - 1.5*iqr) | x > (q3 + 1.5*iqr)
}

outlier_df <- base %>%
  mutate(across(where(is.numeric), detect_outliers, .names="{.col}_outlier_flag"))

write_csv(outlier_df %>% select(ends_with("_outlier_flag")),
          here("output","tables","outliers_flags.csv"))

# --- DECISIONES ------------------------------------------------------------
# NA: mantener si falta mucha información, eliminar si es poco
# outliers: se eliminan únicamente los imposibles (negativos)

base2 <- base %>%
  filter(
    exports_pct_gdp >= 0 | is.na(exports_pct_gdp),
    imports_pct_gdp >= 0 | is.na(imports_pct_gdp),
    trade_pct_gdp   >= 0 | is.na(trade_pct_gdp),
    ied_pct_gdp     >= 0 | is.na(ied_pct_gdp)
  )

write_csv(base2, here("datos","clean","base_clean2.csv"))

cat("Base con NA/outliers tratados en datos/clean/base_clean2.csv\n")
