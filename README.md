# Proyecto Final – Comercio Internacional y Comercio Intraindustrial (Índice de Grubel-Lloyd)

Este proyecto analiza cómo se comportan los países según su grado de comercio intraindustrial, medido por el índice de Grubel-Lloyd (GL). El objetivo principal es comparar grupos de países y evaluar si aquellos con un GL más elevado presentan patrones comerciales distintos en términos de apertura y equilibrio entre exportaciones e importaciones.

## 1. Hipótesis del estudio

La hipótesis central propone que los países con un mayor grado de comercio intraindustrial (GL alto) tienden a exhibir:
- mayores niveles de apertura comercial, y  
- una estructura comercial más equilibrada entre exportaciones e importaciones.

El índice de Grubel-Lloyd permite captar cuán simétrico es el comercio de un país: valores altos indican que exporta e importa bienes de categorías similares, mientras que valores bajos reflejan un comercio más especializado o concentrado.

## 2. Estructura general del proyecto

El repositorio respeta la estructura de carpetas de proyectos reproducibles solicitada en la materia:

datos/raw/ # Datos crudos del Banco Mundial
datos/clean/ # Datos limpios tras tratamiento mínimo
datos/processed/ # Datos procesados con variables derivadas, incluido GL

output/tables/ # Tablas finales: NA, outliers, descriptivas, tests, regresiones
output/figures/ # Gráficos exploratorios y editorializados

scripts/ # Scripts numerados 01–07 formando un pipeline secuencial
README.md # Este archivo

Cada script genera una salida que es usada por el siguiente, asegurando un flujo ordenado y reproducible.

## 3. Reproducibilidad del análisis

Para reproducir el proyecto completo, basta con abrir:

PROYECTO.FINAL.Rproj

y ejecutar en orden los siguientes scripts:

y ejecutar en orden los siguientes scripts:

```r
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")
```

Esto genera automáticamente:

- datos limpios y procesados,  
- tablas del análisis,  
- y todos los gráficos necesarios para la presentación.

4. Descripción del pipeline

01_import_limpieza.R
Importa los datos crudos del Banco Mundial, unifica nombres y arma la base principal. Exporta base_clean.csv.

02_outliers_faltantes.R
Detecta NA y valores imposibles. Se corrigen únicamente casos no plausibles (por ejemplo, porcentajes negativos). Genera base_clean2.csv.

03_procesamiento.R
Crea el índice de Grubel-Lloyd y otras variables derivadas. Guarda base_processed.csv.

04_eda.R
Realiza el análisis exploratorio: dimensiones, primeras observaciones, NA y distribuciones básicas mediante histogramas.

05_descriptivas.R
Calcula estadísticas descriptivas de comercio, crecimiento y GL. Produce boxplots básicos para visualizar dispersión.

06_inferencia.R
Agrupa países según GL promedio en “GL alto” y “GL bajo”, construye una tabla comparativa, ejecuta pruebas de diferencia de medias en apertura y desequilibrio comercial, y corre una regresión exploratoria del crecimiento.

07_graficos.R
Genera los gráficos editorializados del trabajo:

un boxplot de apertura comercial para GL alto vs GL bajo,

y una dispersión entre GL promedio y apertura promedio.

Estos gráficos se utilizan directamente en la presentación final.

5. Resultados principales

Los países con GL alto muestran, en promedio, una apertura comercial mayor y un comercio más equilibrado que los países con GL bajo. La prueba de diferencias de medias respalda esta relación de manera estadística. Esto sugiere que el comercio intraindustrial está asociado a una mayor integración con el comercio mundial y a estructuras comerciales menos asimétricas.

La relación entre GL y el crecimiento del PBI no aparece como significativa, lo cual coincide con el enfoque teórico de que el GL describe la estructura del comercio, no necesariamente la performance macroeconómica de corto plazo.

6. Datos utilizados

Todos los datos provienen del World Development Indicators (Banco Mundial) e incluyen:

exportaciones e importaciones como % del PBI,

comercio total como % del PBI,

crecimiento del PBI real,

inversión extranjera directa.

Los datos crudos están disponibles en datos/raw/, acompañados de sus versiones limpias y procesadas utilizadas durante el análisis.

7. Autores

Faustina Faílo
Federico Romero
Julia Epstein
