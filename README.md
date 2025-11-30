Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si el grado de apertura comercial de un país está asociado con su volatilidad del crecimiento económico.

Hipótesis

Los países con mayor apertura comercial presentan una volatilidad del crecimiento más elevada.

2. Datos utilizados

Fuente: World Development Indicators (Banco Mundial).

Variables:

Exportaciones (% PBI)

Importaciones (% PBI)

Crecimiento del PBI real (% anual)

Datos originales en:

datos/raw/

3. Estructura del proyecto
datos/
  raw/
  clean/
  processed/

output/
  tables/
  figures/

scripts/
README.md
PROYECTO.FINAL.Rproj

4. Cómo reproducir el análisis

Abrir PROYECTO.FINAL.Rproj en RStudio.

Ejecutar los scripts en este orden:

source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Esto genera automáticamente:

datos limpios y procesados (carpeta datos/)

tablas (output/tables/)

gráficos finales (output/figures/)

5. Scripts

01_import_limpieza.R: importa datos crudos y genera base_clean.csv.
02_outliers_faltantes.R: detecta NA/outliers y genera base_clean2.csv.
03_procesamiento.R: crea indicadores y produce base_processed.csv.
04_eda.R: gráficos y exploración inicial.
05_descriptivas.R: estadísticas descriptivas.
06_inferencia.R: test t y regresión.
07_graficos.R: gráficos finales editoriales.

6. Gráficos del estudio

grafico_apertura_vs_volatilidad.png → relación directa entre apertura y volatilidad.
grafico_boxplot_grupos_apertura.png → comparación entre países más y menos abiertos.
grafico_top20_volatilidad.png → países más volátiles.

EDA opcional:

hist_gdp_growth.png

hist_import_reliance_avg.png

boxplot_volatilidad.png

7. Resultados

No se confirma que mayor apertura implique mayor volatilidad.

Países de baja apertura suelen ser más volátiles por especialización productiva.

La regresión muestra relación débil.

8. Conclusión

La volatilidad macroeconómica está más asociada a la diversificación productiva que al grado de apertura comercial.

9. Autores

Faustina Faílo
Federico Romero
Julia Epstein
