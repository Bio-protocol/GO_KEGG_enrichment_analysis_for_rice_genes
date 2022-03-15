[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

# GO/KEGG Enrichment Analysis on Gene Lists from Rice (Oryza Sativa)

## Overview

This is a workflow for using clusterProfiler to perform GO and KEGG enrichment analysis for gene lists from rice. The gene annotations are the key to these analyses. For GO annotaion, two types of sources are used here: 1. self-curated annotations derived from public rice databases, and 2. GO annotatons from a bioconductor package, AnnotationHub. For KEGG annotation, the gene annotation is directly retrieved from the KEGG database while using the clusterProfiler enrichment function.

## Installation

- __Running environment__: 
    - Part of the the workflow is Bash script that is run on the Linux system (Ubuntu 18.04.5 LTS). The rest are R scripts which are run in RStudio (1.4.1717) on the macOS system.

- __Required R software and versions__: 
    - [clusterProfiler 3.16.1](https://guangchuangyu.github.io/software/clusterProfiler/documentation/)
    - [GO.db 3.11.4](https://bioconductor.org/packages/release/data/annotation/html/GO.db.html)
    - [AnnotationHub 2.20.1](https://bioconductor.org/packages/release/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub.html)
    - [dplyr 1.0.7](https://dplyr.tidyverse.org/)
    - [data.table 1.14.0](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)


## Input Data

1.	Target gene list (genes.txt), background gene list (bkgd.txt, optional but recommended). The gene IDs are the RAP IDs in this protocol, e.g. Os01g0102500, Os01g0106300. See ”input/“ folder.
2.	The gene annotation file obtained from The Rice Annotation Project (RAP) Database (RAP-DB), including both the GO annotation information and RAP gene ID to RAP transcript ID conversion information. [Link](https://rapdb.dna.affrc.go.jp/download/archive/irgsp1/IRGSP-1.0_representative_annotation_2021-11-11.tsv.gz) 
3.	The gene annotation file from the OryzaBase website. [Link](https://shigen.nig.ac.jp/rice/oryzabase/download/gene)
4.	RAP ID to Entrez ID conversion table from the He Lab at Fujian Agriculture and Forestry University, China. [Link](http://bioinformatics.fafu.edu.cn/riceidtable/)


## Major steps

#### Step 1: GO enrichment analysis using annotations from self-curated annotation files

- 1.1 Prepare rice gene GO annotation files using public annotation databases. (Step 1.a in the protocol)

```
sh workflow/1_run_fastqc.sh
```

- 1.2 Prepare self-privided GO annoations for clusterProfiler function. (Step 1.b in the protocol)

```
source("workflow/2_prep_GO_annotation_files.R")
```

- 1.3 Run universal enrichment function, enricher. (Step 1.c and 1.d in the protocol)

```
source("workflow/3_run_enricher.R")
```

#### Step 2: GO enrichment analysis using annotations from AnnotationHub package

```
source("workflow/4_run_enrichGO.R")
```

#### Step 3: KEGG enrichment analysis using annotations from KEGG database

```
source("workflow/5_run_enrichKEGG.R")
```

## Expected results

With the input gene list, twenty-nine GO terms were enriched from the GO enrichment analysis using the self-curated annotation files, while none when using annoations from the AnnotationHub package. And eleven KEGG terms were enriched using the annotation from the KEGG database. The result tables and the visualization dot plots are listed in the /output folder.




## License
It is a free and open source software, licensed under []() (choose a license from the suggested list:  [GPLv3](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/gpl-3.0.txt), [MIT](https://github.com/github/choosealicense.com/blob/gh-pages/LICENSE.md), or [CC BY 4.0](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/cc-by-4.0.txt)).
