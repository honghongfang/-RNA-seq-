#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=03:00:00
#SBATCH --job-name=index
#SBATCH --mail-user=honghong.fang@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/index/outputs_errors/output_%j.o
#SBATCH --error=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/index/outputs_errors/error_%j.e

mkdir outputs_errors
module add UHTS/Aligner/hisat/2.2.1

INPUT_DIR=/data/courses/rnaseq/toxoplasma_de/genome/Mus_musculus.GRCm39.dna.primary_assembly.fa
OUTPUT_DIR=/data/courses/rnaseq/toxoplasma_de/hhf_workspace/index/Mus_musculus.GRCm39

hisat2-build ${INPUT_DIR} ${OUTPUT_DIR}


