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


