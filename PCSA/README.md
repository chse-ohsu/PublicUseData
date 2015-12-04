# Primary Care Service Area (PCSA)

THe data source is [The Dartmouth Atlas.](http://www.dartmouthatlas.org/)

* [PCSA Data Download – 2010 (Census Tract Basis)](http://www.dartmouthatlas.org/tools/downloads.aspx?tab=42)
* [Data dictionary](http://www.dartmouthatlas.org/downloads/pcsa/Data_Dictionary_PCSAv3.1_Sept2013.pdf)


## Code examples

Download, read, and merge together the PCSA layer attributes files.

```{r}
grabPCSA <- function (url) {
  require(foreign)
  require(data.table)
  f <- tempfile()
  download.file(url, f, mode="wb")
  D <- read.dbf(f, as.is=TRUE)
  D <- data.table(D)
  vars <- pcsa_vars$old
  D[, names(D) %in% vars, with=FALSE]
}
urlPath <- "http://www.dartmouthatlas.org/downloads/pcsa/"
pcsa1 <- grabPCSA(sprintf("%s/%s", urlPath, "p_103113_1.dbf")
pcsa2 <- grabPCSA(sprintf("%s/%s", urlPath, "p_103113_2.dbf")
pcsa3 <- grabPCSA(sprintf("%s/%s", urlPath, "p_103113_3.dbf")
pcsa4 <- grabPCSA(sprintf("%s/%s", urlPath, "p_103113_4.dbf")
byVar <- c("PCSA", "PCSA_ST")
pcsa <- merge(pcsa1, pcsa2, by=byVar)
pcsa <- merge(pcsa , pcsa3, by=byVar)
pcsa <- merge(pcsa , pcsa4, by=byVar)
rm(pcsa1, pcsa2, pcsa3, pcsa4)
```

Download zip code crosswalk and merge onto PCSA layer attributes.

```{r}
url <- "http://www.dartmouthatlas.org/downloads/pcsa/zip5_pcsav31.dbf"
f <- tempfile()
download.file(url, f, mode="wb")
zip_pcsa_xwalk <- data.table(read.dbf(f, as.is=TRUE))
pcsa <- merge(pcsa, zip_pcsa_xwalk, by="PCSA")
```
