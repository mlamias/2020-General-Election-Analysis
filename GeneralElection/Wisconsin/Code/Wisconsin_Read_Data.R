#This reads in Wisconsin Election Data for Subsequent processing.

#Import R Package Libraries
library(tidyverse)
library(glue)
library(readr)
library(stringi)
library(readxl)
library(haven)

#Set Constants and working directory
DATA_DIRECTORY <- "D:/Code/Github/2020-General-Election-Analysis/GeneralElection/Wisconsin/Data"
setwd(DATA_DIRECTORY)

zipFiles <- list.files(DATA_DIRECTORY, pattern="\\.zip$", full.names = TRUE)

readElectionData<-function(x){
  objName <- paste0("WI_", tools::file_path_sans_ext(basename(x)))
  .GlobalEnv[[objName]]<- read_delim(x, delim = "\t", escape_double = FALSE, trim_ws = TRUE)
  saveRDS(get(objName, envir = .GlobalEnv), file=glue("{objName}.Rda"))
  print(glue("{objName}.Rda saved to direcotry"))
}

#read in all zip files

lapply(zipFiles, readElectionData)

#Save Datat as R Rda files for reading later
WI_5740_DataRequest <- read_excel("5740_DataRequest.xlsx",  col_types = c("text"), trim_ws=TRUE)
saveRDS(WI_5740_DataRequest, file="WI_5740_DataRequest.Rda")

#Save R Workspace
save.image(file = "WIElectionData.RData")

