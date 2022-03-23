##Step 1.3 Run universal enrichment function, enricher. (Step 1.c and 1.d in the protocol)

## R
## read gene lists and annotation files
# genes of interest
genes <- read.table("input/genes.txt", header=T)
genes <- genes[[1]]
# background genes
bkgd <- read.table("input/bkgd.txt", header=T)
bkgd <- bkgd[[1]]

# TERM2GENE
term2gene <- read.table("cache/goid2gene_BP.txt", sep="\t", header=T, quote="", stringsAsFactors = F) #change dir
# TERM2NAME
term2name <- read.table("cache/godb_BP.txt", sep="\t", header=T, quote="", stringsAsFactors = F) #change dir

## R
## run the universal enrichment function, enricher
library(clusterProfiler) #library
go <- enricher(gene = genes, # a vector of gene id
               universe = bkgd, # background genes
               TERM2GENE = term2gene, # user input annotation of TERM TO GENE mapping 
               TERM2NAME = term2name # user input of TERM TO NAME mapping
               )

## save results
go_df <- as.data.frame(go)
write.table(go_df, "output/go_df.txt", sep="\t", row.names=FALSE, quote=FALSE)

## dot plot
library(ggplot2) #library
p1 <- dotplot(go, showCategory=10)
ggsave(p1,
       filename = "figures/go_dotplot.pdf",
       height = 12,width = 16,units = "cm") #change dir
