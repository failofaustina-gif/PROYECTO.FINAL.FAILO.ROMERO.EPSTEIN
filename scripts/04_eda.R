# =======================================================================
# 04_eda.R
# EDA: estructura, NA, primeras observaciones, gráficos exploratorios
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

# dim
write_csv(
  as.data.frame(dim(base)),
  here("output","tables","dimensiones_base.csv")
)

# head
write_csv(
  head(base,20),
  here("output","tables","head_base.csv")
)

# NA patterns
na_df <- base %>% summarise(across(everything(), ~sum(is.na(.))))
write_csv(na_df, here("output","tables","na_processed_summary.csv"))

# Histogramas exploratorios
vars <- c("exports_pct_gdp","imports_pct_gdp","trade_pct_gdp","gdp_growth","ied_pct_gdp","gl_index")

for(v in vars){
  p <- ggplot(base, aes_string(x=v)) +
    geom_histogram(bins=40, fill="steelblue", alpha=.7) +
    labs(title=paste("Histograma de", v), x=v)

  ggsave(here("output","figures", paste0("hist_",v,".png")),
         p, width=6, height=4)
}

cat("EDA completado. Tablas y gráficos guardados en output/\n")
