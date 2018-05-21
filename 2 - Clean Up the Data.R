###############################################################################
## Is it a single date or inclusive date?
###############################################################################
# What is an inclusive date?
# Answer: 1 or 2 followed by 3 digits, -, 1 or 2 followed by 3 digits.
date_range_regex <- "[1,2]\\d{3}-[1,2]\\d{3}"

raw_table$Date_Type <- if_else(str_detect(raw_table$Date, date_range_regex),
                               "inclusive",
                               "single")


raw_table <- separate(raw_table,
                      col=Date,
                      into=c("start_date","end_date"),
                      sep = "-",
                      remove=FALSE)

## This tries and get collection level inclusive dates.
min_date <- min(raw_table$start_date, na.rm=T)
max_date <- max(raw_table$end_date, na.rm=T)
min_date <- "1886"
max_date <- "1999"

###############################################################################
## What about missing values or non-date values?
###############################################################################
date_unknown <- c("n.d.","N.D.","no date","N/A","NDG","Various", "N. D.","","??","n. d.","n. d. ","No date")
raw_table$Date <- if_else(raw_table$Date %in% date_unknown,
                          "Undated",
                          raw_table$Date)

###############################################################################
## Replace character strings in folder titles
###############################################################################
# & to and
raw_table$Title <- gsub("&","and",raw_table$Title)
#raw_table$Title <- gsub("Corresp.","Correspondence",raw_table$Title)


#raw_table$Title <- gsub("–","-",raw_table$Title)

#raw_table$Title <- gsub("ECCAK","Evangelical Covenant Church of Alaska",raw_table$Title)
