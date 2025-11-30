Proyecto Final – Comercio Internacional
Objetivo

El proyecto estudia la relación entre apertura comercial y volatilidad del crecimiento económico, utilizando datos de World Development Indicators.

Estructura del repositorio
datos/
  raw/          # Datos originales
  clean/        # Datos limpios
  processed/    # Datos procesados

output/
  tables/       # Tablas generadas
  figures/      # Gráficos finales

scripts/        # Scripts numerados del pipeline
PROYECTO.FINAL.Rproj
README.md


Los scripts están numerados para ejecutarse en orden y garantizar reproducibilidad.

Cómo reproducir el análisis

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

tablas (output/tables/),

gráficos finales (output/figures/).

Descripción breve de cada script

01_import_limpieza.R – Importa datos crudos y genera base limpia.
02_outliers_faltantes.R – Detecta NA/outliers y documenta decisiones.
03_procesamiento.R – Calcula apertura comercial y volatilidad.
04_eda.R – Exploración inicial de datos.
05_descriptivas.R – Estadísticas descriptivas.
06_inferencia.R – Comparaciones entre grupos y regresión.
07_graficos.R – Gráficos editoriales finales.
