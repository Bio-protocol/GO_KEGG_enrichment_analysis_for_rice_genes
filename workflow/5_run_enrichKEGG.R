##Step 3: KEGG enrichment analysis using annotations from KEGG database

## R
## convert the gene IDs to match with kegg database
# read the rice gene annotaiton table (large file)
library(data.table)
anno <- as.data.frame(fread("cache/IRGSP-1.0_representative_annotation_2021-11-11.tsv", quote="")) #change dir
# convert the gene ID to transcript ID (the kegg ID)
genes_transID <- anno[match(genes, anno$Locus_ID),"Transcript_ID"]
bkgd_transID <- anno[match(bkgd, anno$Locus_ID),"Transcript_ID"]

## R
## run enrichKEGG
library(clusterProfiler) #library
kegg <- enrichKEGG(gene = genes_transID, # a vector of gene id
                   universe = bkgd_transID, # background genes
                   organism = "dosa", # kegg organism
                   keyType = "kegg" # keytype of input gene
                   )

## save results
kegg_df <- as.data.frame(kegg)
write.table(kegg_df, "output/kegg_df.txt",  sep="\t", row.names=FALSE, quote=FALSE)

## dot plot
library(ggplot2)
p1 <- dotplot(kegg, showCategory=10)
ggsave(p1,
       filename = "figures/kegg_dotplot.pdf",
       height = 12,width = 16,units = "cm") #change dir
