

# run script exploratory_data_analysis
source("exploratory_data_analysis.R")

# lists the coefficients
resultsNames(dds)

# get differentially expressed genes
dds$group <- factor(paste0(dds$tissue, dds$condition))
design(dds) <- ~ group
dds <- DESeq(dds)
resultsNames(dds)

# condition effect for blood
blood_result <- results(dds, contrast=c("group", "bloodinfected", "bloodcontrol"))


# How many genes are differentially expressed (DE) in the pairwise comparison we selected

sig <- blood_result[!is.na(blood_result$padj) & blood_result$padj < 0.05 & abs(blood_result$log2FoldChange) > 1,]
sig #8031
up <- subset(sig, log2FoldChange > 0)
up# 2156
down <- subset(sig, log2FoldChange < 0)
down# 5875

# Gbp2 ENSMUSG00000028270 guanylate binding protein 2
plotCounts(dds, gene = "ENSMUSG00000028270", intgroup = c("tissue", "condition"))

# Themis2 ENSMUSG00000037731 thymocyte selection associated family member 2
plotCounts(dds, gene = "ENSMUSG00000037731", intgroup = c("tissue", "condition"))

