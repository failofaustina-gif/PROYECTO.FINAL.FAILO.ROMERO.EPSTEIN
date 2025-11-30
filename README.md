Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

El proyecto analiza si el grado de apertura comercial de un país —medido como la suma de exportaciones e importaciones en relación al PBI— se asocia con una mayor o menor volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor apertura comercial presentan menor volatilidad en su crecimiento económico.

La hipótesis se evalúa comparando:

la apertura comercial promedio por país, y

la volatilidad del crecimiento, medida como el desvío estándar del crecimiento anual del PBI real.

2. Datos utilizados

Todos los datos provienen de World Development Indicators (Banco Mundial):

Exportaciones de bienes y servicios (% PBI)

Importaciones de bienes y servicios (% PBI)

Crecimiento del PBI real (% anual)

Los archivos originales están en:

datos/raw/

3. Estructura del proyecto

El repositorio sigue una estructura reproducible estándar:

datos/
  raw/          # Datos originales
  clean/        # Datos limpios
  processed/    # Datos procesados (indicadores)

output/
  tables/       # Tablas de resultados (tests, descriptivas, comparativas)
  figures/      # Gráficos exploratorios y editoriales

scripts/        # Scripts numerados del pipeline
README.md
PROYECTO.FINAL.Rproj


Cada script toma como entrada el resultado del script anterior, garantizando autocontención y reproducibilidad.

4. Cómo reproducir el análisis

Descargar o clonar el repositorio.

Abrir PROYECTO.FINAL.Rproj en RStudio.

Ejecutar, en este orden:

source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Esto genera automáticamente:

datos limpios y procesados,

tablas de análisis,

gráficos exploratorios y editoriales finales.

5. Descripción de los scripts
01_import_limpieza.R

Importa las bases crudas, estandariza nombres de variables, unifica las series y genera base_clean.csv.

02_outliers_faltantes.R

Detecta NA y posibles outliers mediante la regla IQR. Documenta decisiones.
Produce base_clean2.csv y reportes en output/tables/.

03_procesamiento.R

Crea los indicadores claves:

trade_total (apertura comercial)

openness_avg (apertura promedio del país)

vol_growth (volatilidad del crecimiento)

Genera base_processed.csv y vol_country.csv.

04_eda.R

Análisis exploratorio:

dimensiones de la base

primeras observaciones

histograma del crecimiento del PBI

histograma de apertura comercial promedio

05_descriptivas.R

Estadísticas descriptivas de apertura y volatilidad.
Incluye un boxplot general de volatilidad para evaluar dispersión y extremos.

06_inferencia.R

Análisis inferencial:

clasificación de países según apertura (alta vs baja)

tabla comparativa de medias y dispersión

test t de diferencia de medias

regresión lineal simple (volatilidad ~ apertura)

Resultados guardados en output/tables/.

07_graficos.R

Genera los gráficos editoriales finales:

Relación apertura–volatilidad

Comparación entre grupos

Ranking de los 20 países más volátiles

Guardados en output/figures/.

6. Gráficos del estudio
grafico_apertura_vs_volatilidad.png

Muestra la relación entre la apertura comercial promedio y la volatilidad del crecimiento.
Sirve para evaluar directamente la hipótesis.

grafico_boxplot_grupos_apertura.png

Compara la volatilidad entre países altamente abiertos y países poco abiertos.
Visualiza si un grupo es más estable que el otro.

grafico_top20_volatilidad.png

Lista los 20 países más volátiles e identifica su nivel de apertura.
Ayuda a interpretar el perfil de las economías más inestables.

(EDA opcional)

hist_gdp_growth.png: distribución del crecimiento del PBI.

hist_openness_avg.png: distribución de apertura comercial.

boxplot_volatilidad.png: dispersión general de volatilidad.

7. Principales resultados

La relación lineal entre apertura comercial y volatilidad del crecimiento es leve pero negativa, coherente con la hipótesis.

Al separar los países por nivel de apertura, se observa que el grupo de alta apertura tiende a mostrar menor volatilidad.

El test t detecta diferencias entre grupos, aunque moderadas.

La regresión lineal muestra un coeficiente negativo (mayor apertura → menor volatilidad), apoyando la hipótesis, aunque con una intensidad reducida.

8. Conclusión

La evidencia empírica apoya parcialmente la hipótesis planteada.
Los datos muestran que los países más abiertos al comercio exhiben, en promedio, menor volatilidad del crecimiento, aunque la relación no es extremadamente fuerte.

En conjunto, los resultados sugieren que la integración comercial contribuye a estabilizar las fluctuaciones del PBI, posiblemente gracias a:

mayor diversificación productiva,

mejor acceso a mercados externos,

mayor capacidad de absorber shocks sectoriales.

9. Autores

Faustina Faílo

Federico Romero

Julia Epstein
