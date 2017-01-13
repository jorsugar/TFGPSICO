
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

#Los nombres de los docentes aparecen en mayúscula en el SIFP. Se arregla este aspecto en este apartado.

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


#--------------------------------------------------
#Mejora variable Fecha
#La variable fecha incluye la hora de lectura del TFG. Esa hora no es relevante por lo que hay que sacarla.

gral2 <- read.csv("datosGenerales.csv")

library(dplyr)
library(stringr)

x <- gral2$Fecha
x <-  str_sub(x, start=1, end=10)

gral2 <- select(gral2, -X, -Fecha)                                      #elimino la columna fecha que corregí

Fecha <- x

gral2 <- mutate(gral2, Fecha)                                           #agrego el vector con la fecha nueva como columna
gral2 <- select(gral2, Título, Fecha, Formato, Tutor, Revisor, Nota)    #reordeno las variables  

write.csv(gral2, "datosGenerales.csv")
