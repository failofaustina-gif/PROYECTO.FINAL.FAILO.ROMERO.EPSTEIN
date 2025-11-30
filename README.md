Proyecto Final – Análisis del Comercio Internacional y Componente Intraindustrial (GL)

Este proyecto analiza cómo varían los patrones comerciales entre países según el grado de comercio intraindustrial, medido por el índice de Grubel-Lloyd (GL).
El trabajo se organiza siguiendo las reglas de reproducibilidad y estructura de proyectos enseñadas en la materia.

Todos los datos utilizados provienen de World Development Indicators (WDI) – Banco Mundial.

🧩 1. Hipótesis del estudio

La hipótesis central del proyecto es:

Los países con mayor comercio intraindustrial (índice de Grubel-Lloyd alto) tienden a presentar niveles más elevados de apertura comercial y estructuras comerciales más equilibradas que aquellos con comercio predominantemente interindustrial.

Esta hipótesis es falsable y puede evaluarse comparando grupos de países según su GL promedio.

📂 2. Estructura del proyecto

El repositorio sigue estrictamente la estructura solicitada:

PROYECTO.FINAL/
├── datos/
│   ├── raw/        # Datos crudos originales descargados del WDI
│   ├── clean/      # Datos limpios tras tratamiento mínimo
│   └── processed/  # Datos procesados con variables derivadas (GL)
│
├── output/
│   ├── tables/     # Tablas finales: NA, descriptivas, outliers, test, regresiones
│   └── figures/    # Gráficos exploratorios y editorializados
│
├── scripts/        # Scripts numerados del pipeline reproducible
└── README.md       # Este archivo

🔄 3. Reproducibilidad del análisis

El proyecto está organizado como pipeline secuencial:
cada script genera productos que luego son usados por el siguiente.

Para reproducir todo el análisis, simplemente abrir el archivo:

PROYECTO.FINAL.Rproj


y ejecutar en R:

source("scripts/01_import_limpieza.R")
source("scripts/02_outliers_faltantes.R")
source("scripts/03_procesamiento.R")
source("scripts/04_eda.R")
source("scripts/05_descriptivas.R")
source("scripts/06_inferencia.R")
source("scripts/07_graficos.R")


Esto generará:

datos limpios → datos/clean/

datos procesados → datos/processed/

tablas → output/tables/

gráficos → output/figures/

📜 4. Descripción de los scripts
01_import_limpieza.R

Importa todas las bases crudas del Banco Mundial, homogeneiza nombres, unifica en una base panel y guarda base_clean.csv.

02_outliers_faltantes.R

Detecta valores faltantes y outliers, documenta decisiones y genera una versión refinada base_clean2.csv.

03_procesamiento.R

Crea variables derivadas, incluyendo el índice de Grubel-Lloyd (GL), y guarda base_processed.csv.

04_eda.R

Realiza análisis exploratorio: dimensiones, primeras observaciones, NA y histogramas descriptivos.

05_descriptivas.R

Calcula estadísticas descriptivas y genera boxplots básicos (crecimiento, apertura y GL).

06_inferencia.R

Divide países según GL promedio (GL alto vs GL bajo), genera la tabla comparativa, realiza test de diferencias de medias y corre una regresión exploratoria del crecimiento económico.

07_graficos.R

Produce gráficos editorializados para storytelling:

boxplot de apertura según grupo GL

dispersión GL vs apertura promedio

📊 5. Resultados principales

Los análisis muestran que:

Los países con GL alto tienden a tener mayor apertura comercial.

También presentan menor desequilibrio entre exportaciones e importaciones.

El test de diferencias de medias confirma que esta diferencia es estadísticamente significativa.

La hipótesis queda respaldada por los datos.

No se observa una relación fuerte entre GL y crecimiento económico, lo cual coincide con la literatura: el GL describe estructura comercial, no necesariamente desempeño macroeconómico de corto plazo.

🧠 6. Gráficos más importantes

boxplot_apertura_por_grupo_gl.png: muestra la diferencia de apertura entre países GL alto y GL bajo.

dispersion_gl_vs_apertura.png: muestra cómo aumentos en comercio intraindustrial se asocian a niveles superiores de apertura comercial.

📎 7. Datos utilizados

Todos los datos provienen del Banco Mundial – World Development Indicators:

Exportaciones (% PBI)

Importaciones (% PBI)

Comercio total (% PBI)

Crecimiento del PBI real

Inversión extranjera directa (% PBI)

Los archivos crudos se encuentran en datos/raw/.

✔️ 8. Autores

Faustina Faílo
Bautista Romero
Gian Epstein
