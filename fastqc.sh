#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=honghong.fang@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/output_fastqc.o    
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/error_fastqc.e
#SBATCH --array=0-31

module add UHTS/Quality_control/fastqc/0.11.9

INPUT_FILES=(/data/courses/rnaseq/toxoplasma_de/reads/*)
OUTPUT_DIR=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/fastqc/

mkdir $OUTPUT_DIR
fastqc --outdir=$OUTPUT_DIR ${INPUT_FILES[$SLURM_ARRAY_TASK_ID]}



