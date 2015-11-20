# Create NDC Translation Table

NDC codes on Oregon APAC and Medicaid prescription drug claims datasets are in an 11-digit non-hyphenated format.
NDC codes on the data files from the FDA are in a 10-digit hyphenated format.
The NDC data files from the FDA also contain drug names and classes.

So if one wanted to search for a particular drug or class in the claims data, without knowing which codes to search for, the following sequence of steps would need to be followed.

1. Identify which NDC codes correspond to the drug or class using the FDA data.
2. Translate the 10-digit hyphenated NDC codes into 11-digit non-hyphenated codes.
3. Match the desired 11-digit non-hyphenated codes to corresponding claims.

Step 2 necessitates the need for a NDC code translation table. This code describes the creation of such a table.

**The tab-delimited translation table file is in the zip archive, `NDCTranslationTable.zip`.**


## Steps

1. Download files from [FDA.gov](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm) and create R data frames
2. Join the Product dataset to the Package dataset
3. Classify the Package Codes into format types
  * 4-4-2
  * 5-3-2
  * 5-4-1
4. Translate the 10-digit hyphenated format to an 11-digit non-hyphenated format
5. Export to tab-delimited text files
6. Create a zip archive for easy downloading


## Background

> From: Brie Noble  
> Sent: Wednesday, January 08, 2014 3:33 PM  
> To: Benjamin Chan  
> Cc: Brie Noble; Miriam Elman  
> Subject: RE: NDC codes  
> 
> Hi Ben,
> 
> So are the APAC NDC codes 11 digits without hyphens?
> 
> I am pretty sure to go from the 10 digit codes with hypens to the 11 digit
> codes without hyphens you follow this rule:
> 
> If the 10 digit format is 4-4-2 meaning ####-####-## then you add a leading
> zero to the first segment (0####-####-##) and then drop the hyphens so the 11
> digit code would be 0##########
> 
> If the 10 digit format is 5-3-2 meaning #####-###-## then you add a leading
> zero to the second segment (#####-0###-##) and then drop the hyphens so the 11
> digit code would be #####0#####
> 
> If the 10 digit format is 5-4-1 meaning #####-####-# then you add a leading
> zero to the second segment (#####-####-0#) and then drop the hyphens so the 11
> digit code would be #########0#
> 
> Hope that makes sense. So if I am reading correctly you will have to take the
> package codes reported on the FDA website and transform them to the 11 digit
> code and then merge in with the APAC data.
> 
> Let me know if you need help with the programming in SAS, in the past I think
> I have parsed the string into 3 variables using an array and the scan function
> with a hyphen for a delimiter and then use the length function to assess the
> length of each of the parsed string and then add in the leading zero to
> whichever one doesn’t meet the criteria, (i.e. the first parsed string should
> be length 5, the second length 4, and the third length 3) then you can
> concatenate them together.

> Let me know if you have any questions!
> 
> Best,  
> Brie
> 
> From: Benjamin Chan  
> Sent: Wednesday, January 08, 2014 2:58 PM  
> To: Brie Noble  
> Subject: NDC codes  
> 
> Hey Brie,
> 
> A few months ago I asked you about the format of NDC codes in APAC. I’m
> revisiting this for a different project.
> 
> Here’s the information I got from James Oliver over at OHPR when I asked about
> what format the NDC codes are in in APAC and why I couldn’t merge drug details
> from the FDA website.
> 
>> The NDC field contains package codes in the historical NDC format (length 11,
>> no delimiter, leading zeros preserved). Eventually insurers will need to move
>> away from this format, but AFAIK it is still the EDI transaction standard.
>> 
>> James
> 
> Do you know what this “historical NDC format” is? More importantly, where I
> can download a database of drug details that uses this format?
> 
> For reference, here’s the FDA website from which I’ve downloaded drug
> information from: [http://www.fda.gov/drugs/informationondrugs/ucm142438.htm](http://www.fda.gov/drugs/informationondrugs/ucm142438.htm).
> The NDC database file doesn’t seem to be compatible with the “historical NDC
> format” codes used in APAC.
> 
> ~  
> Benjamin Chan, MS, Research Associate


## Download

Download the zip archive from the [FDA.gov](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm) website.
Unzip the archive.
Read the two datasets into data frames, `dProd` for the Product Code table and `dPack` for the Package Code table.

Code is from [Stackoverflow](http://stackoverflow.com/a/3053883/1427069).


```r
url <- "http://www.accessdata.fda.gov/cder/ndc.zip"
f <- tempfile()
download.file(url, f)
t <- unz(f, "product.txt")
dProd <- read.delim(t, stringsAsFactors=FALSE)
t <- unz(f, "package.txt")
dPack <- read.delim(t, stringsAsFactors=FALSE)
unlink(f)
```

Rename variables to lower case.


```r
names(dProd) <- tolower(names(dProd))
names(dPack) <- tolower(names(dPack))
```


## Join

Join the Product dataset to the Package dataset.


```r
require(dplyr, quietly=TRUE)
d <- inner_join(dProd, dPack)
```

```
## Joining by: c("productid", "productndc")
```


## Classify

Classify the Package Codes into format categories

* 4-4-2
* 5-3-2
* 5-4-1


```r
isFmt442 <- grepl("[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{2}", d$ndcpackagecode)
isFmt532 <- grepl("[[:alnum:]]{5}-[[:alnum:]]{3}-[[:alnum:]]{2}", d$ndcpackagecode)
isFmt541 <- grepl("[[:alnum:]]{5}-[[:alnum:]]{4}-[[:alnum:]]{1}", d$ndcpackagecode)
fmt <- rep(NA, nrow(d))
fmt[isFmt442] <- "4-4-2 format"
fmt[isFmt532] <- "5-3-2 format"
fmt[isFmt541] <- "5-4-1 format"
table(fmt, useNA="ifany")
```

```
## fmt
## 4-4-2 format 5-3-2 format 5-4-1 format 
##        22896       105521        55939
```

```r
d$fmtPackageCode <- format(fmt)
```


## Translate

Split the 10-digit hypenated package code.


```r
ndcSplit <- strsplit(d$ndcpackagecode, "-")
```

This returns a list. Convert the list to a data frame for easier manipulation.


```r
ndcSplit <- data.frame(matrix(unlist(ndcSplit), ncol=3, byrow=TRUE))
```

Translate.


```r
d$ndcPackageFmt11[isFmt442] <- paste0("0", ndcSplit$X1[isFmt442],      ndcSplit$X2[isFmt442],      ndcSplit$X3[isFmt442])
d$ndcPackageFmt11[isFmt532] <- paste0(     ndcSplit$X1[isFmt532], "0", ndcSplit$X2[isFmt532],      ndcSplit$X3[isFmt532])
d$ndcPackageFmt11[isFmt541] <- paste0(     ndcSplit$X1[isFmt541],      ndcSplit$X2[isFmt541], "0", ndcSplit$X3[isFmt541])
```


## Export

Export to a tab-delimited text file.


```r
f <- "NDCTranslationTable.txt"
write.table(d, f, quote=FALSE, sep="\t", row.names=FALSE)
```

Print a list of variables in the dataset.


```r
names(d)
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
## [21] "fmtPackageCode"            "ndcPackageFmt11"
```

```r
str(d)
```

```
## 'data.frame':	184356 obs. of  22 variables:
##  $ productid                : chr  "0002-1200_88439a12-a98f-4551-a98f-85422ab2fbcc" "0002-1200_88439a12-a98f-4551-a98f-85422ab2fbcc" "0002-1200_88439a12-a98f-4551-a98f-85422ab2fbcc" "0002-1407_e7af3676-cd9d-4c30-b127-9f6c46ff1589" ...
##  $ productndc               : chr  "0002-1200" "0002-1200" "0002-1200" "0002-1407" ...
##  $ producttypename          : chr  "HUMAN PRESCRIPTION DRUG" "HUMAN PRESCRIPTION DRUG" "HUMAN PRESCRIPTION DRUG" "HUMAN PRESCRIPTION DRUG" ...
##  $ proprietaryname          : chr  "Amyvid" "Amyvid" "Amyvid" "Quinidine Gluconate" ...
##  $ proprietarynamesuffix    : chr  "" "" "" "" ...
##  $ nonproprietaryname       : chr  "Florbetapir F 18" "Florbetapir F 18" "Florbetapir F 18" "Quinidine Gluconate" ...
##  $ dosageformname           : chr  "INJECTION, SOLUTION" "INJECTION, SOLUTION" "INJECTION, SOLUTION" "SOLUTION" ...
##  $ routename                : chr  "INTRAVENOUS" "INTRAVENOUS" "INTRAVENOUS" "INTRAVENOUS" ...
##  $ startmarketingdate       : int  20120601 20120601 20120601 19510301 20141107 20141107 20141107 20141107 20101201 20101201 ...
##  $ endmarketingdate         : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ marketingcategoryname    : chr  "NDA" "NDA" "NDA" "NDA" ...
##  $ applicationnumber        : chr  "NDA202008" "NDA202008" "NDA202008" "NDA007529" ...
##  $ labelername              : chr  "Eli Lilly and Company" "Eli Lilly and Company" "Eli Lilly and Company" "Eli Lilly and Company" ...
##  $ substancename            : chr  "FLORBETAPIR F-18" "FLORBETAPIR F-18" "FLORBETAPIR F-18" "QUINIDINE GLUCONATE" ...
##  $ active_numerator_strength: chr  "51" "51" "51" "80" ...
##  $ active_ingred_unit       : chr  "mCi/mL" "mCi/mL" "mCi/mL" "mg/mL" ...
##  $ pharm_classes            : chr  "Radioactive Diagnostic Agent [EPC],Positron Emitting Activity [MoA]" "Radioactive Diagnostic Agent [EPC],Positron Emitting Activity [MoA]" "Radioactive Diagnostic Agent [EPC],Positron Emitting Activity [MoA]" "Antiarrhythmic [EPC],Cytochrome P450 2D6 Inhibitor [EPC],Cytochrome P450 2D6 Inhibitors [MoA]" ...
##  $ deaschedule              : chr  "" "" "" "" ...
##  $ ndcpackagecode           : chr  "0002-1200-10" "0002-1200-30" "0002-1200-50" "0002-1407-01" ...
##  $ packagedescription       : chr  "1 VIAL, MULTI-DOSE in 1 CAN (0002-1200-10)  > 10 mL in 1 VIAL, MULTI-DOSE" "1 VIAL, MULTI-DOSE in 1 CAN (0002-1200-30)  > 30 mL in 1 VIAL, MULTI-DOSE" "1 VIAL, MULTI-DOSE in 1 CAN (0002-1200-50)  > 50 mL in 1 VIAL, MULTI-DOSE" "10 mL in 1 VIAL (0002-1407-01) " ...
##  $ fmtPackageCode           : chr  "4-4-2 format" "4-4-2 format" "4-4-2 format" "4-4-2 format" ...
##  $ ndcPackageFmt11          : chr  "00002120010" "00002120030" "00002120050" "00002140701" ...
```

Print a sample of records from the dataset.


```r
d[sample(seq(1, nrow(d)), 10), c("ndcpackagecode", "fmtPackageCode", "ndcPackageFmt11", "substancename")]
```

```
##        ndcpackagecode fmtPackageCode ndcPackageFmt11
## 119332   55289-511-90   5-3-2 format     55289051190
## 170299   68084-964-25   5-3-2 format     68084096425
## 40510    21130-604-85   5-3-2 format     21130060485
## 155653   64117-227-01   5-3-2 format     64117022701
## 66887    42248-126-02   5-3-2 format     42248012602
## 163551   65923-505-28   5-3-2 format     65923050528
## 162432   65862-054-30   5-3-2 format     65862005430
## 21250    0781-5950-10   4-4-2 format     00781595010
## 91193    50181-0050-1   5-4-1 format     50181005001
## 165538   66949-994-16   5-3-2 format     66949099416
##                                                                                                                                   substancename
## 119332                                                                                                                  OXYCODONE HYDROCHLORIDE
## 170299                                                                                                                         PROPYLTHIOURACIL
## 40510                                                                                                                                 IBUPROFEN
## 155653                                                                                                               EUPHORBIA RESINIFERA RESIN
## 66887                                                                                                                                OCTINOXATE
## 163551                                                                                                                             CLOTRIMAZOLE
## 162432                                                                                                                              SIMVASTATIN
## 21250                                                                                                            VALSARTAN; HYDROCHLOROTHIAZIDE
## 91193  CEANOTHUS AMERICANUS LEAF; SENNA LEAF; CHIONANTHUS VIRGINICUS BARK; ARSENIC TRIOXIDE; LYCOPODIUM CLAVATUM SPORE; SEPIA OFFICINALIS JUICE
## 165538                                                                                                                            CHLOROXYLENOL
```


## Create a zip archive


```r
zip("NDCTranslationTable.zip", f, flags="a", zip="C:/Program Files/7-Zip/7z.exe")
file.remove(f)
```

```
## [1] TRUE
```
