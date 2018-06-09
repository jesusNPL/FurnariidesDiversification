#!/bin/bash -l
#PBS -l walltime=4:00:00,nodes=1:ppn=4,mem=12gb
#PBS -N j
#PBS -m abe
#PBS -M meireles@umn.edu
module load R/3.3.3
module load intel
module load ompi/intel

cd ~/projects/FurDiversification/DiversificationRQ_QJ

R --no-save -q < R/runAnalysis.R
