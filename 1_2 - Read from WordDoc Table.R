###############################################################################
## Extract the Table from the Document
###############################################################################
#raw_table <- docx_extract_tbl(read_docx(test_file),trim=TRUE)

## Use a template instead
test_file <- "C:/DataScience/box_folder_template.csv"
raw_table <- read.csv(test_file, stringsAsFactors=FALSE)
###############################################################################
## Organize the Columns
###############################################################################
colnames(raw_table)
## Columns need to be in the following order: title, date, box, folder
## If needed, use the following commands to re-order the columns

## Box-Folder-Title-Date
#raw_table <- raw_table[c(3,4,1,2)]

###############################################################################
## Is it a single date or inclusive date?
###############################################################################
# What is an inclusive date?
# Answer: 1 or 2 followed by 3 digits, -, 1 or 2 followed by 3 digits.
date_range_regex <- "[1,2]\\d{3}-[1,2]\\d{3}"

raw_table$Date_Type <- if_else(str_detect(raw_table[[2]], date_range_regex),
                               "inclusive",
                               "single")

raw_table <- separate(raw_table,
                      col=Date,
                      into=c("start_date","end_date"),
                      sep = "-",
                      remove=FALSE)
min_date <- min(raw_table$start_date, na.rm=T)
max_date <- max(raw_table$end_date, na.rm=T)

###############################################################################
## What about missing values or non-date values?
###############################################################################
date_unknown <- c("n.d.","N.D.","no date","N/A")
raw_table[[2]] <- if_else(raw_table[[2]] %in% date_unknown,
                        "Undated",
                        raw_table[[2]])



