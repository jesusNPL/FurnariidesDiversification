#!/bin/bash -l
#PBS -l walltime=384:00:00,nodes=1:ppn=16,mem=36gb
#PBS -N j
#PBS -m abe
#PBS -M meireles@umn.edu
module load R/3.3.3
module load intel
module load ompi/intel

cd ~/projects/FurDiversification/Scripts/DiversificationRQ_QJ

R --no-save -q < run_analysis_ddd_multiple_trees.R
