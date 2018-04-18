###############################################################################
## Define Collection Level Stuff
###############################################################################
collection_title <- "Covenant Treasurer’s Records"
collection_id <-"1/0/2"
collection_date1 <- 2001
collection_date2 <- 2002

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
                              "2001",
                              parent = collection_did,
                              attrs = c(normal="2001/2001"))


main_ead
###############################################################################
## Add Box and Folder List
###############################################################################
xmlParent(box_folder_list) = arch_desc
main_ead
saveXML(main_ead, file = "ead_for_ASpace.xml")

