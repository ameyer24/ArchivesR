###############################################################################
## Clean Up the Data
###############################################################################

###############################################################################
## Determine Date Range
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
## Manually define dates if there is a need.
min_date <- "1900"
max_date <- "2005"

###############################################################################
## Standardize "No Date" Text
###############################################################################
date_unknown <- c("n.d.","N.D.","no date","N/A","NDG","Various", "N. D.","","??","n. d.","n. d. ","No date","-","N.A.","ND", "NO DATE", "Unknown")
raw_table$Date <- if_else(raw_table$Date %in% date_unknown,
                          "Undated",
                          raw_table$Date)

###############################################################################
## Update the actual data
###############################################################################
# & to and
raw_table$Title <- gsub("&","and",raw_table$Title)
#raw_table$Title <- gsub("Corresp.","Correspondence",raw_table$Title)


#raw_table$Title <- gsub("–","-",raw_table$Title)

#raw_table$Title <- gsub("ECCAK","Evangelical Covenant Church of Alaska",raw_table$Title)
test <- filter(raw_table, str_detect(Title, 'Files'))

raw_table$GNote <- paste("Author:",raw_table$Author,". Translator:", raw_table$Translator, sep=" ")
raw_table$Date <- gsub("/","-",raw_table$Date)
raw_table$Date <- gsub("-00-00","",raw_table$Date)
raw_table$Date <- gsub("-00","",raw_table$Date)

raw_table$Mode <- gsub("Mono","Recorded in mono.",raw_table$Mode)
raw_table$Mode <- gsub("Recorded in stereo","Recorded in stereo.",raw_table$Mode)

"Recorded in stereo/mono."
raw_table$Time <- gsub("60 MIN","Recorded on 60 minute tape.",raw_table$Time)
raw_table$Time <- gsub("90 MIN","Recorded on 90 minute tape.",raw_table$Time)
raw_table$Time <- gsub("30:00","Recorded on 30 minute tape.",raw_table$Time)
raw_table$Time <- gsub("3:00:00","Recorded on 180 minute tape.",raw_table$Time)
raw_table$Time <- gsub("2:00:00","Recorded on 120 minute tape.",raw_table$Time)
raw_table$Time <- gsub("0:40:00","Recorded on 40 minute tape.",raw_table$Time)
raw_table$Time <- gsub("0:45:00","Recorded on 45 minute tape.",raw_table$Time)
raw_table$Time <- gsub("1:20:00","Recorded on 80 minute tape.",raw_table$Time)
raw_table$Time <- gsub("minute tape","minute audio cassette tape",raw_table$Time)
raw_table$Time <- gsub("Recorded on","Recorded on a",raw_table$Time)


count(raw_table,Time)
raw_table$PTNote <- paste(raw_table$Mode, raw_table$Time, sep=" ")
raw_table$PTNote <- gsub("\\. Recorded on a"," on a",raw_table$PTNote)
raw_table$PTNote <- gsub("  "," ",raw_table$PTNote)

raw_table$ID <- str_pad(raw_table$ID,4, pad="0")
raw_table$PTNote <- trimws(raw_table$PTNote, which = c("both"))

raw_table$BioHist2 <- paste("Served in ", raw_table$Location,".", sep="")
raw_table$BioHist3 <- paste("Years served: ", raw_table$Duration,".",sep="")
raw_table$BioHist2 <- gsub("Served in /. ","",raw_table$BioHist2)
raw_table$BioHist  <- paste (raw_table$BioHist2, raw_table$BioHist3, sep = " ")
test <- count(raw_table,BioHist2)
test2 <- count(raw_table,BioHist3)

raw_table$Description <- gsub("-","",raw_table$Description)
raw_table$Provenance <- gsub("-","",raw_table$Provenance)
raw_table$MediumCreatorDesc <- paste(raw_table$Medium, " created by ", raw_table$Creator,". ",raw_table$Description,".", sep = "")
raw_table$MediumCondition <- paste(raw_table$Medium, ". Condition: ", raw_table$Condition,".", sep = "")
