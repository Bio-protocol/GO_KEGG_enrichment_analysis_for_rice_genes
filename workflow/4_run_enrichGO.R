##Step 2: GO enrichment analysis using annotations from AnnotationHub package

## R
library(AnnotationHub) 
# find rice orgDb
hub <- AnnotationHub()
query(hub, c("Oryza sativa","orgdb")) #output changed
# output:
# AH96211 | org.Oryza_sativa_(japonica_cultivar-group).eg.sqlite
# AH96212 | org.Oryza_sativa_Japonica_Group.eg.sqlite           
# AH96213 | org.Oryza_sativa_subsp._japonica.eg.sqlite

# select the first one (as all three are very similar)
rice <- hub[["AH96211"]] #changed based on new output
# checked keys in the database
# keyTypes(rice) 

## read input gene lists and convert IDs
# genes of interest
genes <- read.table("input/genes.txt", header=T)
genes <- genes[[1]]
# background genes
bkgd <- read.table("input/bkgd.txt", header=T)
bkgd <- bkgd[[1]]
# ID conversion table
IDtable <- read.csv("input/riceIDtable.csv")

# convert rapdb IDs into entrez IDs
genes_eid <- IDtable[match(genes, IDtable$rapdb), "entrezgene"]
# remove NAs
genes_eid <- as.character(genes_eid[!is.na(genes_eid)])
bkgd_eid <- IDtable[match(bkgd, IDtable$rapdb), "entrezgene"]
bkgd_eid <- as.character(bkgd_eid[!is.na(bkgd_eid)])

## R
## run enrichGO function
library(clusterProfiler) #library
go2 <- enrichGO(gene = genes_eid, # a vector of gene id
                universe = bkgd_eid, # background genes
                OrgDb         = rice, # OrgDb object
                ont           = "BP" # One of "MF", "BP", and "CC" subontologies
                )
go2_df <- as.data.frame(go2) 
# result：no enriched GO terms
