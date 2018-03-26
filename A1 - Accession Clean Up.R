library(lubridate)
library(readr)
library(stringr)
library(tidyr)
library(dplyr)
accession_file <- "C:/DataScience/Accessions.csv"
acc_col_headings <- c("ID","Date_Acc","acc_num","status","archives","collection_num",
                      "size","accession_content_description","name1","organization",
                      "address","city","state","zip","country","phone1",
                      "cell","fax","email","notes","credit","date_pro","size_pp","proc_info",
                      "de_acc","date_unknown")
test <- read_csv(accession_file, col_names = acc_col_headings,skip = 1)


# reformat date column
test$accession_accession_date <- parse_date_time(test$Date_Acc, c("m/d/y"))
# how many na in the date column?
sum(is.na(test$Date_Acc))
sum(is.na(test$accession_accession_date))


# Divide Accession #
# Split string on -
test <- separate(test,acc_num,c("accession_number_1","accession_number_2","accession_number_3"), sep = "-")

# make it uppercase only
test$accession_number_3 <- toupper(test$accession_number_3)




test10 <- test %>%
  mutate(prov1=ifelse(!is.na(name1),
                    ifelse(!is.na(organization),
                           paste(name1," (on behalf of",organization,")", sep = " "),
                           name1),
                    organization)) %>%
  mutate(accession_prov1 = paste(prov1, "- contact information may be in accession files"))

test11 <- test10 %>%
  mutate(accession_provenance = ifelse(!is.na(date_unknown),
                                       paste(accession_prov1,"(exact date of donation unknown)"),
                                       accession_prov1))


## Drop these columns
drop_col <- c("ID",
              "Date_Acc",
              "status",
              "collection_num",
              "size",
              "notes",
              "credit",
              "date_pro",
              "size_pp",
              "proc_info",
              "de_acc")
test11 <- test10[,!names(test10) %in% drop_col]
              


## Preparing for export           
cols_to_keep <- c("accession_accession_date",
                  "accession_content_description",
                  "accession_number_1",
                  "accession_number_2",
                  "accession_number_3",
                  "accession_provenance")
test_export <- subset(test11,select = cols_to_keep)

## Export as CSV for import
# remove all na
write.csv(test_export, file = "export.csv", na="", row.names = FALSE)

 ## Exporting All for OpenRefine
write.csv(test10, file="export2.csv", na="")
