#!/bin/bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=featureCounts
#SBATCH --mail-user=honghong.fang@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/featurecounts/output_%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/featurecounts/error_%j.e


ANNOTATION=/data/courses/rnaseq/toxoplasma_de/annotation/Mus_musculus.GRCm39.104.gtf
OUTPUT=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/featurecounts/featurecounts.txt
BAM_FILES=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/map/*.sorted.bam

module add UHTS/Analysis/subread/2.0.1

featureCounts -p -s 2 -a $ANNOTATION -o $OUTPUT $BAM_FILES 


