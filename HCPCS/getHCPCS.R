year <- 13
url <- sprintf("https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Downloads/%02danweb.zip",
               year)
f <- tempfile()
download.file(url, f)
file.info(f)
unzip(f, list=TRUE)
unzip(f, exdir=tempdir())
list.files(tempdir())
f <- file.path(tempdir(), sprintf("HCPC20%02d_A-N.txt", year))
colInfo <- matrix(c("HCPCS_CD", "5", "character",
                    "HCPCS_SQNC_NUM", "5", "integer",
                    "HCPCS_REC_IDENT_CD", "1", "character",
                    "HCPCS_LONG_DESC_TXT", "80", "character",
                    "HCPCS_SHORT_DESC_TEXT", "28", "character",
                    "HCPCS_PRCNG_IND_CD", "2", "character",
                    "HCPCS_MLTPL_PRCNG_IND_CD", "1", "character",
                    "FILLER", "6", "character",
                    "HCPCS_CIM_RFRNC_SECT_NUM", "6", "character",
                    "FILLER", "12", "character",
                    "HCPCS_MCM_RFRNC_SECT_NUM", "8", "character",
                    "FILLER", "16", "character",
                    "HCPCS_STATUTE_NUM", "10", "character",
                    "HCPCS_LAB_CRTFCTN_CD", "3", "character",
                    "FILLER", "21", "character",
                    "HCPCS_XREF_CD", "5", "character",
                    "FILLER", "20", "character",
                    "HCPCS_CVRG_CD", "1", "character",
                    "HCPCS_ASC_PMT_GRP_CD", "2", "character",
                    "HCPCS_ASC_PMT_GRP_EFCTV_DT", "8", "character",
                    "HCPCS_MOG_PMT_GRP_CD", "3", "character",
                    "HCPCS_MOG_PMT_PLCY_IND_CD", "1", "character",
                    "HCPCS_MOG_PMT_GRP_EFCTV_DT", "8", "character",
                    "HCPCS_PRCSG_NOTE_NUM", "4", "character",
                    "HCPCS_BETOS_CD", "3", "character",
                    "FILLER", "4", "character",
                    "HCPCS_TYPE_SRVC_CD", "1", "character",
                    "FILLER", "20", "character",
                    "HCPCS_ANSTHSA_BASE_UNIT_QTY", "3", "integer",
                    "HCPCS_CD_ADD_DT", "8", "character",
                    "HCPCS_ACTN_EFCTV_DT", "8", "character",
                    "HCPCS_TRMNTN_DT", "8", "character",
                    "HCPCS_ACTN_CD", "1", "character",
                    "FILLER", "27", "character"),
                  ncol=3,
                  byrow=TRUE)
colInfo <- data.table(colInfo)
setnames(colInfo, names(colInfo), c("name", "width", "class"))
colInfo <- colInfo[, width := as.integer(width)]
hcpcs <- read.fwf(f,
                  widths=colInfo[, width],
                  col.names=colInfo[, name],
                  colClasses=colInfo[, class],
                  fill=TRUE,
                  strip.white=FALSE,
                  stringsAsFactors=FALSE)
hcpcs <- data.table(hcpcs)
hcpcs[HCPCS_REC_IDENT_CD == 3]
hcpcs[HCPCS_REC_IDENT_CD == 3, .N, HCPCS_BETOS_CD]