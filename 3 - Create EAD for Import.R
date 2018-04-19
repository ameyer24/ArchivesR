###############################################################################
## Define Collection Level Stuff
###############################################################################
collection_title <- "Covenant Headquarters – Papers and Correspondence"
collection_id <-"1/0/3"
collection_date <- paste(min_date, max_date, sep="-")
collection_date_norm <- paste(min_date, max_date, sep="/")

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

newXMLNode("unittitle", collection_title ,parent = collection_did)
newXMLNode("unitid", collection_id ,parent = collection_did)

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


###############################################################################
## Create Box and Folder List
###############################################################################
## This creates a minimally valid XML document for import into ArchivesSpace
## This is just carrying box/folder information...
## collection level description will be added in ArchivesSpace.

box_folder_list <- newXMLNode("did",
                              parent = arch_desc)


###############################################################################
## Create each Component Node
###############################################################################

makeTitle  <- function(x) newXMLNode("unittitle", format(x))
makeDate   <- function(x) newXMLNode("unitdate",  format(x))
makeBox    <- function(x) newXMLNode("container", format(x), attrs = c(type="box"))
makeFolder <- function(x) newXMLNode("container", format(x), attrs = c(type="folder"))

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


saveXML(box_folder_list,file = "box_folder.xml")

###############################################################################
## Add Box and Folder List to Collection Level Description
###############################################################################

main_ead
saveXML(main_ead, file = "ead_for_ASpace.xml")

