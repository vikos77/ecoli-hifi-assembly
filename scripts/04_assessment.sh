#!/bin/bash

#This is an assessment code to check the contig assembly and analyse how well the contig has been assembled based on the read quality

#Step 1

mkdir ../results/quast_report

#We use quast tool to analyse the assembled data 
quast.py ../results/assembly/ecoli_assembly.fasta -o ../results/quast_report/quast_results

#Quast gives the statistical data of the contig assembled such as N50 and L50 along with the GC content which could be used to infer the
# quality of the assembly

#Step 2

busco -i ecoli_assembly.fasta \
	-l bacteria_odb10 \
	-o busco_results \
	-m genome
