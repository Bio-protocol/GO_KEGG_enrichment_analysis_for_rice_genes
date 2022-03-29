## Usage: an R script to run the univeral enrichment function from clusterProfiler using self-provided gene lists and gene annotation files. Save the output to a table, and visualize the results by a plot.

library(clusterProfiler)
library(ggplot2)

## read gene lists and annotation files
# genes of interest
genes <- read.table("input/genes.txt", header=T)
genes <- genes[[1]]
# background genes
bkgd <- read.table("input/bkgd.txt", header=T)
bkgd <- bkgd[[1]]

# TERM2GENE
term2gene <- read.table("data/goid2gene_BP.txt", sep="\t", header=T, quote="", stringsAsFactors = F)
# TERM2NAME
term2name <- read.table("data/godb_BP.txt", sep="\t", header=T, quote="", stringsAsFactors = F)

## R
## run the universal enrichment function, enricher
go <- enricher(gene = genes, # a vector of gene id
               universe = bkgd, # background genes
               TERM2GENE = term2gene, # user input annotation of TERM TO GENE mapping 
               TERM2NAME = term2name, # user input of TERM TO NAME mapping
               pvalueCutoff = 0.05, # p-value cutoff (default)
               pAdjustMethod = "BH", # multiple testing correction method to calculate adjusted p-value (default)
               qvalueCutoff = 0.2, # q-value cutoff (default). q value: local FDR corrected p-value.
               minGSSize = 10, # minimal size of genes annotated for testing (default)
               maxGSSize = 500  # maximal size of genes annotated for testing (default)
               )

## save results
go_df <- as.data.frame(go)
write.table(go_df, "output/go_df.txt", sep="\t", row.names=FALSE, quote=FALSE)

## dot plot
p1 <- dotplot(go, showCategory=10)
ggsave(p1,
       filename = "output/go_dotplot.pdf",
       height = 12,width = 16,units = "cm") 
