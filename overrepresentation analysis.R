
source("differential_expression_analysis.R")
# install and load libraries
if (!requireNamespace("BiocManager", quiet = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")
BiocManager::install("org.Mm.eg.db")
library(clusterProfiler)
library(org.Mm.eg.db)
library(enrichplot)

genes <- row.names(sig)
universe <- row.names(blood_result)

ego <- clusterProfiler::enrichGO( gene          = genes,
                                  universe      = universe,
                                  OrgDb         = org.Mm.eg.db,
                                  ont           = "BP", # biological process
                                  pAdjustMethod = "BH",
                                  pvalueCutoff  = 0.01,
                                  qvalueCutoff  = 0.05,
                                  readable      = TRUE,
                                  keyType       = 'ENSEMBL')
#library(enrichplot)
#goplot(ego)
dotplot(ego, showCategory=20)



# we want the log2 fold change 
original_gene_list <- df$log2FoldChange

# name the vector
names(original_gene_list) <- df$X

# omit any NA values 
gene_list<-na.omit(original_gene_list)

# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)
#Gene Set Enrichment
keytypes(org.Mm.eg.db)

gse <- gseGO(geneList=gene_list,
             universe = df2$ens_gene_id,
             ont ="BP", 
             keyType = "ENSEMBL", 
             nPerm = 10000, 
             minGSSize = 3, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = org.Mm.eg.db, 
             pAdjustMethod = "none")
#Output
require(DOSE)
dotplot(gse, showCategory=10, split=".sign") + facet_grid(.~.sign)


