
### Freedom of Expression and Alternative Sources of Information index according V-Dem

# Question: To what extent does government respect press and media freedom, the freedom of ordinary people to 
# discuss political matters at home and in the public sphere, as well as the freedom of academic and 
# cultural expression?
# Clarification: This index includes all variables in the two indices v2x_freexp and v2xme_altinf.
# Scale: Interval, from low to high (0-1).
# Source(s): v2mecenefm v2meharjrn v2meslfcen v2xcl_disc v2clacfree v2mebias v2mecrit v2merange
# Data release: 4-13.
# Aggregation: The index is formed by taking the point estimates from a Bayesian factor analysis model of the 
# indicators for media censorship effort (v2mecenefm), harassment of journalists (v2meharjrn), media bias (v2mebias), 
# media self-censorship (v2meslfcen), print/broadcast
# media critical (v2mecrit), and print/broadcast media perspectives (v2merange), 
# freedom of discussion for men/women (v2cldiscm, v2cldiscw), and freedom of academic and cultural 
# expression (v2clacfree).



# sessionInfo()
# R version 4.2.2 (2022-10-31)
# Platform: aarch64-apple-darwin20 (64-bit)
# Running under: macOS Ventura 13.4.1
# 
# Matrix products: default
# LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib
# 
# locale:
#   [1] ru_RU.UTF-8/ru_RU.UTF-8/ru_RU.UTF-8/C/ru_RU.UTF-8/ru_RU.UTF-8
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] ggthemes_4.2.4  lubridate_1.9.2 forcats_1.0.0   stringr_1.5.0   dplyr_1.1.2     purrr_1.0.1     readr_2.1.4    
# [8] tidyr_1.3.0     tibble_3.2.1    ggplot2_3.4.2   tidyverse_2.0.0 here_1.0.1     
# 
# loaded via a namespace (and not attached):
#   [1] pillar_1.9.0     compiler_4.2.2   tools_4.2.2      lifecycle_1.0.3  gtable_0.3.3     timechange_0.2.0
# [7] pkgconfig_2.0.3  rlang_1.1.1      cli_3.6.1        rstudioapi_0.14  withr_2.5.0      generics_0.1.3  
# [13] vctrs_0.6.3      hms_1.1.3        rprojroot_2.0.3  grid_4.2.2       tidyselect_1.2.0 glue_1.6.2      
# [19] R6_2.5.1         fansi_1.0.4      farver_2.1.1     tzdb_0.4.0       magrittr_2.0.3   scales_1.2.1    
# [25] colorspace_2.1-0 labeling_0.4.2   utf8_1.2.3       stringi_1.7.12   munsell_0.5.0    crayon_1.5.2 


library(here)
library(tidyverse)
library(ggthemes)

load(here("V-Dem-CY-Core_csv_v13", "Shortened_version_freedom_expression.RData"))

# Data for Russia
Russia_freedom_expression <- as.data.frame(shortened_version_freedom_expression[shortened_version_freedom_expression$country_id == 11, c("year", "v2x_freexp_altinf")])
class(Russia_freedom_expression$year)
Russia_freedom_expression <- Russia_freedom_expression[Russia_freedom_expression$year>1991, ] # Thus, 
# we have data from 1998 till 2018



###### Ukraine
Ukraine_freedom_expression <- as.data.frame(shortened_version_freedom_expression[shortened_version_freedom_expression$country_id == 100, c("year", "v2x_freexp_altinf")])
Ukraine_freedom_expression <- Ukraine_freedom_expression[Ukraine_freedom_expression$year>1991, ]


###### Estonia
Estonia_freedom_expression <- as.data.frame(shortened_version_freedom_expression[shortened_version_freedom_expression$country_id == 161, c("year", "v2x_freexp_altinf")])
Estonia_freedom_expression <- Estonia_freedom_expression[Estonia_freedom_expression$year>1991, ]

############# Visualization

# Freedom of expression for three countries
Russia_freedom_expression$ID <- "Russia"
Ukraine_freedom_expression$ID <- "Ukraine"
Estonia_freedom_expression$ID <- "Estonia"
pooling_int_expressions <- rbind(Russia_freedom_expression, Ukraine_freedom_expression)
pooling_int_expressions <- rbind(pooling_int_expressions, Estonia_freedom_expression)
str(pooling_int_expressions)



ggplot(pooling_int_expressions, aes(year,v2x_freexp_altinf))+ 
  geom_line(aes(colour = ID), size = 1) + 
  scale_y_continuous(name = "Freedom of Expression and Alternative Sources of Information index")+ 
  scale_x_discrete(name ="Years", limits = c(1992:2022)) +
  theme(axis.text.x = element_text(angle = 40), legend.position="bottom")+
  scale_color_discrete(name="Countries")+
  guides(colour = guide_legend(override.aes = list(size=4))) + 
  theme_classic()
#  ggtitle("Internet censorship effors in Russia, Ukraine, and Estonia after the USSR collapse", subtitle = "Varieties of Democracy project data")

ggsave(here("Figures", "Figure Freedom of Expression.jpeg"), width = 12, height = 8, dpi = 300)

