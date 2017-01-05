
#base general

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

