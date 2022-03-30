## Step 3: KEGG enrichment analysis using annotations from KEGG database
## An R script to perform KEGG enrichment analysis using an clusterProfiler function with gene annotations from the KEGG database.
## Save the output to a table, and visualize the results by a plot.

library(clusterProfiler)
library(data.table)
library(ggplot2)

## read gene lists
# genes of interest
genes <- read.table("input/genes.txt", header=T)
genes <- genes[[1]]
# background genes
bkgd <- read.table("input/bkgd.txt", header=T)
bkgd <- bkgd[[1]]

## convert the gene IDs to match with kegg database
# read the rice gene annotaiton table (large file)
anno <- as.data.frame(fread("cache/IRGSP-1.0_representative_annotation_2021-11-11.tsv", quote=""))
# convert the gene ID to transcript ID (the kegg ID)
genes_transID <- anno[match(genes, anno$Locus_ID),"Transcript_ID"]
bkgd_transID <- anno[match(bkgd, anno$Locus_ID),"Transcript_ID"]

## run enrichKEGG
kegg <- enrichKEGG(gene = genes_transID, # a vector of gene id
                   universe = bkgd_transID, # background genes
                   organism = "dosa", # kegg organism
                   keyType = "kegg", # keytype of input gene
                   pvalueCutoff = 0.05, # p-value cutoff (default)
                   pAdjustMethod = "BH", # multiple testing correction method to calculate adjusted p-value (default)
                   qvalueCutoff = 0.2, # q-value cutoff (default). q value: local FDR corrected p-value.
                   minGSSize = 10, # minimal size of genes annotated for testing (default)
                   maxGSSize = 500  # maximal size of genes annotated for testing (default)
                   )

## save results
kegg_df <- as.data.frame(kegg)
write.table(kegg_df, "output/kegg_df.txt",  sep="\t", row.names=FALSE, quote=FALSE)

## dot plot
p1 <- dotplot(kegg, showCategory=10)
ggsave(p1,
       filename = "figures/kegg_dotplot.pdf",
       height = 12,width = 16,units = "cm") 
