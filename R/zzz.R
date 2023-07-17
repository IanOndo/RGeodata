
# function to split each ecoregion into simple polygons
split_ecoregions <- function(){
  lapply(1:nrow(RGeodata::ecoregions), function(i) {
    sf::st_cast(RGeodata::ecoregions[i, ], "POLYGON")
  }) %>%
    suppressWarnings() %>%
    do.call(rbind, .)
}


.onLoad <- function(...) {
  # check if the package already has the ecoregions split data
  if(!file.exists(system.file('extdata','ecoregions_split.rda',package="RGeodata"))){
    message("*** splitting the ecoregions dataset")
    ecoregions_split <- try(split_ecoregions(),silent=TRUE)
    if(!inherits(ecoregions_split,"try-error")){
      save(ecoregions_split,file=file.path(find.package("RGeodata"),'extdata','ecoregions_split.rda'))
      message("*** ecoregions split dataset created.")
    }else{
      message("Could not create the ecoregions split dataset !")
    }
  }
  # load the dataset into the package environment
  load(file=file.path(find.package("RGeodata"),'extdata','ecoregions_split.rda'), envir=parent.env(environment()))
}

.onAttach <- function(libname, pkgname){
  load(file=file.path(find.package("RGeodata"),'extdata','ecoregions_split.rda'), envir=as.environment("package:RGeodata"))
}
  
  
  