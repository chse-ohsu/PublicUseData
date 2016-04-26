# NPPES
Benjamin Chan  
April 26, 2016  

R Markdown script is in [import.Rmd](import.Rmd).

National Plan and Provider Enumeration System (NPPES);
a.k.a. NPI Downloadable File, or full replacement Monthly NPI File,
National Provider Identifier Standard (NPI).

[Source](https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/NationalProvIdentStand/DataDissemination.html)

Grab the current Full Replacement Monthly NPI File from
[http://download.cms.gov/nppes/NPI_Files.html](http://download.cms.gov/nppes/NPI_Files.html)


```r
url <- "http://download.cms.gov/nppes/NPPES_Data_Dissemination_Apr_2016.zip" # Update this URL as needed
```

Download and unzip the file


```r
f <- tempfile()
download.file(url, f, mode="wb")
path <- tempdir()
unzip(f, exdir = path)
unzip(f, list=TRUE)
```

```
##                                                     Name     Length
## 1                          npidata_20050523-20160410.csv 5881312309
## 2                npidata_20050523-20160410FileHeader.csv      12249
## 3 NPPES Data Dissemination_Public File - Code Values.pdf     344918
## 4       NPPES Data Dissemination_Public File- Readme.pdf     520252
##                  Date
## 1 2016-04-11 23:40:00
## 2 2016-04-11 23:40:00
## 3 2016-04-11 23:40:00
## 4 2016-04-11 23:40:00
```

Read the data file


```r
library(data.table)
filenames <- unzip(f, list = TRUE)$Name
hdrFile <- grep("FileHeader\\.csv$", filenames, value = TRUE)
hdrFile <- file.path(path, hdrFile)
datFile <- grep("[0-9]\\.csv$", filenames, value = TRUE)
datFile <- file.path(path, datFile)
D <- fread(datFile)
```

```
## 
Read 0.0% of 4860174 rows
Read 0.6% of 4860174 rows
Read 1.0% of 4860174 rows
Read 1.4% of 4860174 rows
Read 2.1% of 4860174 rows
Read 2.5% of 4860174 rows
Read 2.9% of 4860174 rows
Read 3.5% of 4860174 rows
Read 3.7% of 4860174 rows
Read 4.3% of 4860174 rows
Read 4.9% of 4860174 rows
Read 5.3% of 4860174 rows
Read 6.0% of 4860174 rows
Read 6.4% of 4860174 rows
Read 7.0% of 4860174 rows
Read 7.6% of 4860174 rows
Read 8.0% of 4860174 rows
Read 8.6% of 4860174 rows
Read 9.3% of 4860174 rows
Read 9.9% of 4860174 rows
Read 10.3% of 4860174 rows
Read 10.9% of 4860174 rows
Read 11.5% of 4860174 rows
Read 11.9% of 4860174 rows
Read 12.6% of 4860174 rows
Read 13.0% of 4860174 rows
Read 13.6% of 4860174 rows
Read 14.2% of 4860174 rows
Read 14.8% of 4860174 rows
Read 15.4% of 4860174 rows
Read 16.0% of 4860174 rows
Read 16.5% of 4860174 rows
Read 17.1% of 4860174 rows
Read 17.7% of 4860174 rows
Read 18.3% of 4860174 rows
Read 18.9% of 4860174 rows
Read 19.5% of 4860174 rows
Read 20.2% of 4860174 rows
Read 20.6% of 4860174 rows
Read 21.2% of 4860174 rows
Read 21.8% of 4860174 rows
Read 22.4% of 4860174 rows
Read 23.0% of 4860174 rows
Read 23.7% of 4860174 rows
Read 24.3% of 4860174 rows
Read 24.9% of 4860174 rows
Read 25.5% of 4860174 rows
Read 26.1% of 4860174 rows
Read 26.5% of 4860174 rows
Read 27.2% of 4860174 rows
Read 27.8% of 4860174 rows
Read 28.4% of 4860174 rows
Read 29.0% of 4860174 rows
Read 29.6% of 4860174 rows
Read 30.2% of 4860174 rows
Read 31.1% of 4860174 rows
Read 31.7% of 4860174 rows
Read 32.3% of 4860174 rows
Read 32.9% of 4860174 rows
Read 33.1% of 4860174 rows
Read 33.7% of 4860174 rows
Read 34.4% of 4860174 rows
Read 35.0% of 4860174 rows
Read 35.6% of 4860174 rows
Read 36.2% of 4860174 rows
Read 36.8% of 4860174 rows
Read 37.4% of 4860174 rows
Read 38.1% of 4860174 rows
Read 38.7% of 4860174 rows
Read 39.3% of 4860174 rows
Read 39.9% of 4860174 rows
Read 40.5% of 4860174 rows
Read 41.2% of 4860174 rows
Read 41.8% of 4860174 rows
Read 42.4% of 4860174 rows
Read 43.0% of 4860174 rows
Read 43.6% of 4860174 rows
Read 44.2% of 4860174 rows
Read 44.9% of 4860174 rows
Read 45.5% of 4860174 rows
Read 46.1% of 4860174 rows
Read 46.7% of 4860174 rows
Read 47.3% of 4860174 rows
Read 47.9% of 4860174 rows
Read 48.6% of 4860174 rows
Read 49.2% of 4860174 rows
Read 49.8% of 4860174 rows
Read 50.4% of 4860174 rows
Read 51.0% of 4860174 rows
Read 51.6% of 4860174 rows
Read 52.3% of 4860174 rows
Read 52.9% of 4860174 rows
Read 53.5% of 4860174 rows
Read 54.1% of 4860174 rows
Read 54.7% of 4860174 rows
Read 55.1% of 4860174 rows
Read 55.8% of 4860174 rows
Read 56.4% of 4860174 rows
Read 57.0% of 4860174 rows
Read 57.6% of 4860174 rows
Read 58.2% of 4860174 rows
Read 58.8% of 4860174 rows
Read 59.5% of 4860174 rows
Read 60.1% of 4860174 rows
Read 60.7% of 4860174 rows
Read 61.3% of 4860174 rows
Read 61.9% of 4860174 rows
Read 62.5% of 4860174 rows
Read 63.2% of 4860174 rows
Read 63.8% of 4860174 rows
Read 64.4% of 4860174 rows
Read 65.0% of 4860174 rows
Read 65.6% of 4860174 rows
Read 66.3% of 4860174 rows
Read 66.7% of 4860174 rows
Read 67.3% of 4860174 rows
Read 67.9% of 4860174 rows
Read 68.5% of 4860174 rows
Read 69.1% of 4860174 rows
Read 69.8% of 4860174 rows
Read 70.4% of 4860174 rows
Read 71.0% of 4860174 rows
Read 71.6% of 4860174 rows
Read 71.8% of 4860174 rows
Read 72.4% of 4860174 rows
Read 73.0% of 4860174 rows
Read 73.7% of 4860174 rows
Read 74.3% of 4860174 rows
Read 74.9% of 4860174 rows
Read 75.5% of 4860174 rows
Read 76.1% of 4860174 rows
Read 76.7% of 4860174 rows
Read 77.4% of 4860174 rows
Read 78.0% of 4860174 rows
Read 78.6% of 4860174 rows
Read 79.2% of 4860174 rows
Read 79.8% of 4860174 rows
Read 80.4% of 4860174 rows
Read 81.1% of 4860174 rows
Read 81.7% of 4860174 rows
Read 82.3% of 4860174 rows
Read 82.9% of 4860174 rows
Read 83.5% of 4860174 rows
Read 84.2% of 4860174 rows
Read 84.8% of 4860174 rows
Read 85.4% of 4860174 rows
Read 86.0% of 4860174 rows
Read 86.6% of 4860174 rows
Read 87.2% of 4860174 rows
Read 87.9% of 4860174 rows
Read 88.5% of 4860174 rows
Read 89.1% of 4860174 rows
Read 89.7% of 4860174 rows
Read 90.3% of 4860174 rows
Read 90.9% of 4860174 rows
Read 91.6% of 4860174 rows
Read 92.2% of 4860174 rows
Read 92.8% of 4860174 rows
Read 93.4% of 4860174 rows
Read 93.6% of 4860174 rows
Read 94.2% of 4860174 rows
Read 94.9% of 4860174 rows
Read 95.5% of 4860174 rows
Read 96.1% of 4860174 rows
Read 96.7% of 4860174 rows
Read 97.3% of 4860174 rows
Read 97.9% of 4860174 rows
Read 98.6% of 4860174 rows
Read 99.2% of 4860174 rows
Read 100.0% of 4860174 rows
Read 4860174 rows and 329 (of 329) columns from 5.477 GB file in 00:11:08
```

Substitute spaces in column names


```r
oldvar <- names(D)
newvar <- gsub("\\s", "_", oldvar)
setnames(D, oldvar, newvar)
```

Show some examples


```r
D[grep("OHSU", Provider_Other_Organization_Name), .(NPI, Provider_Other_Organization_Name)]
```

```
##            NPI
##  1: 1609837574
##  2: 1609824010
##  3: 1346263340
##  4: 1417969304
##  5: 1982797155
##  6: 1790878965
##  7: 1790878973
##  8: 1063596690
##  9: 1588748248
## 10: 1972688919
## 11: 1740369818
## 12: 1417036963
## 13: 1851460638
## 14: 1396800330
## 15: 1053454645
## 16: 1922141415
## 17: 1477675148
## 18: 1427263680
## 19: 1639356991
## 20: 1831368554
## 21: 1851565493
## 22: 1699929117
## 23: 1114164381
## 24: 1952542540
## 25: 1437385036
## 26: 1770713224
## 27: 1528396850
## 28: 1952630204
## 29: 1568780955
## 30: 1336458140
## 31: 1518253996
## 32: 1760760599
## 33: 1073879268
## 34: 1104182369
## 35: 1487902706
## 36: 1912259284
## 37: 1316354970
## 38: 1154709426
## 39: 1750753687
##            NPI
##                                           Provider_Other_Organization_Name
##  1:                                      DIAGNOSTIC LAB OHSU DENTISTRY SCH
##  2:                                             OHSU HOSPITALS AND CLINICS
##  3:                                               OHSU OUTPATIENT PHARMACY
##  4:                                     OHSU SCAPPOOSE RURAL HEALTH CLINIC
##  5:                                             OHSU GABRIEL PARK PHARMACY
##  6:                                           OHSU - CHH INFUSION PHARMACY
##  7:                                               OHSU CHH RETAIL PHARMACY
##  8:                                               OHSU SCHOOL OF DENTISTRY
##  9:                                       OHSU DEPARTMENT OF OPHTHALMOLOGY
## 10:                         OHSU CHILD DEVELOPMENT & REHABILITATION CENTER
## 11:                                           OHSU FACULTY DENTAL PRACTICE
## 12:                                             OHSU FERTILITY CONSULTANTS
## 13:                      OHSU INTERCULTURAL PSYCHIATRIC PROGRAM (OHSU IPP)
## 14:                                      OHSU RUSSELL STREET DENTAL CLINIC
## 15:                              OHSU DOERNBECHER CHILDRENS HOSP. PHARMACY
## 16:                                      OHSU CASEY EYE INSTITUTE PHARMACY
## 17:                                            OHSU RICHMOND HEALTH CENTER
## 18:                                          OHSU BEHAVIORAL HEALTH CLINIC
## 19:                                         OHSU MEDICAL GROUP IN LONGVIEW
## 20:                           OHSU SLEEP DISORDERS PROGRAM AT THE MARRIOTT
## 21:                              OHSU INTERCULTURAL PSYCH PROGRAM - EUGENE
## 22:                                       OHSU SLEEP DISORDERS PROGRAM DME
## 23: OHSU KNIGHT CANCER INSTITUTE-BEAVERTON HEMATOLOGY AND ONCOLOGY OUTPATI
## 24:                                          OHSU RICHMOND CLINIC PHARMACY
## 25:                                 OHSU INTERCULTURAL PSYCHIATRIC PROGRAM
## 26:                                               OHSU MAIL ORDER PHARMACY
## 27:                                        OHSU CASEY EYE INSTITUTE AT CHH
## 28:                                         OHSU LOWER COLUMBIA EYE CLINIC
## 29:                                    OHSU CASEY EYE INSTITUTE AT ASTORIA
## 30:                                               OHSU PARTNERSHIP PROJECT
## 31:                                    OHSU KNIGHT DIAGNOSTIC LABORATORIES
## 32:                               OHSU CEI MOLECULAR DIAGNOSTIC LABORATORY
## 33:                         OHSU CHILD DEVELOPMENT & REHABILITATION CENTER
## 34:                                         OHSU CARDIOLOGY HEART SERVICES
## 35:                        OHSU FAMILY MEDICINE AT RICHMOND WALK-IN CLINIC
## 36:                                 OHSU INTERNAL MEDICINE AT MARQUAM HILL
## 37:                                    OHSU AVEL GORDLY CENTER FOR HEALING
## 38:                                              OHSU - INPATIENT PHARMACY
## 39:                                 OHSU INTERCULTURAL PSYCHIATRIC PROGRAM
##                                           Provider_Other_Organization_Name
```
