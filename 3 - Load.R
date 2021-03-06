###############################################################################
## Define Collection Level Information
###############################################################################
## Define a few collection level variables to create the EAD file
collection_title <- "Collection Title"
collection_id <-"1/1/1/1"
collection_date <- paste(min_date, max_date, sep="-")
collection_date_norm <- paste(min_date, max_date, sep="/")
collection_access_note <- "There are no access restrictions on the materials and the collection is open to all members of the public. However, the researcher assumes full responsibility for conforming with the laws of libel, privacy, and copyright that may be involved in the use of this collection."

###############################################################################
## Create Collection Level Description
###############################################################################
main_ead <- newXMLNode("ead")
newXMLNode("eadheader", parent = main_ead)

arch_desc <- newXMLNode("archdesc",
                        attrs = c(level = "collection"),
                        parent = main_ead)

collection_did <- newXMLNode("did",
                             parent = arch_desc)

newXMLNode("unittitle", collection_title, parent = collection_did)
newXMLNode("unitid", collection_id, parent = collection_did)

collection_extent <- newXMLNode("physdesc",
                                parent = collection_did,
                                attrs = c(altrender="whole"))

newXMLNode("extent", "1 Import",
           parent = collection_extent,
           attrs = c(altrender="materialtype spaceoccupied"))

collection_date <- newXMLNode("unitdate",
                              collection_date,
                              parent = collection_did,
                              attrs = c(normal=collection_date_norm))

access_restriction <- newXMLNode("accessrestrict",
                                 parent = arch_desc)
access_head <- newXMLNode("head",
                          "Conditions Governing Access",
                          parent = access_restriction)

access_para <- newXMLNode("p",
                          collection_access_note,
                          parent = access_restriction)


###############################################################################
## Create Box and Folder List
###############################################################################
## This creates a minimally valid XML document for import into ArchivesSpace
## This is just carrying box/folder information...
## collection level description will be added in ArchivesSpace.

box_folder_list <- newXMLNode("did",parent = arch_desc)

###############################################################################
## Functions to create each component node
###############################################################################
## Define functions to make each XMLNode
makeTitle   <- function(x) newXMLNode("unittitle", format(x))
makeDate    <- function(x) newXMLNode("unitdate",  format(x))
makeBox     <- function(x) newXMLNode("container", format(x), attrs = c(type="box"))
makeFolder  <- function(x) newXMLNode("container", format(x), attrs = c(type="folder"))


###############################################################################
## Applying the functions to the dataframe
###############################################################################
## For every row in the raw_table...
## Apply the function defined here...
## That creates a new XML Node for every container...
## By using the functions defined above for each data point.
sapply(row.names(raw_table),
       function(x) {
         newXMLNode("c",
                    parent = box_folder_list,
                    attrs = c(level="file"),
                    .children = c(lapply(raw_table[x,1], makeTitle),
                                  lapply(raw_table[x,2], makeDate),
                                  lapply(raw_table[x,5], makeBox),
                                  lapply(raw_table[x,6], makeFolder)))
         })


###############################################################################
## Save the EAD as XML for import into ArchivesSpace
###############################################################################
## Save XML file.
saveXML(main_ead, file = "ead_for_ASpace.xml")










###############################################################################
## Applying the functions to the dataframe - OTHER
###############################################################################
## This approach can create more than just title, date, box, and folder nodes
## These functions create other nodes.
## These functions are a work in progress.
makeID      <- function(x) newXMLNode("unitid", format(x))
makeCase    <- function(x) newXMLNode("container", format(x), attrs = c(label="audio",type="case"))
makeObject  <- function(x) newXMLNode("container", format(x), attrs = c(label="Graphic Materials",type="object"))
makeNote    <- function(x) newXMLNode("note",  format(x)) # creator
makeBioHist <- function(x) newXMLNode("bioghist", format(x))
makePhysDesc<- function(x) newXMLNode("physdesc", format(x))
makeAcqInfo <- function(x) newXMLNode("acqinfo", format(x))
makeDim     <- function(x) newXMLNode("dimensions", format(x)) # need to add things in EAD.

sapply(row.names(raw_table),
       function(x) {
         newXMLNode("c",
                    parent = box_folder_list,
                    attrs = c(level="file"),
                    .children = c(lapply(raw_table[x,1], makeTitle),
                                  lapply(raw_table[x,2], makeDate),
                                  lapply(raw_table[x,5], makePhysDesc),
                                  lapply(raw_table[x,6], makeBox)))
       })

