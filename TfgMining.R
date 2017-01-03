#2: Lectura de PDF análisis de datos

setwd("C:/Users/vito/Documents/trabajosFinales/TFG/")

library(dplyr)
library(NLP)
library(tm)


archivos <- list.files(pattern = "pdf$")

leerPdf <- readPDF(control = list(text = "-layout"))

x <- Corpus(URISource(archivos), readerControl = list(reader = leerPdf))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
x <- tm_map(x, toSpace, "/|@|\\|-:;_")

tdm <- TermDocumentMatrix (x, control = list(removePunctuation = TRUE, 
                                             tolower = TRUE, 
                                             removeNumbers = TRUE, 
                                             stripWhitespace = TRUE,
                                             PlainTextDocument= TRUE))

inspect(tdm[1:20,])  

findFreqTerms(tdm, lowfreq = 50, highfreq = Inf)

#tdm2 <- as.matrix(tdm)

#inspect(tdm2[1:20,])

write.csv(tdm, file="prueba.csv")

#findFreqTerms(tdm2, lowfreq = 100, highfreq = Inf)

ft <- findFreqTerms(tdm, lowfreq = 20, highfreq = Inf)
inspect(tdm[ft,])                                                            

ft.tdm <- inspect(tdm[ft,])
apply(ft.tdm, 1, sum)

findAssocs(tdm, c("desarrollo" , "niño"), corlimit= 0.99)
findAssocs(tdm, "positiva", corlimit = 0.99)