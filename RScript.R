
#### Internet censorship efforts according V-Dem
#### Question: Does the government attempt to censor information (text, audio, or visuals) on the Internet?
# Clarification: Censorship attempts include Internet filtering (blocking access to certain websites or browsers), 
# denial-of-service attacks, and partial or total Internet shutdowns. We are not concerned with censorship of 
# topics such as child pornography, highly classified information such as military or intelligence secrets, 
# statements offensive to a particular religion, or defamatory speech unless this sort of censorship is used
# as a pretext for censoring political information or opinions. We are also not concerned with the extent of 
# internet access, unless there is absolutely no access at all (in which case the coding should be 0).
# Responses:
# 0 (1): The government successfully blocks Internet access except to sites that are pro-government or devoid of political content.
# 1 (2): The government attempts to block Internet access except to sites that are pro-government or devoid of political content, but many users are able to circumvent such controls.
# 2 (3): The government allows Internet access, including to some sites that are critical of the government, but blocks selected sites that deal with especially politically sensitive issues.
# 3 (4): The government allows Internet access that is unrestricted, with the exceptions mentioned above.

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
# loaded via a namespace (and not attached):
#   [1] compiler_4.2.2  tools_4.2.2     rstudioapi_0.14

library(here)
library(tidyverse)
library(ggthemes)

load(here("V-Dem-CY-Core_csv_v13", "Shortened_Version.RData"))

# Data for Russia
Russia_internet_censorship <- as.data.frame(v_dem[v_dem$country_id == 11, c("year", "v2mecenefi")])
Russia_internet_censorship <- Russia_internet_censorship[!(is.na(Russia_internet_censorship$v2mecenefi)), ] # Thus, 
# we have data from 1998 till 2018



###### Ukraine
Ukraine_internet_censorship <- as.data.frame(v_dem[v_dem$country_id == 100, c("year", "v2mecenefi")])
Ukraine_internet_censorship <- Ukraine_internet_censorship[!(is.na(Ukraine_internet_censorship$v2mecenefi)), ]


###### Estonia
Estonia_internet_censorship <- as.data.frame(v_dem[v_dem$country_id == 161, c("year", "v2mecenefi")])
Estonia_internet_censorship <- Estonia_internet_censorship[!(is.na(Estonia_internet_censorship$v2mecenefi)), ]

############# Visualization

# Internet censorship for three countries
Russia_internet_censorship$ID <- "Russia"
Ukraine_internet_censorship$ID <- "Ukraine"
Estonia_internet_censorship$ID <- "Estonia"
pooling_int <- rbind(Russia_internet_censorship, Ukraine_internet_censorship)
pooling_int <- rbind(pooling_int, Estonia_internet_censorship)
str(pooling_int)



ggplot(pooling_int, aes(year,v2mecenefi))+ 
  geom_line(aes(colour = ID), size = 1) + 
  scale_y_continuous(name = "Internet censorship efforts")+ 
  scale_x_discrete(name ="Years", limits = c(1993:2022)) +
  theme(axis.text.x = element_text(angle = 40), legend.position="bottom")+
  scale_color_discrete(name="Countries")+
  guides(colour = guide_legend(override.aes = list(size=4))) + 
  theme_classic()
#  ggtitle("Internet censorship effors in Russia, Ukraine, and Estonia after the USSR collapse", subtitle = "Varieties of Democracy project data")

ggsave(here("Figures", "Figure Censorship.jpeg"), width = 12, height = 8, dpi = 300)

