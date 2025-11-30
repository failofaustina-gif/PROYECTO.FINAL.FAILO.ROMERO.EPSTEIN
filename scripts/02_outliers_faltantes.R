library(dplyr)
library(here)

base <- read.csv(here("datos","clean","base_clean.csv"))

# Detectar NA
na_summary <- base %>%
  summarise(across(everything(), ~sum(is.na(.)))) 

write.csv(na_summary, here("output","tables","na_summary.csv"), row.names = FALSE)

# No eliminamos nada todavía — solo documentamos
write.csv(base, here("datos","clean","base_clean2.csv"), row.names = FALSE)
