## R
## make GO ID-GO name mapping tables
# extract GO term information from a Bioconductor package, GO.db 
library(GO.db)
go_table <- as.data.frame(GOTERM)

# only take go_id, Term, and Oncology columns and remove duplicated rows
godb <- unique(go_table[,c(1,3,4)])

# separate the GO terms into 3 ontology types
godb_BP <- godb[godb$Ontology == "BP", 1:2]
godb_MF <- godb[godb$Ontology == "MF", 1:2]
godb_CC <- godb[godb$Ontology == "CC", 1:2]

# save results
write.table(godb_BP, "data/godb_BP.txt", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(godb_MF, "data/godb_MF.txt", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(godb_CC, "data/godb_CC.txt", sep = "\t", quote = FALSE, row.names = FALSE)

## make GO ID-Gene ID mapping table
# read the rice gene annotation file
goid2gene_all <- read.table("data/rice_combined_go_list.tsv", header=T, sep="\t", quote="", stringsAsFactors = F)

# seperate genes based on their GO annotation types
library(dplyr)
goid2gene_BP <- goid2gene_all %>% dplyr::filter(go_id %in% godb_BP$go_id)
goid2gene_MF <- goid2gene_all %>% dplyr::filter(go_id %in% godb_MF$go_id)
goid2gene_CC <- goid2gene_all %>% dplyr::filter(go_id %in% godb_CC$go_id)

# save results
write.table(goid2gene_BP, "data/goid2gene_BP.txt", sep="\t", row.names=FALSE, quote=FALSE)
write.table(goid2gene_MF, "data/goid2gene_MF.txt", sep="\t", row.names=FALSE, quote=FALSE)
write.table(goid2gene_CC, "data/goid2gene_CC.txt", sep="\t", row.names=FALSE, quote=FALSE)