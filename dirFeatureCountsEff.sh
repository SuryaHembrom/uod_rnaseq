#!/bin/bash

# script to specify input and output directories, process them for correct naming and call
# runFeatureCountsEff.sh, to run individual jobs on a Uni of Dundee cluster
# script takes three parameters, outputs 4.

# script made by Pieta Schofield, Data Analysis Group, Computational Biology, University of Dundee
# script customised by Remco Stam, Division of Plant Sciences, University of Dundee



usage()
{
cat << EOF
  usage: ${0} options

	Run featureCounts on a directory with directories with bamfiles runFeaturecounts.sh

  OPTIONS:
     -d     Directory to SAM files
     -a 	gff file
     -o 	outdir 
     -h     Show this message 
EOF
}

indir=
outdir=
while getopts ":a:o:i:h" opt; do
  case ${opt} in
  i)
    indir=${OPTARG} ;;
  a)
    annot=${OPTARG} ;;
  o)
    outdir=${OPTARG} ;;
  h)
    usage
		exit 0 ;;
  ?)
		usage
		exit 1 ;;
	esac
done


if [[ -z indir ]]; then
  echo "${feat}"
  usage
  exit 1
fi



for _f in ${indir}24*.sam; do #selects only the bam files or sam files
    infiles=$(echo ${_f})
    echo "These will be the filenames for input" $infiles
    echo "All results will be written to" $outdir
    stub=$(echo ${_f} | rev | cut -d/ -f1 | cut -d. -f2,3 | rev )
    echo "Output files will be named" $stub    
    echo "This will be the annotation we use" $annot
    script="~/tools/bash/runFeatureCountsEff.sh"
    echo $script
  	qsub -pe smp 4 -b yes -l ram=4000 -o ${LOGS} -e ${LOGS} ${script} ${infiles} ${outdir} ${annot} ${stub} 
done

