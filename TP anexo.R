library(sf)
library(tidyverse)


Bien! Bueno ya podemos ver un poco mejor la distribucion de los contenedores verdes por comuna. Pero hay alguna forma de 
ver mejor esta informacion? Que pasa si queremos ver la distribucion mas alla de los barrios y comunas y de su relacion con la poblacion
, osea si queremos ver la distribucion en toda caba? 

  
vamos a volver a cargar la data, pero esta vez en vez de usar el .csv vamos a cargar un .shp y trataremos que 
nos quede un objeto mas amigable para manipular

#la misma data pero con nuevo formato, en vez de un df vamos a tratar con un sf
campanas_verdes<-st_read("contenedores_verdes_wgs84.shp")
#mapa_caba2<-read_sf("campanas-verdes.csv")

#cargamos el mapa de CABA limpio, sin division administrativa ni geografica, osea solo el perimetro
mapa_caba_link<-read_sf("https://cdn.buenosaires.gob.ar/datosabiertos/datasets/perimetro/perimetro.geojson")

podemos ver el mapa con unas simples lineas

ggplot(mapa_caba_link)+
  geom_sf()

#ahora vamos a graficar la distribucion geografica de los contenedores verdes en CABA, primero tenemos que
#trabajar un poco el objeto


campanas_verdes_coords_separadas <- campanas_verdes %>%
  mutate(lat = unlist(map(mapa_caba$geometry,1)),
         long = unlist(map(mapa_caba$geometry,2)))

plot_calor<-ggplot()+
  geom_sf(data=mapa_caba_link)+
  geom_density2d_filled(data = coords_separadas, aes(x=lat, y=long), alpha=0.5)
plot_calor