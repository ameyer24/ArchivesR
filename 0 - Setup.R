## Install and Load Libraries
library(docxtractr)

## Set up Test File
test_file <- "C:/DataScience/testFA.docx"

## Reading the File
raw_table <- docx_extract_tbl(read_docx(test_file))
