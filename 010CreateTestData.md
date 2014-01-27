010CreateTestData
=================
Purpose
-------
* Download files from [FDA.gov](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm) and create R data frames
* Join the Product dataset to the Package dataset
* Classify the Package Codes into format types
  * 4-4-2
  * 5-3-2
  * 5-4-1
* Sample 100 entires from each Package Code format type
* Export to tab-delimited text files


Download
--------
Download the zip archive from the [FDA.gov](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm) website. Unzip the archive. Read the two datasets into data frames, `dProd` for the Product Code table and `dPack` for the Package Code table.

Code is from [Stackoverflow](http://stackoverflow.com/a/3053883/1427069).

```r
url <- "http://www.fda.gov/downloads/Drugs/DevelopmentApprovalProcess/UCM070838.zip"
f <- tempfile()
download.file(url, f)
t <- unz(f, "product.txt")
dProd <- read.delim(t)
t <- unz(f, "package.txt")
dPack <- read.delim(t)
unlink(f)
```


Rename variables to lower case.

```r
names(dProd) <- tolower(names(dProd))
names(dPack) <- tolower(names(dPack))
```



Join
----
Join the Product dataset to the Package dataset.

```r
require(dplyr, quietly = TRUE)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
d <- inner_join(dProd, dPack)
```

```
## Joining by: c("productid", "productndc")
```



Classify
--------
Classify the Package Codes into format categories
* 4-4-2
* 5-3-2
* 5-4-1

```r
isFmt442 <- grepl("[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{2}", d$ndcpackagecode)
isFmt532 <- grepl("[[:alnum:]]{5}-[[:alnum:]]{3}-[[:alnum:]]{2}", d$ndcpackagecode)
isFmt541 <- grepl("[[:alnum:]]{5}-[[:alnum:]]{4}-[[:alnum:]]{1}", d$ndcpackagecode)
fmt <- rep(NA, length(dPack$ndcpackagecode))
fmt[isFmt442] <- "4-4-2 format"
fmt[isFmt532] <- "5-3-2 format"
fmt[isFmt541] <- "5-4-1 format"
table(fmt, useNA = "ifany")
```

```
## fmt
## 4-4-2 format 5-3-2 format 5-4-1 format 
##        21308        80952        44669
```

```r
d$fmtPackageCode <- format(fmt)
```



Sample
------
Use the `ndcpackagecode` as the sampling frame. Sample 100 entires from each Package Code format type.

```r
frameSampling <- list(type442 = d$ndcpackagecode[d$fmtPackageCode == "4-4-2 format"], 
    type532 = d$ndcpackagecode[d$fmtPackageCode == "5-3-2 format"], type541 = d$ndcpackagecode[d$fmtPackageCode == 
        "5-4-1 format"])
f <- function(x) {
    sample(x, 100)
}
s <- sapply(frameSampling, FUN = f)
```

Rearrange the sample matrix to a vector so it can be used as a lookup.

```r
s <- as.vector(s)
```

Create a data frame of the sampled data.

```r
dSample <- d[d$ndcpackagecode %in% s, ]
table(dSample$fmtPackageCode)
```

```
## 
## 4-4-2 format 5-3-2 format 5-4-1 format 
##          100          100          100
```



Export
------
Export to tab-delimited text files.

```r
f <- "dataForTesting.txt"
write.table(dSample, f, quote = FALSE, sep = "\t", row.names = FALSE)
```

Print a list of variables in the dataset.

```r
names(dSample)
```

```
##  [1] "productid"                 "productndc"               
##  [3] "producttypename"           "proprietaryname"          
##  [5] "proprietarynamesuffix"     "nonproprietaryname"       
##  [7] "dosageformname"            "routename"                
##  [9] "startmarketingdate"        "endmarketingdate"         
## [11] "marketingcategoryname"     "applicationnumber"        
## [13] "labelername"               "substancename"            
## [15] "active_numerator_strength" "active_ingred_unit"       
## [17] "pharm_classes"             "deaschedule"              
## [19] "ndcpackagecode"            "packagedescription"       
## [21] "fmtPackageCode"
```

Print a few records from the dataset.

```r
head(dSample)
```

```
##                                           productid productndc
## 946  0019-9450_78041916-0dcf-492e-95fe-2eabe940f53a  0019-9450
## 1169 0024-1535_1d226524-68e6-4137-930c-7d2760c7ff39  0024-1535
## 1323 0031-2293_d3fdc5ee-9822-3eb8-993d-a3cf276cc600  0031-2293
## 1556 0049-4960_ffbfb7ed-dd6c-4bd1-9958-29771b36abd1  0049-4960
## 2102 0065-0431_049b9fcf-0d61-4f1f-bd60-9b048600574e  0065-0431
## 2107 0065-0474_3c2aecf8-04b4-b1a6-69ff-ad039c2175bb  0065-0474
##              producttypename                     proprietaryname
## 946  HUMAN PRESCRIPTION DRUG                 Sodium Iodide I-131
## 1169 HUMAN PRESCRIPTION DRUG                            Phisohex
## 1323          HUMAN OTC DRUG CHILDRENS DIMETAPP COLD AND ALLERGY
## 1556 HUMAN PRESCRIPTION DRUG                              Zoloft
## 2102          HUMAN OTC DRUG                             Systane
## 2107          HUMAN OTC DRUG                             Systane
##      proprietarynamesuffix
## 946            Therapeutic
## 1169                      
## 1323                      
## 1556                      
## 2102                      
## 2107                      
##                                      nonproprietaryname
## 946                                sodium iodide, i-131
## 1169                                    hexachlorophene
## 1323         brompheniramine maleate, phenylephrine HCl
## 1556                           SERTRALINE HYDROCHLORIDE
## 2102 polyethylene glycol 0.4% and propylene glycol 0.3%
## 2107                                       hypromellose
##           dosageformname  routename startmarketingdate endmarketingdate
## 946             SOLUTION       ORAL           20110822               NA
## 1169            EMULSION    TOPICAL           19760611               NA
## 1323    TABLET, CHEWABLE       ORAL           20050927               NA
## 1556 TABLET, FILM COATED       ORAL           19920211               NA
## 2102     SOLUTION/ DROPS OPHTHALMIC           20090814               NA
## 2107                 GEL OPHTHALMIC           20121215               NA
##      marketingcategoryname applicationnumber
## 946                    NDA         NDA016515
## 1169                   NDA         NDA006882
## 1323   OTC MONOGRAPH FINAL           part341
## 1556                   NDA         NDA019839
## 2102   OTC MONOGRAPH FINAL           part349
## 2107   OTC MONOGRAPH FINAL           part349
##                                                      labelername
## 946                                            Mallinckrodt Inc.
## 1169                                     sanofi-aventis U.S. LLC
## 1323 Richmond Division of Wyeth LLC, a subsidiary of Pfizer Inc.
## 1556                                                      Roerig
## 2102                                          Alcon Research Ltd
## 2107                                    Alcon Laboratories, Inc.
##                                             substancename
## 946                                   SODIUM IODIDE I-131
## 1169                                      HEXACHLOROPHENE
## 1323 BROMPHENIRAMINE MALEATE; PHENYLEPHRINE HYDROCHLORIDE
## 1556                             SERTRALINE HYDROCHLORIDE
## 2102                POLYETHYLENE GLYCOL; PROPYLENE GLYCOL
## 2107                       HYPROMELLOSE 2910 (4000 MPA.S)
##      active_numerator_strength active_ingred_unit
## 946                          5             mCi/mL
## 1169                        30              mg/mL
## 1323                    1; 2.5         mg/1; mg/1
## 1556                        25               mg/1
## 2102                    .4; .3       mL/mL; mL/mL
## 2107                         3               mg/g
##                                                               pharm_classes
## 946  Radioactive Therapeutic Agent [EPC],Radiopharmaceutical Activity [MoA]
## 1169                                                       Antiseptic [EPC]
## 1323                                                                       
## 1556   Serotonin Reuptake Inhibitor [EPC],Serotonin Uptake Inhibitors [MoA]
## 2102                                                                       
## 2107                                                                       
##      deaschedule ndcpackagecode
## 946                0019-9450-02
## 1169               0024-1535-02
## 1323               0031-2293-21
## 1556               0049-4960-50
## 2102               0065-0431-04
## 2107               0065-0474-02
##                                                                      packagedescription
## 946                                    1 VIAL in 1 CAN (0019-9450-02)  > 2 mL in 1 VIAL
## 1169                                        148 mL in 1 BOTTLE, PLASTIC (0024-1535-02) 
## 1323 2 BLISTER PACK in 1 CARTON (0031-2293-21)  > 10 TABLET, CHEWABLE in 1 BLISTER PACK
## 1556                                 50 TABLET, FILM COATED in 1 BOTTLE (0049-4960-50) 
## 2102                               4 VIAL in 1 CARTON (0065-0431-04)  > .4 mL in 1 VIAL
## 2107                                                    3.5 g in 1 TUBE (0065-0474-02) 
##      fmtPackageCode
## 946    4-4-2 format
## 1169   4-4-2 format
## 1323   4-4-2 format
## 1556   4-4-2 format
## 2102   4-4-2 format
## 2107   4-4-2 format
```

