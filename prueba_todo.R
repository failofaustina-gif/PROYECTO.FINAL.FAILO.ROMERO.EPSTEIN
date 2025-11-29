## prueba_todo.R
## Test completo del pipeline en un solo archivo

packages <- c("here", "dplyr", "readr", "ggplot2", "tidyr")

installed <- rownames(installed.packages())
to_install <- packages[!packages %in% installed]
if (length(to_install) > 0) install.packages(to_install)

invisible(lapply(packages, library, character.only = TRUE))

cat("Raíz del proyecto detectada por here():\n")
print(here())

## 1) Importar bases principales desde datos/raw

exp <- read_csv(here("datos","raw","WB_WDI_NE_EXP_GNFS_ZS.csv")) %>%
  transmute(
    country_code    = REF_AREA,
    country_name    = REF_AREA_LABEL,
    year            = as.integer(TIME_PERIOD),
    exports_pct_gdp = OBS_VALUE
  )

imp <- read_csv(here("datos","raw","WB_WDI_NE_IMP_GNFS_ZS.csv")) %>%
  transmute(
    country_code    = REF_AREA,
    country_name    = REF_AREA_LABEL,
    year            = as.integer(TIME_PERIOD),
    imports_pct_gdp = OBS_VALUE
  )

trd <- read_csv(here("datos","raw","WB_WDI_NE_TRD_GNFS_ZS.csv")) %>%
  transmute(
    country_code   = REF_AREA,
    country_name   = REF_AREA_LABEL,
    year           = as.integer(TIME_PERIOD),
    trade_pct_gdp  = OBS_VALUE
  )

gdp_growth <- read_csv(here("datos","raw","WB_WDI_NY_GDP_MKTP_KD_ZG.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year         = as.integer(TIME_PERIOD),
    gdp_growth   = OBS_VALUE
  )

ied <- read_csv(here("datos","raw","WB_WDI_BX_KLT_DINV_WD_GD_ZS.csv")) %>%
  transmute(
    country_code = REF_AREA,
    country_name = REF_AREA_LABEL,
    year         = as.integer(TIME_PERIOD),
    ied_pct_gdp  = OBS_VALUE
  )

## 2) PBI nivel: soportar dos formatos distintos

path_sdmx <- here("datos","raw","WB_WDI_NY_GDP_MKTP_CD.csv")
path_api  <- here("datos","raw","API_NY.GDP.MKTP.CD_DS2_en_csv_v2_280632.csv")

tiene_pbi_level <- FALSE

if (file.exists(path_sdmx)) {
  cat("Se encontró PBI nivel en formato SDMX (WB_WDI_...).\n")
  gdp_level <- read_csv(path_sdmx) %>%
    transmute(
      country_code    = REF_AREA,
      country_name    = REF_AREA_LABEL,
      year            = as.integer(TIME_PERIOD),
      gdp_current_usd = OBS_VALUE
    )
  tiene_pbi_level <- TRUE
} else if (file.exists(path_api)) {
  cat("Se encontró PBI nivel en formato API (API_NY.GDP.MKTP.CD_...).\n")
  raw_gdp <- read_csv(path_api, skip = 4)
  gdp_level <- raw_gdp %>%
    rename(
      country_name = `Country Name`,
      country_code = `Country Code`
    ) %>%
    pivot_longer(
      cols = matches("^\\d{4}$"),
      names_to = "year",
      values_to = "gdp_current_usd"
    ) %>%
    mutate(
      year = as.integer(year),
      gdp_current_usd = as.numeric(gdp_current_usd)
    )
  tiene_pbi_level <- TRUE
} else {
  cat("No se encontró archivo de PBI nivel. Se seguirá sin gravedad.\n")
}

## 3) Unir todo en una base panel

base <- exp %>%
  full_join(imp,  by = c("country_code","country_name","year")) %>%
  full_join(trd,  by = c("country_code","country_name","year")) %>%
  full_join(gdp_growth, by = c("country_code","country_name","year")) %>%
  full_join(ied, by = c("country_code","country_name","year"))

if (tiene_pbi_level) {
  base <- base %>%
    full_join(gdp_level, by = c("country_code","country_name","year"))
} else {
  base$gdp_current_usd <- NA_real_
}

base <- base %>%
  mutate(
    exports_pct_gdp = as.numeric(exports_pct_gdp),
    imports_pct_gdp = as.numeric(imports_pct_gdp),
    trade_pct_gdp   = as.numeric(trade_pct_gdp),
    gdp_growth      = as.numeric(gdp_growth),
    ied_pct_gdp     = as.numeric(ied_pct_gdp),
    gdp_current_usd = as.numeric(gdp_current_usd)
  )

cat("Dimensiones de la base unificada:\n")
print(dim(base))

## 4) Índice de Grubel & Lloyd

base <- base %>%
  mutate(
    sum_xm   = exports_pct_gdp + imports_pct_gdp,
    dif_xm   = abs(exports_pct_gdp - imports_pct_gdp),
    gl_index = ifelse(sum_xm > 0,
                      1 - dif_xm / sum_xm,
                      NA_real_)
  )

cat("GL calculado. Algunos valores:\n")
print(head(na.omit(base$gl_index), 10))

## 5) Gravedad simple (si hay PBI nivel)

if (tiene_pbi_level) {
  base <- base %>%
    mutate(
      trade_dollars = ifelse(
        !is.na(trade_pct_gdp) & !is.na(gdp_current_usd),
        trade_pct_gdp/100 * gdp_current_usd,
        NA_real_
      )
    )

  gravity <- base %>%
    filter(
      !is.na(trade_dollars),
      !is.na(gdp_current_usd),
      trade_dollars > 0,
      gdp_current_usd > 0
    ) %>%
    mutate(
      ln_trade = log(trade_dollars),
      ln_gdp   = log(gdp_current_usd)
    )

  cat("Observaciones usadas en el modelo de gravedad:\n")
  print(nrow(gravity))

  modelo_grav <- lm(ln_trade ~ ln_gdp, data = gravity)
  cat("Coeficientes del modelo de gravedad:\n")
  print(summary(modelo_grav)$coefficients)

  gravity <- gravity %>%
    mutate(
      ln_trade_expected = predict(modelo_grav),
      ln_trade_residual = ln_trade - ln_trade_expected
    )

  base <- base %>%
    left_join(
      gravity %>% select(country_code, year, ln_trade_residual),
      by = c("country_code","year")
    )
} else {
  base$ln_trade_residual <- NA_real_
}

## 6) Regresión rápida de prueba

data_inf <- base %>%
  filter(
    !is.na(gdp_growth),
    !is.na(trade_pct_gdp),
    !is.na(ied_pct_gdp),
    !is.na(gl_index)
  )

cat("Observaciones en la regresión de prueba:\n")
print(nrow(data_inf))

modelo <- lm(
  gdp_growth ~ trade_pct_gdp + ied_pct_gdp + gl_index + ln_trade_residual,
  data = data_inf
)

cat("\nResumen del modelo de prueba:\n")
print(summary(modelo))

## 7) Gráfico simple GL vs crecimiento promedio

prom <- base %>%
  group_by(country_code, country_name) %>%
  summarise(
    mean_growth = mean(gdp_growth, na.rm = TRUE),
    mean_gl     = mean(gl_index,    na.rm = TRUE),
    .groups = "drop"
  )

p <- ggplot(prom, aes(x = mean_gl, y = mean_growth)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "GL promedio y crecimiento promedio",
    x = "Índice de Grubel-Lloyd",
    y = "Crecimiento promedio del PBI (%)"
  )

if (!dir.exists(here("output","figures"))) {
  dir.create(here("output","figures"), recursive = TRUE)
}

ggsave(
  here("output","figures","prueba_gl_vs_growth.png"),
  p, width = 7, height = 5
)

cat("\nScript de prueba terminado. Mirá la consola y output/figures/prueba_gl_vs_growth.png\n")
