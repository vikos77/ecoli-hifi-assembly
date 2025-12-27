#!/bin/bash

# Assembly of PacBio HiFi reads using hifiasm
# Generates assembly graph (GFA) and converts to FASTA format

# Create output directory
mkdir -p ../results/assembly

# Run hifiasm assembler
# -o: output prefix
# -t: number of threads (adjust based on available CPU cores)
echo "Running hifiasm assembly..."
hifiasm -o ../results/assembly/ecoli_hifiasm \
    -t 4 \
    ../data/SRR10971019.fastq

# Check if assembly succeeded
if [ $? -ne 0 ]; then
    echo "Error: hifiasm assembly failed"
    exit 1
fi

echo "Assembly completed"

# Convert GFA to FASTA
# hifiasm outputs multiple files:
# - .bp.p_ctg.gfa = primary contigs (what we want)
# - .bp.hap*.gfa = haplotype-resolved contigs (empty for haploid bacteria)
#
# GFA format has:
# - S lines: contig sequences
# - L lines: links between contigs (topology)
#
# Extract only sequences (S lines) for downstream analysis

echo "Converting GFA to FASTA..."
awk '/^S/{print ">"$2; print $3}' \
    ../results/assembly/ecoli_hifiasm.bp.p_ctg.gfa \
    > ../results/assembly/ecoli_assembly.fasta

# Verify conversion worked
if [ ! -f ../results/assembly/ecoli_assembly.fasta ]; then
    echo "Error: GFA to FASTA conversion failed"
    exit 1
fi

echo "Conversion successful"
echo "Final assembly: ../results/assembly/ecoli_assembly.fasta"
