#!/bin/bash

# script is called by dirFeatureCountsEff.sh and runs the individual jobs
# takes its parameters all from dirFeatureCountsEff.sh

# script made by Pieta Schofield, Data Analysis Group, Computational Biology, University of Dundee
# script customised by Remco Stam, Division of Plant Sciences, University of Dundee


source ~/.bash_profile
infiles=${1}
outdir=${2}
annot=${3}
stub=${4}

~/tools/subread-1.4.5-p1-Linux-x86_64/bin/featureCounts   -a ${annot} \
                -t exon \
                -g Phyca11name \
                -T 4 -p -P -C -B\
                -o ${outdir}${stub}.txt ${infiles}
           
