# =======================================================================
# 05_descriptivas.R
# Estadísticas descriptivas + boxplots
# =======================================================================

library(dplyr)
library(readr)
library(here)
library(ggplot2)

base <- read_csv(here("datos","processed","base_processed.csv"))

desc <- base %>%
  summarise(across(where(is.numeric),
                   list(media=mean, mediana=median, sd=sd),
                   na.rm=TRUE))

write_csv(desc, here("output","tables","descriptivas.csv"))

# boxplots
vars <- c("exports_pct_gdp","imports_pct_gdp","trade_pct_gdp","gdp_growth","ied_pct_gdp","gl_index")

for(v in vars){
  p <- ggplot(base, aes_string(y=v)) +
    geom_boxplot(fill="tomato", alpha=.7) +
    labs(title=paste("Boxplot de", v), y=v)

  ggsave(here("output","figures", paste0("boxplot_",v,".png")),
         p, width=5, height=4)
}

cat("Descriptivas guardadas.\n")
