log using "H:\CHSE\ActiveProjects\Sandbox\NDCTranslation\020TestTranslation.log"

insheet using "H:\CHSE\ActiveProjects\Sandbox\NDCTranslation\dataForTesting.txt", clear

gen     isFmt442 = 0
replace isFmt442 = 1 if regexm(ndcpackagecode, "[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9][a-zA-Z0-9]")

gen     isFmt532 = 0
replace isFmt532 = 1 if regexm(ndcpackagecode, "[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9][a-zA-Z0-9]")

gen     isFmt541 = 0
replace isFmt541 = 1 if regexm(ndcpackagecode, "[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]-[a-zA-Z0-9]")

gen     fmt = "            "
replace fmt = "4-4-2 format" if isFmt442 
replace fmt = "5-3-2 format" if isFmt532 
replace fmt = "5-4-1 format" if isFmt541 
tabulate fmt

gen ndcPackageSeg1 = regexs(1) if regexm(ndcpackagecode, "([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)")
gen ndcPackageSeg2 = regexs(2) if regexm(ndcpackagecode, "([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)")
gen ndcPackageSeg3 = regexs(3) if regexm(ndcpackagecode, "([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)-*([a-zA-Z0-9]+)")

gen     ndcPackageFmt11 = "           "
replace ndcPackageFmt11 = "0" + ndcPackageSeg1 +       ndcPackageSeg2 +       ndcPackageSeg3 if isFmt442
replace ndcPackageFmt11 =       ndcPackageSeg1 + "0" + ndcPackageSeg2 +       ndcPackageSeg3 if isFmt532
replace ndcPackageFmt11 =       ndcPackageSeg1 +       ndcPackageSeg2 + "0" + ndcPackageSeg3 if isFmt541

outsheet using "H:\CHSE\ActiveProjects\Sandbox\NDCTranslation\dataForTestingTranslated.txt", noquote replace
