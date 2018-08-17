###############################################################################
## Import Data from Table within Microsoft Word File
###############################################################################
word_import_file <- "C:/DataScience/findingaid.docx"
raw_table <- docx_extract_tbl(read_docx(word_import_file),trim=TRUE)


###############################################################################
## Rename Columns
###############################################################################
# By default, R expects things to be in this order.
colnames(raw_table) <- c("Title","Date","Box","Folder")


###############################################################################
## Import Data from CSV Template
###############################################################################
csv_import_file <- "C:/DataScience/box_folder_template.csv"
raw_table <- read.csv(csv_import_file, stringsAsFactors=FALSE)



raw_table$folder <- seq(1, length.out=nrow(raw_table), by=1)










###############################################################################
## Reorder Columns
###############################################################################
## Use this section to rearrange columns.

## Box-Folder-Title-Date
#raw_table <- raw_table[c(3,4,1,2)]

###############################################################################
## Drop Columns
###############################################################################
## Use this section to drop columns by position.
raw_table <- raw_table[,-c(3)]
###############################################################################
## Add Columns
###############################################################################
## Add columns
#raw_table$date <- "Undated"