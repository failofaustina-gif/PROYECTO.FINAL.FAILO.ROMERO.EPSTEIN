Proyecto Final — Apertura Comercial y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si el grado de integración comercial de un país, medido a través de su apertura comercial, se asocia con la volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor apertura comercial (exportaciones + importaciones como porcentaje del PBI) presentan menor volatilidad en su crecimiento económico.

Esto se evalúa midiendo, para cada país:

su apertura promedio,

la volatilidad del crecimiento, definida como el desvío estándar del crecimiento anual del PBI real.

2. Datos utilizados

Los datos provienen de World Development Indicators (Banco Mundial):

Exportaciones de bienes y servicios (% del PBI)

Importaciones de bienes y servicios (% del PBI)

Crecimiento del PBI real (% anual)

Los archivos originales se encuentran en la carpeta:

datos/raw/

3. Estructura del proyecto

El repositorio sigue una estructura reproducible:

datos/
  raw/          # Datos originales
  clean/        # Datos limpios
  processed/    # Datos procesados (indicadores)

output/
  tables/       # Tablas del análisis
  figures/      # Gráficos del análisis

scripts/        # Scripts numerados del pipeline
README.md
PROYECTO.FINAL.Rproj


Cada script toma como entrada la salida del anterior y genera resultados reproducibles.

4. Cómo reproducir el análisis

Para ejecutar el pipeline completo que produce todos los datos limpios, indicadores, tablas y gráficos:

1. Descargar o clonar el repositorio
git clone https://github.com/failofaustina-gif/PROYECTO.FINAL.FAILO.ROMERO.EPSTEIN.git


O descargar el ZIP desde GitHub.

2. Abrir el proyecto en RStudio

Abrir el archivo:

PROYECTO.FINAL.Rproj


Esto permite que los paths funcionen correctamente mediante {here}.

3. Instalar los paquetes necesarios (solo la primera vez)
install.packages(c("dplyr", "readr", "ggplot2", "here"))

4. Ejecutar los scripts en orden
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Al finalizar, se generan automáticamente:

datos limpios en datos/clean/

datos procesados en datos/processed/

tablas del análisis en output/tables/

gráficos finales en output/figures/

No debe modificarse ningún path. El análisis es totalmente reproducible.

5. Descripción de los scripts
01_import_limpieza.R

Importa las bases crudas de exportaciones, importaciones y crecimiento del PBI. Unifica nombres y genera base_clean.csv.

02_outliers_faltantes.R

Identifica y cuantifica datos faltantes, detecta outliers mediante la regla IQR y documenta decisiones. Genera base_clean2.csv.

03_procesamiento.R

Crea los indicadores centrales:

apertura comercial (trade_total)

apertura promedio por país (openness_avg)

volatilidad del crecimiento (vol_growth)

Genera base_processed.csv (panel país-año) y vol_country.csv (indicadores agregados).

04_eda.R

Realiza el análisis exploratorio:

dimensiones de la base

primeras observaciones

histograma del crecimiento del PBI

histograma de apertura promedio

05_descriptivas.R

Calcula estadísticas descriptivas de apertura y volatilidad, y genera un boxplot general de volatilidad.

06_inferencia.R

Implementa el análisis inferencial:

división de países en alta vs baja apertura (según mediana)

tabla comparativa

test t de diferencia de medias

regresión: volatilidad ~ apertura

07_graficos.R

Genera los gráficos finales del estudio:

relación apertura–volatilidad

volatilidad por grupos

top 20 países más volátiles

6. Gráficos incluidos en el análisis
hist_gdp_growth.png

Distribución del crecimiento anual del PBI. Permite observar si existen colas largas o valores extremos que influyen en la volatilidad.

hist_openness_avg.png

Distribución de la apertura comercial promedio por país. Confirma la heterogeneidad necesaria para testear la hipótesis.

boxplot_volatilidad.png

Dispersión de la volatilidad del crecimiento. Permite identificar países altamente inestables.

grafico_apertura_vs_volatilidad.png

Relación entre apertura comercial promedio y volatilidad del crecimiento. Es el gráfico central del estudio.

grafico_boxplot_grupos_apertura.png

Comparación de la volatilidad entre países de alta y baja apertura.

grafico_top20_volatilidad.png

Ranking de los 20 países más volátiles junto con su nivel de apertura.

7. Interpretación general de los resultados

El análisis permite evaluar si los países con mayor integración comercial presentan menores oscilaciones en su crecimiento económico.
La combinación de descriptivas, comparación de grupos, test t y regresión simple ofrece evidencia empírica para discutir la validez de la hipótesis.

8. Autores

Faustina Faílo

Federico Romero

Julia Epstein
