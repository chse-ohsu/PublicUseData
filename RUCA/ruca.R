# Source: http://depts.washington.edu/uwruca/ruca-data.php
# Code definitions: http://depts.washington.edu/uwruca/ruca-codes.php
url <- "http://depts.washington.edu/uwruca/ruca_data/2006%20Complete%20Excel%20RUCA%20file.xls.zip"
path <- tempdir()
f <- tempfile()
download.file(url, f)
unzip(f, list=TRUE)
filenames <- unzip(f, list=TRUE)[, "Name"]
isValidFile <- grep("^[0-9a-z]", filenames, ignore.case=TRUE)
unzip(f, files=filenames[isValidFile], exdir=path)
# install.packages("readxl")
library(readxl)
f <- file.path(tempdir(), filenames[isValidFile])
file.info(f)
ruca <- read_excel(f)