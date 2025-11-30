# Proyecto Final – Apertura Comercial y Volatilidad Macroeconómica

## 1. Objetivo del estudio

Este proyecto analiza si la estructura de inserción internacional de un país, medida a través de su **apertura comercial**, se relaciona con la **volatilidad del crecimiento económico**.

### Hipótesis de trabajo

Los países con **mayor apertura comercial** (comercio total como porcentaje del PBI) presentan **menor volatilidad** en su crecimiento económico.

La hipótesis se evalúa comparando, para cada país:

- su **apertura promedio**, medida como exportaciones + importaciones (% del PBI), y  
- la **volatilidad del crecimiento**, medida como el desvío estándar del crecimiento anual del PBI real.

---

## 2. Datos utilizados

Todos los datos provienen de **World Development Indicators (Banco Mundial)**:

- Exportaciones de bienes y servicios (% del PBI).  
- Importaciones de bienes y servicios (% del PBI).  
- Crecimiento del PBI real (% anual).

Los archivos originales se encuentran en la carpeta:

`datos/raw/`

---

## 3. Estructura del proyecto

El repositorio sigue una estructura reproducible:

```txt
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
