
library(xml2)
library(rvest)
library(dplyr)

############################ Función pegar ##################################

pegar <- function(x, y){
  n <- length(x)
  for (i in 1:n) {
    inst <- y
    t <- data.frame(docentes = x, instituto = inst, stringsAsFactors = FALSE)
  }
  t
}
#############################################################################


#fundamentos
Url <- read_html("http://psico.edu.uy/directorio/fundamentos")

fundamentos <- Url %>%
  html_nodes(".views-field-title.active") %>% 
  html_text(trim= TRUE)

length(fundamentos)
fundamentos <- fundamentos[2:67]

f <- "Instituto de Fundamentos y Métodos en Psicología"
funda <- pegar(fundamentos, f)

#--------------------------------------------------------------

#clinica
Url <- read_html("http://psico.edu.uy/directorio/clinica")

clinica <- Url %>%
  html_nodes(".views-field-title.active") %>% 
  html_text(trim= TRUE)

length(clinica)
clinica <- clinica[2:71]

cl <- "Instituto de Psicología Clínica"
clin <- pegar(clinica, cl)

#--------------------------------------------------------------

#social

Url <- read_html("http://psico.edu.uy/directorio/social")

social <- Url %>%
  html_nodes(".views-field-title.active") %>% 
  html_text(trim= TRUE)

length(social)
social <- social[2:76]

so <- "Instituto de Psicología Social"
soc <- pegar(social, so)

#--------------------------------------------------------------

#eduacion

Url <- read_html("http://psico.edu.uy/directorio/educacion")

educacion <- Url %>%
  html_nodes(".views-field-title.active") %>% 
  html_text(trim= TRUE)

length(educacion)
educacion <- educacion[2:52]

ed <- "Instituto de Psicología, Educación y Desarrollo Humano"
edu <- pegar(educacion, ed)

#---------------------------------------------------------------

#salud

Url <- read_html("http://psico.edu.uy/directorio/salud")

salud <- Url %>%
  html_nodes(".views-field-title.active") %>% 
  html_text(trim= TRUE)

length(salud)
salud <- salud[2:35]

sa <- "Instituto de Psicología de la Salud"
sal <- pegar(salud, sa)

#---------------------------------------------------------------

docentes <- rbind(clin, soc, sal, funda, edu)

write.csv(docentes, file="docentesInst.csv")