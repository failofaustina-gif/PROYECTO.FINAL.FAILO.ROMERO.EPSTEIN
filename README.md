Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si la estructura del comercio exterior de un país —especialmente su nivel de dependencia externa— se asocia con una mayor o menor volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor dependencia externa presentan una mayor volatilidad del crecimiento del PBI.

Se compara:

la dependencia externa promedio de cada país

la volatilidad del crecimiento, medida como el desvío estándar del crecimiento anual del PBI

2. Datos utilizados

Todos los datos provienen de World Development Indicators (Banco Mundial):

Exportaciones (% PBI)

Importaciones (% PBI)

Crecimiento del PBI real (% anual)

Datos crudos ubicados en:

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


Cada script toma como entrada la salida del anterior → análisis 100% reproducible.

4. Cómo reproducir el análisis

Abrir el archivo PROYECTO.FINAL.Rproj en RStudio y ejecutar en este orden:

    source("scripts/01_import_limpieza.R")
    source("scripts/02_outliers_faltantes.R")
    source("scripts/03_procesamiento.R")
    source("scripts/04_eda.R")
    source("scripts/05_descriptivas.R")
    source("scripts/06_inferencia.R")
    source("scripts/07_graficos.R")


Esto genera automáticamente:

datos limpios y procesados (datos/)

tablas (output/tables/)

gráficos finales (output/figures/)

5. Descripción breve de los scripts

01_import_limpieza.R → importa datos y genera base_clean.csv.
02_outliers_faltantes.R → detecta NA/outliers y crea reportes.
03_procesamiento.R → calcula import reliance y volatilidad.
04_eda.R → descripciones básicas e histogramas.
05_descriptivas.R → estadísticos de dependencia y volatilidad.
06_inferencia.R → test t y regresión entre grupos.
07_graficos.R → gráficos editoriales finales.

6. Gráficos principales

grafico_dependencia_vs_volatilidad.png
Relación entre dependencia externa y volatilidad del crecimiento.

grafico_boxplot_grupos.png
Comparación entre países muy dependientes y poco dependientes.

grafico_top20_volatilidad.png
Ranking de los 20 países más volátiles.

(EDA opcional)
histogramas y boxplots para ver distribución de variables.

7. Principales resultados

La relación lineal entre dependencia externa y volatilidad es débil.

Los países con baja dependencia externa muestran mayor dispersión en volatilidad.

El test t detecta diferencias, pero no concluyentes.

La regresión simple muestra un coeficiente negativo, aunque débil.

8. Conclusión

La evidencia no confirma la hipótesis inicial.
La volatilidad parece explicarse más por diversificación productiva que por nivel de dependencia externa.

9. Autores

Faustina Faílo

Federico Romero

Julia Epstein
