library(here)
library(tidyverse)
library(ggthemes)

v_dem <-read.csv("/Users/aidarzinnatullin/Downloads/V-Dem-CY-Core_csv_v13/V-Dem-CY-Core-v13.csv",na.strings = "..", comment.char = '#')
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

