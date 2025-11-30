Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si el grado de apertura comercial de un país está asociado con una mayor o menor volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor apertura comercial presentan una volatilidad del crecimiento más elevada.

La hipótesis se evalúa comparando:

el nivel de apertura comercial promedio por país, y

la volatilidad del crecimiento del PBI (desvío estándar del crecimiento anual).

2. Datos utilizados

Fuente principal: World Development Indicators (Banco Mundial).

Variables empleadas:

Exportaciones de bienes y servicios (% del PBI)

Importaciones de bienes y servicios (% del PBI)

Crecimiento del PBI real (% anual)

Los archivos originales están en:

datos/raw/

3. Estructura del proyecto
datos/
  raw/          # Datos originales crudos
  clean/        # Datos limpios
  processed/    # Datos procesados y agregados

output/
  tables/       # Tablas del análisis (comparativas, tests, descriptivas)
  figures/      # Gráficos exploratorios y gráficos finales editoriales

scripts/        # Pipeline completo (.R)
README.md
PROYECTO.FINAL.Rproj


Cada script usa como insumo el resultado del anterior, garantizando reproducibilidad.

4. Cómo reproducir el análisis

Descargar o clonar el repositorio.

Abrir el archivo PROYECTO.FINAL.Rproj en RStudio.

Ejecutar los scripts en este orden:

source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Esto genera automáticamente:

datos limpios y procesados (carpeta datos/),

tablas de análisis (carpeta output/tables/),

gráficos finales (carpeta output/figures/).

5. Descripción de los scripts
01_import_limpieza.R

Importa las bases crudas, estandariza nombres, unifica series y genera base_clean.csv.

02_outliers_faltantes.R

Identifica valores faltantes y outliers con regla IQR.
Produce base_clean2.csv y reportes en output/tables/.

03_procesamiento.R

Crea los indicadores clave:

apertura_comercial

volatilidad del crecimiento

Genera base_processed.csv y vol_country.csv.

04_eda.R

Exploración inicial: dimensiones, primeros registros, histogramas de crecimiento y apertura.

05_descriptivas.R

Estadísticas descriptivas de apertura y volatilidad + boxplot general.

06_inferencia.R

Comparación por grupos (alta vs baja apertura), test t y regresión lineal.
Resultados guardados en output/tables/.

07_graficos.R

Genera gráficos editoriales finales:

apertura vs volatilidad,

volatilidad por grupos,

top 20 países más volátiles.

Guardados en output/figures/.

6. Gráficos del estudio

grafico_apertura_vs_volatilidad.png
Relación entre apertura comercial y volatilidad.
Evalúa directamente la hipótesis.

grafico_boxplot_grupos_apertura.png
Compara la volatilidad entre países muy abiertos y poco abiertos.

grafico_top20_volatilidad.png
Identifica los países más volátiles y su nivel de apertura.

(EDA opcional)

hist_gdp_growth.png – Distribución del crecimiento

hist_import_reliance_avg.png – Distribución de apertura

boxplot_volatilidad.png – Dispersión general de la volatilidad

7. Principales resultados

La relación apertura–volatilidad es débil.

La volatilidad no aumenta sistemáticamente con la apertura comercial.

Los países de baja apertura suelen ser más volátiles por falta de diversificación.

La regresión y los tests no confirman la hipótesis inicial.

8. Conclusión

La evidencia no valida que la apertura comercial genere mayor inestabilidad.
La volatilidad del crecimiento parece estar más vinculada a la estructura productiva que al grado de apertura.

En economías con poca diversificación —típicamente exportadoras de commodities— la volatilidad es alta incluso con baja apertura.

9. Autores

Faustina Faílo

Federico Romero

Julia Epstein
