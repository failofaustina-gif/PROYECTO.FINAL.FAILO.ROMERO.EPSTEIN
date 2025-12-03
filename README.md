# Proyecto Final – Comercio Internacional y Volatilidad Macroeconómica


## Indicaciones para correr el código:
Es importante que se descomprima la carpeta que descarga todos los archivos. Luego abrir el proyecto de R que se llama "PROYECTO.FINAL" y ejecutar las lineas en el archivo de r. Se guardaran en la carpeta outputs todos los gráficos y tablas:  

```r
source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")
source("scripts/08_evaluacion_outliers.R")
```

##  Objetivo del estudio
El proyecto analiza si la estructura comercial de un país y su nivel de apertura económica se relacionan con la volatilidad del crecimiento del PBI.

**Hipótesis de trabajo:**  
Los países con mayor apertura comercial presentan mayor volatilidad en su crecimiento económico.

Esta hipótesis se evalúa comparando:  
- la apertura comercial promedio (% del PBI), y  
- la volatilidad del crecimiento (desvío estándar del crecimiento anual).

---

##  Datos utilizados
Fuente: **World Development Indicators – Banco Mundial**  
Series anuales utilizadas:
- Exportaciones (% del PBI)
- Importaciones (% del PBI)
- Apertura comercial total (% del PBI)
- Crecimiento del PBI real (% anual)

Los archivos originales están en:  
`datos/raw/`

---

## Estructura del proyecto

```
proyecto/
 ├── datos/
 │    ├── raw/          # Datos originales
 │    ├── clean/        # Datos limpios
 │    └── processed/    # Indicadores procesados
 │
 ├── output/
 │    ├── tables/       # Tablas finales
 │    └── figures/      # Gráficos finales
 │
 ├── scripts/           # Scripts numerados
 ├── PROYECTO.FINAL.Rproj
 └── README.md
```

Cada script usa como entrada el resultado del anterior.  
El pipeline es totalmente reproducible.

##  Autores

- Faustina Faílo  
- Federico Romero  
- Julia Epstein  
