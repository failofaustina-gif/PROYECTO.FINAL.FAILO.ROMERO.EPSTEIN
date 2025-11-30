Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si la estructura del comercio exterior de un país —especialmente su nivel de dependencia externa— se asocia con una mayor o menor volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor dependencia externa (import reliance) presentan una mayor volatilidad del crecimiento del PBI.

Para contrastarla, se comparan:

la dependencia externa promedio de cada país, y

la volatilidad del crecimiento, medida como el desvío estándar del crecimiento anual del PBI.

2. Datos utilizados

Todos los datos provienen de World Development Indicators (Banco Mundial):

Exportaciones de bienes y servicios (% del PBI)

Importaciones de bienes y servicios (% del PBI)

Crecimiento del PBI real (% anual)

Los archivos originales están en:

datos/raw/

3. Estructura del proyecto

El repositorio sigue un formato reproducible estándar:

datos/
  raw/          # Datos originales
  clean/        # Datos limpios
  processed/    # Datos procesados (indicadores)

output/
  tables/       # Tablas del análisis
  figures/      # Gráficos exploratorios y finales

scripts/        # Pipeline completo del análisis
PROYECTO.FINAL.Rproj
README.md


Cada script toma como entrada el resultado del script anterior, asegurando autocontención y reproducibilidad.

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

datos limpios y procesados (datos/)

tablas de análisis (output/tables/)

gráficos exploratorios y editoriales finales (output/figures/)

5. Descripción de los scripts
01_import_limpieza.R

Importa las bases crudas, estandariza nombres, unifica formatos y crea base_clean.csv.

02_outliers_faltantes.R

Detecta NA y outliers (regla IQR), documenta decisiones y genera reportes.
Produce base_clean2.csv.

03_procesamiento.R

Calcula los indicadores clave:

trade_total

import_reliance (dependencia externa)

vol_growth (volatilidad del crecimiento)

Genera base_processed.csv y vol_country.csv.

04_eda.R

Exploración inicial: dimensiones, primeras observaciones y distribuciones básicas.

05_descriptivas.R

Estadísticas de dependencia externa y volatilidad general, incluyendo un boxplot general.

06_inferencia.R

Comparación entre países muy dependientes y poco dependientes:

diferencias de medias

test t

regresión lineal simple

Guarda resultados en output/tables/.

07_graficos.R

Genera los gráficos editoriales finales:

relación dependencia–volatilidad

comparación entre grupos

ranking de países más volátiles

Guardados en output/figures/.

6. Gráficos del estudio

grafico_dependencia_vs_volatilidad.png
Relación entre la dependencia externa promedio y la volatilidad del crecimiento. Evalúa directamente la hipótesis.

grafico_boxplot_grupos.png
Compara la volatilidad entre países muy dependientes y poco dependientes.

grafico_top20_volatilidad.png
Top 20 países más volátiles y su nivel de dependencia externa.

(EDA opcional)
hist_gdp_growth.png – distribución del crecimiento del PBI
hist_import_reliance_avg.png – distribución de dependencia externa
boxplot_volatilidad.png – dispersión general de volatilidad

7. Principales resultados

La relación lineal entre dependencia externa y volatilidad del crecimiento es débil.

Los países con baja dependencia externa muestran, en promedio, mayor dispersión en su volatilidad.

El test t detecta diferencias entre grupos, aunque no determinantes.

La regresión simple sugiere un coeficiente negativo (mayor dependencia → menor volatilidad), pero la relación es débil.

8. Conclusión

La evidencia empírica no confirma la hipótesis inicial.
La volatilidad del crecimiento no aumenta sistemáticamente con la dependencia externa.

Muchos países con baja dependencia —a menudo economías primarizadas— muestran volatilidad elevada por factores estructurales, shocks externos y baja diversificación productiva.

En síntesis, la estabilidad macroeconómica parece depender más de la diversificación que del grado de apertura o dependencia externa.

9. Autores

Faustina Faílo

Federico Romero

Julia Epstein
