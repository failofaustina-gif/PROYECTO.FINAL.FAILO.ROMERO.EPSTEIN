Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica
1. Objetivo del estudio

Este proyecto analiza si la estructura del comercio exterior de un país —en particular su nivel de dependencia externa— se relaciona con la volatilidad del crecimiento económico.

Hipótesis de trabajo

Los países con mayor dependencia externa (proporción de importaciones en el comercio total) presentan una mayor volatilidad en su crecimiento económico.

La hipótesis se evalúa comparando:

la dependencia externa promedio de cada país, y

la volatilidad del crecimiento, medida como el desvío estándar del crecimiento anual del PBI real.

2. Datos utilizados

Los datos provienen de World Development Indicators (Banco Mundial):

Exportaciones de bienes y servicios (% del PBI)

Importaciones de bienes y servicios (% del PBI)

Crecimiento del PBI real (% anual)

Los archivos originales se encuentran en datos/raw/.

3. Estructura del proyecto
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

Para ejecutar el proyecto:

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

tablas del análisis,

y los gráficos finales en las carpetas correspondientes.

5. Descripción de los scripts
01_import_limpieza.R

Importa y unifica las bases crudas. Genera base_clean.csv.

02_outliers_faltantes.R

Analiza NA y outliers, documenta decisiones y genera base_clean2.csv, además de reportes en output/tables/.

03_procesamiento.R

Crea indicadores principales:

comercio total,

dependencia externa (Import Reliance),

volatilidad del crecimiento (desvío estándar).

Genera base_processed.csv y vol_country.csv.

04_eda.R

Análisis exploratorio:

dimensiones,

primeras observaciones,

histograma del crecimiento del PBI,

histograma de la dependencia externa promedio.

05_descriptivas.R

Estadísticas descriptivas a nivel país y boxplot general de volatilidad.

06_inferencia.R

Produce la tabla comparativa entre países de alta y baja dependencia, el test t de diferencia de medias y una regresión simple. Exporta resultados a output/tables/.

07_graficos.R

Genera los gráficos principales del trabajo:

dependencia externa vs volatilidad,

comparación entre grupos,

top 20 países más volátiles.
Todos guardados en output/figures/.

6. Gráficos del estudio
grafico_dependencia_vs_volatilidad.png

Muestra la relación entre la dependencia externa promedio y la volatilidad del crecimiento.
Sirve para evaluar directamente la hipótesis.

grafico_boxplot_grupos.png

Compara la volatilidad del crecimiento entre países de alta y baja dependencia externa.
Permite visualizar diferencias entre grupos.

grafico_top20_volatilidad.png

Muestra los 20 países más volátiles y su nivel de dependencia externa.
Sirve para interpretar el perfil de las economías más inestables.

(Exploración opcional)

hist_gdp_growth.png: distribución del crecimiento del PBI.

hist_import_reliance_avg.png: distribución de dependencia externa.

boxplot_volatilidad.png: dispersión general de la volatilidad.

7. Resultados principales

La relación lineal entre dependencia externa y volatilidad es débil.

Al separar países en grupos, los países con baja dependencia externa muestran una volatilidad ligeramente mayor y más dispersa.

El test t de diferencia de medias refleja diferencias entre grupos, aunque no determinantes.

La regresión simple muestra un coeficiente negativo (mayor dependencia → menor volatilidad), pero de baja intensidad.

8. Conclusión

Los resultados no confirman la hipótesis inicial.
La volatilidad macroeconómica no aumenta sistemáticamente con la dependencia externa. En muchos casos, los países con baja dependencia —a menudo exportadores primarios— presentan mayor inestabilidad debido a shocks externos en precios y producción.

La estabilidad económica parece depender más de la diversificación productiva que del nivel de dependencia externa.

9. Autores

Faustina Faílo

Bautista Romero

Gian Epstein
