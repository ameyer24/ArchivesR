###############################################################################
## Extract the Table from the Document
###############################################################################

test_file <- "C:/DataScience/findingaid.docx"
raw_table <- docx_extract_tbl(read_docx(test_file),trim=TRUE)
###############################################################################
## Organize the Columns
###############################################################################
colnames(raw_table)
## Columns need to be in the following order: title, date, box, folder
## If needed, use the following commands to re-order the columns

## Box-Folder-Title-Date
#raw_table <- raw_table[c(3,4,1,2)]

## Rename the columns for Data Clean Up Processing.
colnames(raw_table) <- c("Title","Date","Box","Folder")

