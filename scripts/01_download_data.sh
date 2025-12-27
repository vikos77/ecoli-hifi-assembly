#!/bin/bash

# Download PacBio HiFi E. coli dataset from SRA
# Dataset: SRR10971019 (~3 GB)
# Expected output: SRR10971019.fastq in data/ directory

# Using fasterq-dump (faster than fastq-dump)
fastq-dump SRR10971019 --outdir ../data/

# Verify download completed
if [ -f ../data/SRR10971019.fastq ]; then
    echo "Download successful"
    ls -lh ../data/SRR10971019.fastq
else
    echo "Download failed"
    exit 1
fi
