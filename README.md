# Proyecto Final – Comercio y Volatilidad Macroeconómica

### Hipótesis del estudio
**Los países con mayor dependencia externa (mayor proporción de importaciones en el comercio total) presentan una mayor volatilidad en su crecimiento económico.**

---

## Cómo reproducir el análisis

1. Clonar o descargar este repositorio.  
2. Abrir el proyecto `PROYECTO.FINAL.Rproj` desde RStudio.  
3. Ejecutar, en orden, los siguientes scripts:

```r
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")
```

---

## ¿Qué genera el proyecto automáticamente?

- Datos limpios y procesados en `datos/clean/` y `datos/processed/`  
- Tablas finales en `output/tables/`  
- Gráficos editoriales en `output/figures/`  

Todo el análisis es completamente reproducible.

---

## Estructura del proyecto
(ver carpetas en el repositorio)
