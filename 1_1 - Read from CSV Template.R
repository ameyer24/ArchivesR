test_file <- "C:/DataScience/video_umatics.csv"

raw_table <- read.csv(test_file)

## Create Item list in EAD
box_folder_list <- newXMLNode("did")


###############################################################################
## Create each Component Node
###############################################################################

makeTitle  <- function(x) newXMLNode("unittitle", format(x))
makeID     <- function(x) newXMLNode("unitid", format(x))
makeCase    <- function(x) newXMLNode("container", format(x),
                                      attrs = c(label = "Moving Images",
                                                type="case"))


  
sapply(row.names(raw_table),
         function(x) {
           newXMLNode("c",
                      parent = box_folder_list,
                      attrs = c(level="item"),
                      .children = c(lapply(raw_table[x,2], makeTitle),
                                    lapply(raw_table[x,1], makeID),
                                    lapply(raw_table[x,6], makeCase)))
         })

box_folder_list

saveXML(box_folder_list,file = "box_folder.xml")
