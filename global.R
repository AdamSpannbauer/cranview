rm(list = ls())
library(shiny)
library(tidyverse)
library(lubridate)
library(cranlogs)
library(httr)
library(jsonlite)
library(plotly)

# get the list of all packages on CRAN
package_names = names(httr::content(httr::GET("http://crandb.r-pkg.org/-/desc")))


cran_downloads0 <- failwith(NULL, cran_downloads, quiet = TRUE)
get_initial_release_date <- function(packages) {
    min_date = Sys.Date() - 1
    
    for (pkg in packages)
    {
        # api data for package. we want the initial release - the first element of the "timeline"
        pkg_data = httr::GET(paste0("http://crandb.r-pkg.org/", pkg, "/all"))
        pkg_data = httr::content(pkg_data)
        
        initial_release = pkg_data$timeline[[1]]
        min_date = min(min_date, as.Date(initial_release))    
    }
    
    min_date
}

