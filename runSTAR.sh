#!/bin/bash
# script is called by dirSTAR.sh and runs the individual alignment jobs
# takes its parameters all from dirSTAR.sh

# script made by Pieta Schofield, Data Analysis Group, Computational Biology, University of Dundee
# script customised by Remco Stam, Division of Plant Sciences, University of Dundee

source .bash_profile
indir=${1}
outdir=${2}
stub=${3}
index=${4}
subdir=${5}
subname=${6}

cd ${outdir}

/sw/bin/star --genomeDir ${index} \
     --runThreadN 8 \
     --genomeLoad LoadAndRemove --outSAMmode Full \
     --outFilterMultimapNmax 2 --outFilterMismatchNmax 5 \
     --outFilterType BySJout --outSJfilterIntronMaxVsReadN 5000 10000 15000 20000 \
     --outFileNamePrefix ${subdir} --readFilesCommand zcat \
	 --readFilesIn ${indir}/${subdir}/${stub}_R1_001.fastq.gz ${indir}/${subdir}/${stub}_R2_001.fastq.gz 
