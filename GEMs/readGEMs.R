library(data.table)

readCsv <- function (url) {
  D <- fread(url)
  show(str(D))
  D
}

# Clinical Modification (CM)
# ICD-10-CM to ICD-9-CM
D1 <- readCsv("http://www.nber.org/gem/icd10cmtoicd9gem.csv")
# ICD-9-CM to ICD-10-CM
D2 <- readCsv("http://www.nber.org/gem/icd9toicd10cmgem.csv")

# Procedure Coding System (PCS)
# ICD-10-PCS to ICD-9-PCS
D3 <- readCsv("http://www.nber.org/gem/icd10pcstoicd9gem.csv")
# ICD-9-PCS to ICD-10-PCS
D4 <- readCsv("http://www.nber.org/gem/icd9toicd10pcsgem.csv")
