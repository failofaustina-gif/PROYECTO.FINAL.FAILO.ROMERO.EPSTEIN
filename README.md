# Proyecto Final – Análisis de Apertura Comercial, IED y Crecimiento

Este proyecto analiza la relación entre apertura comercial, inversión extranjera directa y equilibrio comercial con el crecimiento económico utilizando datos del World Development Indicators (WDI).

## Estructura del proyecto

```
proyecto/
├── datos/
│   ├── raw/          # datos crudos
│   ├── clean/        # datos limpios
│   └── processed/    # datos procesados
├── scripts/          # scripts del pipeline
├── output/
│   ├── tables/       # tablas finales
│   └── figures/      # gráficos finales
└── PROYECTO.FINAL.Rproj
```

## Reproducibilidad

1. Abrir `PROYECTO.FINAL.Rproj`
2. Ejecutar secuencialmente:

```
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")
```

Cada script toma la salida del anterior y genera:

- datos limpios  
- datos procesados  
- tablas  
- gráficos editorializados  

## Resultados principales

- Se estima el índice de Grubel-Lloyd (equilibrio comercial)
- Se generan descriptivas completas
- Se evalúan NA y outliers
- Se corre un test de hipótesis
- Se estima un modelo de regresión vinculado a las hipótesis
- Se producen gráficos informativos para la presentación

