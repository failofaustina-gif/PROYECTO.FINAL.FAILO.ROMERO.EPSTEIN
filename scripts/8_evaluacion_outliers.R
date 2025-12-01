# ================================================================
# 08_evaluacion_outliers.R
# Evaluación del impacto de los outliers en la inferencia
# ================================================================

library(dplyr)
library(readr)
library(here)

# 1. Cargar la base de indicadores por país (vol_country.csv)
#    Es la misma base usada en 06_inferencia.R
vol <- read_csv(here("datos", "processed", "vol_country.csv"))

if (!dir.exists(here("output", "tables"))) {
  dir.create(here("output", "tables"), recursive = TRUE)
}

# Quitamos países sin apertura promedio, igual que en 06_inferencia.R
vol_base <- vol %>% filter(!is.na(openness_avg))

# 2. Detección de outliers en la variable clave: vol_growth
#    Usamos la regla IQR, como en 02_outliers_faltantes.R
detect_outliers_iqr <- function(x) {
  if (!is.numeric(x)) return(rep(FALSE, length(x)))
  q1  <- quantile(x, 0.25, na.rm = TRUE)
  q3  <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  x < (q1 - 1.5 * iqr) | x > (q3 + 1.5 * iqr)
}

vol_base <- vol_base %>%
  mutate(
    outlier_vol_growth = detect_outliers_iqr(vol_growth)
  )

# Base sin outliers de vol_growth
vol_no_outliers <- vol_base %>%
  filter(!outlier_vol_growth)

n_outliers <- sum(vol_base$outlier_vol_growth)
cat(sprintf("08_evaluacion_outliers.R: se detectaron %d países outliers en 'vol_growth' (regla IQR).\n",
            n_outliers))

# 3. Comparación de resultados: regresión lineal (vol_growth ~ openness_avg)

# A) Modelo original (con outliers)
modelo_original <- lm(vol_growth ~ openness_avg, data = vol_base)
summary_original <- summary(modelo_original)

# B) Modelo sin outliers
modelo_sin_outliers <- lm(vol_growth ~ openness_avg, data = vol_no_outliers)
summary_sin_outliers <- summary(modelo_sin_outliers)

# Extraer y comparar coeficientes de 'openness_avg'
coef_original    <- summary_original$coefficients["openness_avg", "Estimate"]
pval_original    <- summary_original$coefficients["openness_avg", "Pr(>|t|)"]

coef_sin_outlier <- summary_sin_outliers$coefficients["openness_avg", "Estimate"]
pval_sin_outlier <- summary_sin_outliers$coefficients["openness_avg", "Pr(>|t|)"]

tabla_comparativa_reg <- tibble::tibble(
  Escenario         = c("Con outliers", "Sin outliers"),
  Beta_openness_avg = c(coef_original, coef_sin_outlier),
  P_valor           = c(pval_original, pval_sin_outlier)
)

write_csv(
  tabla_comparativa_reg,
  here("output", "tables", "regresion_comparativa_outliers.csv")
)

cat("\n--- Resultados de regresión (beta de apertura) ---\n")
print(tabla_comparativa_reg)

# 4. Comparación de resultados: test t de diferencia de medias
#    (alta vs baja apertura)

# A) Grupos por mediana en ambas bases
mediana_ap <- median(vol_base$openness_avg, na.rm = TRUE)

vol_base_group <- vol_base %>%
  mutate(group = ifelse(openness_avg >= mediana_ap, "Alta apertura", "Baja apertura"))

vol_no_outliers_group <- vol_no_outliers %>%
  mutate(group = ifelse(openness_avg >= mediana_ap, "Alta apertura", "Baja apertura"))

# B) Test t original (con outliers)
test_original <- t.test(vol_growth ~ group, data = vol_base_group)
pval_test_original <- test_original$p.value

# C) Test t sin outliers
test_sin_outliers <- t.test(vol_growth ~ group, data = vol_no_outliers_group)
pval_test_sin_outliers <- test_sin_outliers$p.value

tabla_comparativa_ttest <- tibble::tibble(
  Escenario      = c("Con outliers", "Sin outliers"),
  P_valor_test_t = c(pval_test_original, pval_test_sin_outliers)
)

write_csv(
  tabla_comparativa_ttest,
  here("output", "tables", "ttest_comparativo_outliers.csv")
)

cat("\n--- Resultados de test t (p-valor) ---\n")
print(tabla_comparativa_ttest)

# 5. Listado de países outliers detectados
lista_outliers <- vol_base %>%
  filter(outlier_vol_growth) %>%
  select(country_name, vol_growth, openness_avg) %>%
  arrange(desc(vol_growth))

write_csv(
  lista_outliers,
  here("output", "tables", "paises_outliers_vol_growth.csv")
)

cat(sprintf(
  "\n08_evaluacion_outliers.R: el listado de %d países outliers está en paises_outliers_vol_growth.csv\n",
  n_outliers
))

# ================================================================
# FIN 08_evaluacion_outliers.R
# ================================================================
