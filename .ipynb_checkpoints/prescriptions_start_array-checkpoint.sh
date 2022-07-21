#!/bin/bash

# get files
DATA=/scratch/jhm3ab/antibiotic_bii/RX_data/UVA_RX_Claims_2020
IFS=$'\n'
export FILES=($(ls $DATA/*.txt))

# using zero-based indexing  Lastindex = # of files - 1
LASTINDEX=$((${#FILES[@]} - 1))
echo "Found ${#FILES[@]} files"

# at least 1 file, submit job
if [ $LASTINDEX -ge 0 ]; then
    sbatch --array=0-$LASTINDEX construct_prescriptions.slurm
fi
