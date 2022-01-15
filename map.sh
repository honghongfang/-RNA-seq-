#!/bin/bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00
#SBATCH --job-name=mapping
#SBATCH --mail-user=honghong.fang@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/map/output_%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/map/error_%j.e

sample=$1
module add UHTS/Aligner/hisat/2.2.1
read_1=/data/courses/rnaseq/toxoplasma_de/reads/${sample}_1.fastq.gz
read_2=/data/courses/rnaseq/toxoplasma_de/reads/${sample}_2.fastq.gz

INDEX=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/index/Mus_musculus.GRCm39

OUT_DIR=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/map/

hisat2 -p 4 --rna-strandness RF -x ${INDEX} -1 ${read_1} -2 ${read_2} -S ${OUT_DIR}${sample}.sam


