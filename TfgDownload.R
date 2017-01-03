#1- Bajando los archivos

dir.create("trabajosFinales") #crea el directorio donde se van a bajar los archivos

setwd("C:/Users/vito/Documents/trabajosFinales")


library(xml2)
library(rvest)
library(dplyr)

URL <- read_html("http://sifp1.psico.edu.uy/trabajos-finales-publicos") #la URL de donde comenzamos a scrapear 

tit <- URL %>% # tit contendrá a los títulos de los TFG que hay en el sitio
  html_nodes(".views-field-title") %>% #detectamos el selector CSS que contiene a los títulos de los TFG
  html_text(trim = TRUE) #extraemos los textos de dicho selector, es decír los títulos y limpiamos los espacios al inicio y final con trim = TRUE
#listo, ya tenemos un vector con todos los títulos de los TFG

#Exploramos el nuevo vector
length(tit)
class(tit)
head(tit)
tail(tit)

#vemos queen la primer fila nos queda el nombre de la columna: "Título"

tit <- tit[2:1319] #sacamos la fila "Título" y nos quedamos sólo con los títulos propiamente dichos

fechaDescarga <- date()
fechaDescarga

#función para bajar los TFG
descargar <- function (x){
  dest <- "C:/Users/vito/Documents/TFG_PSICO/trabajosFinales/"     
  for (i in seq_along(x)){
    titSelec <- x[i]                                                               #itera por los títulos
    t <- html_session("http://sifp1.psico.edu.uy/trabajos-finales-publicos")       #creo una nueva sesión para scrapear
    t <- t %>%  follow_link(titSelec) %>%                                          #entro al link de cada título
      read_html()%>%                                                               #leo el html de la nueva página que estoy visitando
      html_nodes(".field-item.even a") %>%                                         #detecto el selector que necesito y le digo que me importa el link del mismo
      html_attr(name="href")                                                       #extraigo el atributo href del link a, para obtener el vínculo
    t <- t[2]                                                                      #selecciono el link 2 que es el que contiene el pdf del TFG
    incr <- i
    n <- as.character(incr)
    n <-  paste(n, ".pdf", sep = "")
    nombre <- paste (dest,n, sep = "") 
    download.file(t, destfile = nombre, mode = "wb")                               #el mode wb es fundamental para que baje el pdf
  }
}

descargar(tit)



