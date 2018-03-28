###############################################################################
## Create the EAD
###############################################################################
## This creates a minimally valid XML document for import into ArchivesSpace
## This is just carrying box/folder information...
## collection level description will be added in ArchivesSpace.

arch_desc <- newXMLNode("archdesc",
                        attrs = c(level = "collection"))


did1 <- newXMLNode("did",
                   parent = arch_desc)

###############################################################################
## Create each Component Node
###############################################################################
## This is what I need to iterate from the dataframe.

makeTitle  <- function(x) newXMLNode("unittitle", format(x))
makeDate   <- function(x) newXMLNode("unitdate",  format(x))
makeBox    <- function(x) newXMLNode("container", format(x), attrs = c(type="box"))
makeFolder <- function(x) newXMLNode("container", format(x), attrs = c(type="folder"))
## Function to make component records

sapply(row.names(raw_table),
       function(x) {
         newXMLNode("c",
                    parent = did1,
                    attrs = c(level="file"),
         .children = c(lapply(raw_table[x,1], makeTitle),
                       lapply(raw_table[x,2], makeDate),
                       lapply(raw_table[x,3], makeBox),
                       lapply(raw_table[x,4], makeFolder)))
       })

did1

saveXML(did1,file = "export1.xml")





c <- newXMLNode("c",
                attrs = c(level="file"),
                parent = did1) 

newXMLNode("unittitle","Test Title",
           parent = c)

newXMLNode("unitdate", "1984-2018",
           parent = c)

newXMLNode("container", "1",
           attrs = c(type="box"),
           parent = c)

newXMLNode("container", "1",
           attrs = c(type="folder"),
           parent = c)



arch_desc





rm(arch_desc)








## Old Approaches
ead_R <- xmlTree("ead")

ead_R$addNode("eadheader", close = FALSE)
## eadheader
  ead_R$addNode("eadid")
  ead_R$addNode("filedesc", close = FALSE)
    ead_R$addNode("titlestmt", close = FALSE)
      ead_R$addNode("titleproper", "title",close = FALSE)
        ead_R$addNode("num", "ID2")
      ead_R$closeTag()
    ead_R$closeTag()
  ead_R$closeTag()
ead_R$closeTag()
## end eadheader section

ead_R$addNode("archdesc", attrs = c(level = "collection"), close = FALSE)
## archdes
  ead_R$addNode("did", close = FALSE)
    ead_R$addNode("unittitle", "Title in did")
    ead_R$addNode("unitid", "ID2")
    ead_R$addNode("physdesc", close = FALSE)
      ead_R$addNode("extent", "1 Linear Feet")
    ead_R$closeTag()
    ead_R$addNode("unitdate", "2018")
    ead_R$addNode("dsc", close = FALSE)
    ead_R$closeTag()
  ead_R$closeTag()
ead_R$closeTag()

saveXML(ead_R,file="test2.xml")


ead_R







# Import box/folder information
FA_row <- newXMLNode("did")
newXMLNode("unititle", parent = FA_row)
newXMLNode("unitdate type", parent = FA_row)
newXMLNode("container type", parent = FA_row)
newXMLNode("container type", parent = FA_row)

FA_row
# Exports the XML
ead_main
saveXML(ead_main,file="test.xml")

