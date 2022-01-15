# Install these packages
if (!requireNamespace("BiocManager", quiet = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

library(DESeq2)
library(RColorBrewer)
# Read adjusted file resulting from featureCounts.txt
counts <- read.table('featurecounts.txt', sep = "\t", header = TRUE)
counts_matrix <- as.matrix(counts)
rm(counts)
# delete columns that we don't need
counts_matrix <- counts_matrix[, -c(2, 3, 4, 5, 6)]

# transforming first column in row labels to rowname
rownames(counts_matrix) <- counts_matrix[,1]
counts_matrix <- counts_matrix[, -1]
#transforming value of matrix into numeric
class(counts_matrix) <- "numeric"

# Simplifying colnames of the counts_matrix
for ( col in 1:ncol(count_matrix)){
  colnames(counts_matrix)[col] <-  sub("X.data.courses.rnaseq.toxoplasma_de.hhf_workspace.map.", "", colnames(counts_matrix)[col], fixed = TRUE)
  colnames(counts_matrix)[col] <-  sub(".sorted.bam", "", colnames(counts_matrix)[col], fixed = TRUE)
}

# create coldata matrix
samples <- colnames(counts_matrix)

condition <- c("infected", "infected", "infected", "infected", "infected","control", "control", "control",
               "infected", "infected", "infected", "infected", "infected","control", "control", "control")

tissue <- c("lung", "lung", "lung", "lung", "lung", "lung", "lung", "lung",
            "blood", "blood", "blood", "blood", "blood", "blood", "blood","blood")

coldata <- cbind(samples, condition, tissue)

rownames(coldata) <- coldata[,1]
coldata <- coldata[, -1]

# create DESeq object
dds <- DESeqDataSetFromMatrix(countData = counts_matrix,colData = coldata,design = ~ condition + tissue)

# run DESeq
dds <- DESeq(dds)
# to remove the dependence of the variance on the mean variance stabilizing transformations (VST)
vsd <- vst(dds, blind=TRUE)
# PCA
print(plotPCA(vsd, intgroup=c("condition", "tissue")))

# heatmap
#install.packages('pheatmap')
library('pheatmap')
# colors of the heat map
hmcolor <- colorRampPalette(brewer.pal(9, "Blues"))(100)
ann_color = list(condition = c(infected = "yellow", control = "yellow4"),
                  tissue = c(lung = "orchid", blood = "orchid4"))

select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:20]

df <- as.data.frame(colData(dds)[,c("condition","tissue")])
#plot
pheatmap(assay(vsd)[select,], color = hmcolor, border_color = NA,cluster_rows=FALSE, 
         cluster_cols=FALSE,annotation_col=df, annotation_colors = ann_color,show_rownames = TRUE)


