
#Base general
#El objetivo es armar el data set general con toda la info sobre los Trabajos Finales de Grado (TFG)
#Para ello se utilizará web scraping con rvest el la URL: http://sifp1.psico.edu.uy/trabajos-finales-publicos



library(xml2)
library(rvest)
library(dplyr)


#Utilizo rvest para llegar al selector donde se encuentran los títulos de los TFG

Url <- read_html("http://sifp1.psico.edu.uy/trabajos-finales-publicos")

titulo <- Url %>%
  html_nodes(".views-field-title") %>% 
  html_text(trim= TRUE)

length(titulo)
titulo <- titulo[2:1319]



formato <- Url %>%
  html_nodes(".views-field-field-formato-tf") %>%
  html_text(trim= TRUE)

length(formato)
formato <- formato[2:1319]


fecha <- Url %>%
  html_nodes(".views-field-field-fecha-de-lectura-tf") %>%
  html_text(trim= TRUE)

length(fecha)
fecha <- fecha[2:1319]


nombre <- Url %>%
  html_nodes(".views-field-field-nombre-pdocente") %>%
  html_text(trim= TRUE)

length(nombre)
nombre <- nombre[2:1319]

apellido <- Url %>%
  html_nodes(".views-field-field-apellido-pdocente") %>%
  html_text(trim= TRUE)

length(apellido)
apellido <- apellido[2:1319]

nombreTut <- paste(nombre, apellido)

nombrer <- Url %>%
  html_nodes(".views-field-field-nombre-pdocente-1") %>%
  html_text(trim= TRUE)

length(nombrer)
nombrer <- nombrer[2:1319]


apellidor <- Url %>%
  html_nodes(".views-field-field-apellido-pdocente-1") %>%
  html_text(trim= TRUE)

length(apellidor)
apellidor <- apellidor[2:1319]

nombreRev <- paste(nombrer, apellidor)

nota <- Url %>%
  html_nodes(".views-field-field-nota-tf") %>%
  html_text(trim= TRUE)

length(nota)
nota <- nota[2:1319]
nota <- as.numeric(nota)


gral <- data.frame(titulo, fecha, formato, nombreTut, nombreRev, nota)

write.csv(gral, "datosGenerales.csv")

#---------------------------------------

gral1 <- read.csv("datosGenerales.csv")


nombreTut <- tolower(gral1$nombreTut)                                                 #pasa a minúscula toda la columna nombreTut
nombreRev <- tolower(gral1$nombreRev)                                                 #pasa a minúscula toda la columna nombreRev

library(dplyr)
library(stringr)

Tutor <- str_to_title(nombreTut)                                                       #crea un nuevo vector con la 1er letra en mayúscula
Revisor <- str_to_title(nombreRev)                                                     #crea un nuevo vector con la 1er letra en mayúscula

gral1 <- mutate(gral1, Tutor, Revisor)                                                 #agreaga los vectores creados como columnas al data frame
gral1 <- select(gral1, -X, -nombreTut, -nombreRev)                                     #elimina las columnas que ya no sirven
gral1 <- rename(gral1, Título = titulo, Fecha = fecha, Formato = formato, Nota = nota) #cambia el nombre de las columnas
gral1 <- select(gral1, Título, Fecha, Formato, Tutor, Revisor, Nota)                   #reordena las columnas          

View(gral1)

write.csv(gral1, "datosGenerales.csv")





