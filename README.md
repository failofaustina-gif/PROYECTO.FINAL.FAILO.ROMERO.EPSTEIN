Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si la estructura del comercio exterior —en particular la dependencia externa— se relaciona con la volatilidad del crecimiento económico.

Hipótesis

Los países con mayor dependencia externa presentan mayor volatilidad del crecimiento del PBI.

2. Datos utilizados

Datos provenientes de World Development Indicators:

Importaciones (% del PBI)

Exportaciones (% del PBI)

Crecimiento del PBI real (% anual)

Los datos crudos están en:

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
PROYECTO.FINAL.Rproj
README.md

4. Cómo reproducir el análisis

Descargar o clonar el repositorio.

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

datos limpios y procesados

tablas en output/tables/

gráficos en output/figures/

5. Breve descripción de los scripts

01_import_limpieza.R — Importa datos crudos y genera base_clean.csv.
02_outliers_faltantes.R — Detecta NA/outliers y genera reportes.
03_procesamiento.R — Calcula dependencia externa y volatilidad.
04_eda.R — Exploración inicial e histogramas.
05_descriptivas.R — Estadísticas descriptivas.
06_inferencia.R — Diferencias entre grupos y regresión.
07_graficos.R — Gráficos editoriales finales.

6. Gráficos principales

grafico_dependencia_vs_volatilidad.png — relación entre dependencia y volatilidad.
grafico_boxplot_grupos.png — volatilidad según grupos de dependencia.
grafico_top20_volatilidad.png — países más volátiles.

7. Resultados

La relación entre dependencia externa y volatilidad es débil, y no confirma la hipótesis inicial.

8. Autores

Faustina Faílo

Federico Romero

Julia Epstein
