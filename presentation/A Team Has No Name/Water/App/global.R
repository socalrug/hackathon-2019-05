library(shiny)
library(data.table)
library(leaflet)
library(shinycssloaders)

# CAcounties <- getData("GADM", country = "USA", level = 2)
# CAcounties <- CAcounties[CAcounties$NAME_1 %in% "California", ]
load("CAcounties.rda")
load("CAzips.rda")

# load("PotableWS.rda") # Dataset 1
# load("Perfs.rda") # Dataset 2
load("Stations.rda") # Dataset 2
# load("PopProj.rda") # Dataset 3
# load("ReComp.rda") # Dataset 4
load("ActVi.rda") # Dataset 4