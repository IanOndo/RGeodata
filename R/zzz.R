
# function to split each ecoregion into simple polygons
.split_ecoregions <- function(){
  lapply(1:nrow(RGeodata::ecoregions), function(i) {
    sf::st_cast(RGeodata::ecoregions[i, ], "POLYGON")
  }) %>%
    suppressWarnings() %>%
    do.call(rbind, .)
}

# function to extract biomes from the ecoregions data
.get_biomes <- function() {
  RGeodata::ecoregions %>% 
    dplyr::group_by(BIOME_NAME) %>% 
    dplyr::summarise() %>%
    `class<-`(c("sf","data.frame"))
}

.onLoad <- function(...) {
  
  # check if the package already has the ecoregions split data
  if(!file.exists(system.file('extdata','ecoregions_split.rda',package="RGeodata"))){
    message("*** splitting the ecoregions dataset")
    ecoregions_split <- try(.split_ecoregions(),silent=TRUE)
    if(!inherits(ecoregions_split,"try-error")){
      dn <- file.path(find.package("RGeodata"),'extdata')
      if(!dir.exists(dn)) dir.create(dn,recursive=TRUE)
      save(ecoregions_split,file=file.path(dn,'ecoregions_split.rda'))
      message("*** ecoregions split dataset created and added to the extdata folder.")
    }else{
      message("Could not create the ecoregions split dataset !")
    }
  }
  
  # check if the package already has the biomes data
  if(!file.exists(system.file('extdata','biomes.rda',package="RGeodata"))){
    message("*** extracting the biomes dataset")
    biomes <- try(.get_biomes(),silent=TRUE)
    if(!inherits(biomes,"try-error")){
      dn <- file.path(find.package("RGeodata"),'extdata')
      if(!dir.exists(dn)) dir.create(dn,recursive=TRUE)
      save(biomes,file=file.path(dn,'biomes.rda'))
      message("*** biomes dataset created and added to the extdata folder.")
    }else{
      message("Could not create the biomes dataset !")
    }
  }
  # load the datasets into the package environment
  load(file=file.path(find.package("RGeodata"),'extdata','ecoregions_split.rda'), envir=parent.env(environment()))
  load(file=file.path(find.package("RGeodata"),'extdata','biomes.rda'), envir=parent.env(environment()))
}

.onAttach <- function(libname, pkgname){
  load(file=file.path(find.package("RGeodata"),'extdata','ecoregions_split.rda'), envir=as.environment("package:RGeodata"))
  load(file=file.path(find.package("RGeodata"),'extdata','biomes.rda'), envir=as.environment("package:RGeodata"))
}
  
  
  