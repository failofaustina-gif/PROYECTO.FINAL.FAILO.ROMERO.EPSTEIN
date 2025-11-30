Proyecto Final – Apertura Comercial y Volatilidad Macroeconómica
1. Objetivo del estudio

Este proyecto analiza si la estructura de inserción internacional de un país, medida a través de su apertura comercial, se relaciona con la volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor apertura comercial (exportaciones + importaciones como % del PBI) presentan menor volatilidad en su crecimiento económico.

Para cada país se estima:

Apertura promedio, y

Volatilidad del crecimiento, medida como el desvío estándar del crecimiento anual del PBI real.

2. Datos utilizados

Todos los datos provienen de World Development Indicators (Banco Mundial):

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


Cada script toma como entrada la salida del anterior y genera resultados 100% reproducibles.

🔁 4. Cómo reproducir el análisis

Para ejecutar el pipeline completo:

1. Descargar o clonar el repositorio

Usando Git:

git clone https://github.com/failofaustina-gif/PROYECTO.FINAL.FAILO.ROMERO.EPSTEIN.git


O descargando el ZIP desde GitHub.

2. Abrir el proyecto en RStudio

Abrir el archivo:

PROYECTO.FINAL.Rproj


Esto garantiza que los paths relativos funcionen correctamente mediante {here}.

3. Instalar los paquetes necesarios

Ejecutar una sola vez en la consola:

install.packages(c("dplyr", "readr", "ggplot2", "here"))

4. Ejecutar los scripts en orden
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Esto generará automáticamente:

datos limpios en datos/clean/

datos procesados en datos/processed/

tablas en output/tables/

gráficos en output/figures/

No es necesario modificar rutas ni mover archivos.
Todo el análisis es totalmente reproducible.

5. Descripción de los scripts
01_import_limpieza.R

Importa las bases crudas de exportaciones, importaciones y crecimiento del PBI, unifica nomenclaturas y construye base_clean.csv.

02_outliers_faltantes.R

Analiza datos faltantes y outliers mediante la regla IQR. Documenta la cantidad de NA y genera base_clean2.csv.

03_procesamiento.R

Crea los indicadores principales:

trade_total: apertura comercial (% del PBI)

vol_growth: volatilidad del crecimiento económico

openness_avg: apertura comercial promedio

Genera base_processed.csv y vol_country.csv.

04_eda.R

Exploración básica de datos: dimensiones, primeras observaciones, distribución del crecimiento y distribución de apertura promedio.

05_descriptivas.R

Cálculo de estadísticas descriptivas y boxplot de volatilidad para evaluar dispersión y casos extremos.

06_inferencia.R

Análisis inferencial:

Separación de países según apertura (alta vs baja, con mediana)

Tabla comparativa de volatilidad

Test t de diferencia de medias

Regresión lineal simple: volatilidad ~ apertura

Resultados guardados en output/tables/.

07_graficos.R

Genera los gráficos editoriales del informe:

grafico_apertura_vs_volatilidad.png

grafico_boxplot_grupos_apertura.png

grafico_top20_volatilidad.png

6. Gráficos del estudio
hist_gdp_growth.png

Distribución del crecimiento del PBI. Permite evaluar si hay valores extremos que influyen en la volatilidad.

hist_openness_avg.png

Distribución de apertura comercial promedio. Verifica la heterogeneidad en la muestra.

boxplot_volatilidad.png

Muestra la dispersión general de la volatilidad y casos extremos.

grafico_apertura_vs_volatilidad.png

Relación entre apertura comercial promedio y volatilidad del crecimiento. Es el gráfico clave para evaluar la hipótesis.

grafico_boxplot_grupos_apertura.png

Compara la volatilidad entre países con alta y baja apertura.

grafico_top20_volatilidad.png

Lista los 20 países más volátiles junto con su grado de apertura.

7. Comentario sobre los resultados

El análisis permite evaluar si economías más abiertas muestran menor inestabilidad macroeconómica.
La comparación entre grupos, el test t y la regresión ofrecen un marco cuantitativo para interpretar la relación apertura–volatilidad.

8. Autores

Faustina Faílo

Federico Romero

Julia Epstein
