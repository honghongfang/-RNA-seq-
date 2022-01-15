#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=bam_index
#SBATCH --mail-user=honghong.fang@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/bam_index/output_%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/bam_index/error_%j.e
#SBATCH --array=0-3

SAMPLES=("$@")
module add UHTS/Analysis/samtools/1.10

SORTED_BAM_FILE=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/map/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sorted.bam
samtools index ${SORTED_BAM_FILE}


