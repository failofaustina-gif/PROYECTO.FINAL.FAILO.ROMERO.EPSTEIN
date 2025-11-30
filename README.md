# Proyecto Final – Comercio internacional y volatilidad macroeconómica

## Hipótesis del estudio

El objetivo del trabajo es estudiar la relación entre la estructura del comercio exterior y la estabilidad del crecimiento económico. La hipótesis final que guía el análisis es la siguiente:

**La volatilidad del crecimiento económico es mayor en los países con menor dependencia externa, es decir, en economías donde las importaciones representan una proporción relativamente baja del comercio total.**

La dependencia externa se mide a través de un índice de “Import Reliance”, definido como la razón entre importaciones y comercio total (exportaciones + importaciones). La volatilidad se calcula como el desvío estándar del crecimiento anual del PBI real para cada país.

---

## Estructura del proyecto

El repositorio respeta la estructura de proyectos reproducibles utilizada en la materia:

- `datos/raw/`: datos crudos originales descargados de World Development Indicators (Banco Mundial).  
- `datos/clean/`: datos limpios tras el tratamiento de faltantes y outliers.  
- `datos/processed/`: datos procesados con variables derivadas, incluyendo comercio total, dependencia externa y volatilidad del crecimiento por país.  

- `output/tables/`: tablas de salida del análisis (resumen de NA, descriptivas, tabla comparativa entre grupos, resultados de pruebas de hipótesis y regresión, etc.).  
- `output/figures/`: gráficos producidos a lo largo del proyecto (histogramas exploratorios y gráficos editorializados para la presentación).

- `scripts/`: scripts numerados que forman un pipeline secuencial y reproducible.  
- `README.md`: este archivo.

---

## Cómo reproducir el análisis

1. Clonar o descargar el repositorio.  
2. Abrir el archivo de proyecto `PROYECTO.FINAL.Rproj` en RStudio.  
3. Ejecutar, en orden, los siguientes scripts:

```r
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")
