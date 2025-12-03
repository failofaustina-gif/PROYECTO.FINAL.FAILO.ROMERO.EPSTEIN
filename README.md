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

## 1. Objetivo del estudio
El proyecto analiza si la estructura comercial de un país y su nivel de apertura económica se relacionan con la volatilidad del crecimiento del PBI.

**Hipótesis de trabajo:**  
Los países con mayor apertura comercial presentan mayor volatilidad en su crecimiento económico.

Esta hipótesis se evalúa comparando:  
- la apertura comercial promedio (% del PBI), y  
- la volatilidad del crecimiento (desvío estándar del crecimiento anual).

---

## 2. Datos utilizados
Fuente: **World Development Indicators – Banco Mundial**  
Series anuales utilizadas:
- Exportaciones (% del PBI)
- Importaciones (% del PBI)
- Apertura comercial total (% del PBI)
- Crecimiento del PBI real (% anual)

Los archivos originales están en:  
`datos/raw/`

---

## 3. Estructura del proyecto

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

---

## 4. Cómo reproducir el análisis

Abrir el archivo **PROYECTO.FINAL.Rproj** en RStudio.

Ejecutar los scripts en este orden:

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

Esto genera automáticamente:
- datos limpios y procesados (en `datos/`),
- tablas de análisis (en `output/tables/`),
- gráficos finales (en `output/figures/`).

---

## 5. Descripción de los scripts

### **01_import_limpieza.R**
Importa las bases crudas, estandariza nombres y genera `base_clean.csv`.

### **02_outliers_faltantes.R**
Detecta NA y outliers (regla IQR).  
Guarda reportes en `output/tables/`.

### **03_procesamiento.R**
Construye los indicadores:
- apertura comercial,
- volatilidad del crecimiento por país.  
Genera `base_processed.csv` y `vol_country.csv`.

### **04_eda.R**
Análisis exploratorio: histogramas de crecimiento y apertura.

### **05_descriptivas.R**
Estadísticas descriptivas clave y boxplot general de volatilidad.

### **06_inferencia.R**
- Clasificación en países de alta vs baja apertura  
- Test t de medias  
- Regresión lineal simple  
Resultados guardados en `output/tables/`.

### **07_graficos.R**
Gráficos finales:
- apertura vs volatilidad  
- comparación por grupos  
- ranking top 20 países más volátiles

### **08_evaluacion_outliers.R**
Compara la regresión y el test t con y sin países outliers en la volatilidad del PBI.
Como los coeficientes y p-valores cambian poco, se concluye que los outliers no alteran las conclusiones y se justifica trabajar con la base completa.

---

## 6. Principales resultados

- La relación estadística entre apertura y volatilidad es **débil**.  
- El test t no muestra diferencias significativas entre países muy abiertos y poco abiertos.  
- La regresión lineal confirma que la apertura explica muy poco de la volatilidad.  
- Los países más volátiles suelen ser economías dependientes de commodities o afectadas por shocks políticos.

---

## 7. Conclusión

La evidencia empírica **no confirma la hipótesis** de que mayor apertura comercial implique mayor volatilidad.  
La estabilidad macroeconómica parece depender más de la **diversificación productiva** y del tipo de shocks externos a los que cada país está expuesto.

---

## 8. Autores

- Faustina Faílo  
- Federico Romero  
- Julia Epstein  
