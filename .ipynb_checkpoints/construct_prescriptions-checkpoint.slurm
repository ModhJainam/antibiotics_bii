#!/bin/bash
#SBATCH -A biocomplexity		# account
#SBATCH -p bii # partition/queue
#SBATCH --nodes=1		# number of compute nodes
#SBATCH --ntasks=1		# number of program instances
#SBATCH --cpus-per-task=8       # use 1 cpu core
#SBATCH --time=12:00:00		# max time before job cancels
#SBATCH --mem=64GB               # memory

module purge
module load anaconda/2020.11-py3.8

DATA=/scratch/jhm3ab/antibiotic_bii/RX_data/UVA_RX_Claims_2020
OUTDIR=/scratch/$USER/antibiotic_bii/prescriptions_data/UVA_prescriptions_2020
mkdir -p $OUTDIR


# get files
IFS=$'\n'
FILES=($(ls $DATA/*.txt))
# pick single file from FILES array
FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
echo "Processing file $FILE"
FILENAME=$(basename $FILE)
python construct_prescriptions.py $FILE $OUTDIR/prescriptions_$FILENAME
