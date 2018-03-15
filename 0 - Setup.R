## Install and Load Libraries
install.packages("docxtractr")
install.packages("tidyverse")
install.packages("XML")
library(docxtractr)
library(tidyverse)
library(XML)

## Set up Test File
test_file <- "C:/DataScience/testFA.docx"

## Reading the File
raw_table <- docx_extract_tbl(read_docx(test_file))

###############################################################################
## Parse the date field.
###############################################################################
# Determine if date string is is a single date (single) or a range (inclusive)
# date_range_regex - 1 or 2 followed by 3 digits, -, 1 or 2 followed by 3 digits.
date_range_regex <- "[1,2]\\d{3}-[1,2]\\d{3}"

raw_table <- raw_table %>%
  mutate(Date_Normal = if_else(str_detect(Date, date_range_regex),
                               "inclusive",
                               "single"))

# Clean up Dates with some version of "unknown" or "n.d."
date_unknown <- c("n.d.","N.D.","no date")
raw_table2 <- raw_table %>%
  mutate(Date = if_else(Date %in% date_unknown,
                               "Unknown",
                               Date))
# Find a way to spilt the string based for the inclusive dates.
# perhaps do this within the EAD creator?


## Creating the EAD in XML
