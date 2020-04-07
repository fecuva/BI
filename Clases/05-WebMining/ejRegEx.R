# importar paquetes

library(stringr)


texto<-"En total, el país exportó 11494 millones de dólares en el 2018. De esto, más de 1000 millones eran algún tipo de dispositivo médico (agujas, jeringas, catéteres, cánulas o similares), 621 millones de prótesis médicas y 833 millones aparatos médicos y 925 millones piñas frescas."

# extraer las cifras de exportación y los rubros
totalesRubros<- str_extract_all(texto,'\\d+\\smillones\\s+([[:alpha:]]+\\s*)+')
totalesRubros

# se descarta el primer elemento de la lista

largo<-length(totalesRubros[[1]])
totalesRubros<- totalesRubros[[1]][2:largo]
totalesRubros

# se dividen los strings para obtener las cantidades y los rubros
 totalesRubros<-str_split(totalesRubros,"millones")
 totalesRubros
 
 # se extraen por separado los montos y los rubros
 montos<-c()
 rubros<-c()
 
 for(i in 1:length(totalesRubros))
 {
     montos<-c(montos,totalesRubros[[i]][1])
     rubros<-c(rubros,totalesRubros[[i]][2])
 }
 
 montos
 rubros
 
 # se convierte a numérico los montos, se limpia el texto de los rubros
 
 montos<-as.numeric(montos)
 rubros<-str_remove(rubros,'\\s+([[:alpha:]]+\\s+)*(de?)\\s')
 rubros<-str_remove(rubros,'\\s+y\\s+')
 
 df<-data.frame(rubros,montos)
 df
 
 