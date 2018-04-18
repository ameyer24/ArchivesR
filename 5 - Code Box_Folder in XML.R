###############################################################################
## Create the EAD
###############################################################################
## This creates a minimally valid XML document for import into ArchivesSpace
## This is just carrying box/folder information...
## collection level description will be added in ArchivesSpace.

box_folder_list <- newXMLNode("did")


###############################################################################
## Create each Component Node
###############################################################################

makeTitle  <- function(x) newXMLNode("unittitle", format(x))
makeDate   <- function(x) newXMLNode("unitdate",  format(x))
makeBox    <- function(x) newXMLNode("container", format(x), attrs = c(type="box"))
makeFolder <- function(x) newXMLNode("container", format(x), attrs = c(type="folder"))

addDateType <- function(x) 
## Function to make component records

sapply(row.names(raw_table),
       function(x) {
         newXMLNode("c",
                    parent = box_folder_list,
                    attrs = c(level="file"),
         .children = c(lapply(raw_table[x,1], makeTitle),
                       lapply(raw_table[x,2], makeDate),
                       lapply(raw_table[x,3], makeBox),
                       lapply(raw_table[x,4], makeFolder)))
       })

box_folder_list

saveXML(box_folder_list,file = "box_folder.xml")
