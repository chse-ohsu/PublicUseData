# National Plan and Provider Enumeration System (NPPES) 
# a.k.a. NPI Downloadable File, or full replacement Monthly NPI File
# National Provider Identifier Standard (NPI)

# Source:
# https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/NationalProvIdentStand/DataDissemination.html

# Grab the current Full Replacement Monthly NPI File from http://download.cms.gov/nppes/NPI_Files.html
url <- "http://download.cms.gov/nppes/NPPES_Data_Dissemination_Apr_2016.zip" # Update this URL as needed

# Download and unzip the file
f <- tempfile()
download.file(url, f, mode="wb")
path <- tempdir()
unzip(f, list=TRUE)
unzip(f, exdir = path)

# Read the data file
library(data.table)
filenames <- unzip(f, list = TRUE)$Name
hdrFile <- grep("FileHeader\\.csv$", filenames, value = TRUE)
hdrFile <- file.path(path, hdrFile)
datFile <- grep("[0-9]\\.csv$", filenames, value = TRUE)
datFile <- file.path(path, datFile)
D <- fread(datFile)

# Substitute spaces in column names
oldvar <- names(D)
newvar <- gsub("\\s", "_", oldvar)
setnames(D, oldvar, newvar)

# Show some examples
D[grep("OHSU", Provider_Other_Organization_Name), .(NPI, Provider_Other_Organization_Name)]
