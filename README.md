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


Cada script toma como entrada el resultado del anterior.

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

Importa datos crudos, estandariza nombres y genera base_clean.csv.

02_outliers_faltantes.R

Detecta valores faltantes y outliers. Produce reportes y base_clean2.csv.

03_procesamiento.R

Calcula indicadores:

apertura comercial (trade_total, openness_avg)

volatilidad (vol_growth)

Guarda base_processed.csv y vol_country.csv.

04_eda.R

EDA básico: histogramas, primeras observaciones, dimensiones.

05_descriptivas.R

Estadísticas descriptivas de apertura y volatilidad.

06_inferencia.R

Clasificación de países por apertura

Test t

Regresión lineal simple
Guarda tablas en output/tables/.

07_graficos.R

Genera los gráficos finales:
relación apertura–volatilidad, boxplot por grupos y top20 de países volátiles.

6. Gráficos del estudio

grafico_apertura_vs_volatilidad.png
Relación entre apertura comercial y volatilidad del crecimiento. Evalúa la hipótesis.

grafico_boxplot_grupos_apertura.png
Compara la volatilidad entre países muy abiertos y poco abiertos.

grafico_top20_volatilidad.png
Ranking de países más volátiles con su nivel de apertura.

(Exploratorios)
hist_gdp_growth.png, hist_openness_avg.png, boxplot_volatilidad.png.

7. Principales resultados

La relación entre apertura comercial y volatilidad es leve pero negativa.

Los países con mayor apertura tienden a presentar menor volatilidad.

El test t detecta diferencias entre grupos, aunque moderadas.

La regresión lineal respalda la hipótesis, pero con un efecto pequeño.

8. Conclusión

La evidencia empírica apoya parcialmente la hipótesis:
los países con mayor apertura comercial muestran, en promedio, menor volatilidad del crecimiento.

Esto sugiere que la integración comercial podría actuar como un mecanismo estabilizador, al diversificar mercados y amortiguar shocks internos.

