#' Terrestrial Ecoregions Of the World (TEOW).
#'
#' A revised map of the TEOW (Dinerstein, 2017).
#'
#' @format A Simple Features Collections with 61905 features and 5 fields:
#' Unlike the ecoregions dataset, each ecoregion is split by polygons (i.e. multipolygon in ecoregions are converted into individual polygons)
#' 
#' ecoregions_split <- lapply(1:nrow(RGeodata::ecoregions), function(i) {
#' sf::st_cast(RGeodata::ecoregions[i, ], "POLYGON")
#' }) %>%
#'  do.call(rbind, .) 
#' 
#' \describe{
#'   \item{ECO_NAME}{name of the ecoregion}
#'   \item{BIOME_NUM}{numeric identifier of the biome}
#'   \item{BIOME_NAME}{name of the biome}
#'   \item{REALM}{name of the realm}
#'   \item{ECO_BIOME}{alphanumeric identifier of the eco-biome}
#'
#' }
#' @source \url{https://ecoregions2017.appspot.com/}
"ecoregions_split"
