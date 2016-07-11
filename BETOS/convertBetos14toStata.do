******************************************************
* Purpose: Read in  2014 BETOS text file, save as .dta
* Date: 8-Jul-2016
* Author: Christina Charlesworth
******************************************************

* read in file from CHSE github
infix str cpt 1-5 str betos 7-9 str enddate 10-17 using "https://raw.githubusercontent.com/chse-ohsu/PublicUseData/master/BETOS/betpuf14/betpuf14.txt", clear

* generate aggregate category variable
gen facBetos = "E & M" if (regexm(betos, "^M"))
replace facBetos = "Procedures" if (regexm(betos, "^P"))
replace facBetos = "Imaging" if (regexm(betos, "^I"))
replace facBetos = "Tests" if (regexm(betos, "^T"))
replace facBetos = "DME" if (regexm(betos, "^D"))
replace facBetos = "Other" if (regexm(betos, "^O"))
replace facBetos = "Except./unclass." if (regexm(betos, "^Y") | regexm(betos, "^Z"))

* save to shared drive
save "E:\Share\LookupTablesAndCrosswalks\BETOS\betpuf14\betpuf14.dta"
