

## Reading the File
raw_table <- docx_extract_tbl(read_docx(test_file))

###############################################################################
## Parse the date field.
###############################################################################
# Determine if date string is is a single date (single) or a range (inclusive)
# date_range_regex - 1 or 2 followed by 3 digits, -, 1 or 2 followed by 3 digits.
date_range_regex <- "[1,2]\\d{3}-[1,2]\\d{3}"

raw_table <- raw_table %>%
  mutate(Date_Normal = if_else(str_detect(Dates, date_range_regex),
                               "inclusive",
                               "single"))

# Clean up Dates with some version of "unknown" or "n.d."
date_unknown <- c("n.d.","N.D.","no date")
raw_table <- raw_table %>%
  mutate(Date = if_else(Date %in% date_unknown,
                        "Unknown",
                        Date))
# At some point, need to divide the inclusive dates into begin and end.

# Some finding aids have acronyms; explain them.