setwd('./BI/')

library(arules)
library(arulesViz)
library(tidyverse)
library(plyr)
library(ggplot2)
library(knitr)
library(lubridate)
library(RColorBrewer)

install.packages(c('arules','arulesViz','tidyverse','plyr','ggplot2','knitr','lubridate','RColorBrewer'))

datos<- read.csv('AdultosUSA.csv',sep=';',dec=',',stringsAsFactors = FALSE)
head(datos)

str(datos)
colnames(datos)
datos$Ingresos <- as_factor(datos$Ingresos) 
datos$Ocupacion <- as_factor(datos$Ocupacion) 
datos$HorasSemanales <- as_factor(datos$HorasSemanales) 

datos<- data.frame(lapply(datos, as_factor))

datos2 <- as(datos, "transactions")
reglas<- apriori(datos2,parameter = list(supp=0.001,conf=0.8,maxlen=10))
inspect(reglas[1:10])

subconjuntos<- which(colSums(is.subset(reglas,reglas))>1)

reglasFinal<- reglas[-subconjuntos]
inspect(reglasFinal[1:10])



# se filtran las reglas con confianza superior a 0.25
mejoresReglas<- reglasFinal[quality(reglasFinal)$confidence>0.25]

# graficar las 5 mejores reglas

cincoMejores<- head(mejoresReglas,n=5,by='confidence')

plot(cincoMejores,method = 'graph',engine = 'htmlwidget')


reglasAntIngMay50<- apriori(datos2,parameter =list(supp=0.0011,conf=0.9), 
                            appearance = list(default='lhs',rhs='Ingresos=>50K.'))

inspect(head(reglasAntIngMay50))



