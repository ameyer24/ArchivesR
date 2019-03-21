###############################################################################
## Import Data from Microsoft Word Tables
###############################################################################
word_import_file <- "C:/DataScience/findingaid.docx"
raw_table <- docx_extract_tbl(read_docx(word_import_file),trim=TRUE)


###############################################################################
## Rename Columns
###############################################################################
# By default, R expects things to be in this order; this renames the columns
# Use the (optional) commands below to reorder as needed.
colnames(raw_table) <- c("Title","Date","Desc","Box")


###############################################################################
## Import Data from CSV Template
###############################################################################
csv_import_file <- "C:/DataScience/box_folder_template.csv"
raw_table <- read.csv(csv_import_file, stringsAsFactors=FALSE)



###############################################################################
## Optional Commands to Reorder or Drop Columns
###############################################################################

###############################################################################
## Reorder Columns
###############################################################################
## Uncomment this section to rearrange columns.
## Use this if original data is Box-Folder-Title-Date
#raw_table <- raw_table[c(3,4,1,2)]

###############################################################################
## Drop Columns
###############################################################################
## Uncomment this section to drop columns by position.
#raw_table <- raw_table[,-c(3)]

