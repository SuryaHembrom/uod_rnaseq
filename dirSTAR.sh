#/bin/bash

# script to specify input and output directories, process them for correct naming and call
# runSTAR.sh, to run individual alignment jobs on a Uni of Dundee cluster
# script takes three parameters, outputs 6.

# script made by Pieta Schofield, Data Analysis Group, Computational Biology, University of Dundee
# script customised by Remco Stam, Division of Plant Sciences, University of Dundee



usage()
{
cat << EOF
  usage: ${0} options

  This script runs STAR on a directory of paired end illumina fastq files.
  requirements are files are zipped and tgged _R1.fq.gz and _R2.fq.gz

	-o  output directory
	-i  index
	-f  fasta file directory
	-h  show this message 
EOF
}

indir=
outdir=
cores=8
while getopts "f:o:i:h:" opt; do
  case ${opt} in
	f)
    indir=${OPTARG};;
	i)
    index=${OPTARG};;
	o)
    outdir=${OPTARG};;
	
  h)
		usage
		exit;;
	?)
		usage
		exit;;
  esac
done

if [ -z ${indir} ]; then
	usage
	exit
fi 

for _d in ${indir}/14_11_PC-T_24*/; do #prefix M selects only one subdir to run. 
  for _f in ${_d}/*gz; do #selects only the gz files
    if test -a ${_f} ; then
      listfiles="${_f}"
      script="~/path/to/runSTAR.sh"
      reid=$(echo ${_f} | rev | cut -d/ -f1 | cut -d_ -f2 | rev | cut -d. -f1 )
      #echo ${reid}
      if [ ${reid} == "R1" ]; then
        stub=$(echo ${_f} | rev | cut -d/ -f1 | cut -d_ -f3,4,5,6,7 | rev )
        subdir=$(echo ${_f} | cut -d/ -f6)
        subname=$(echo $subdir | cut -d_ -f3,4) #-f1,2 for M&GC -f3,4 for rest
    	echo "File location:" ${indir}/${subdir}/${stub}_R2_001.fastq.gz
        echo "Index:" ${index} 
        echo "Outfile:" ${outdir}${subname}.${stub}.bam
        echo $subdir
        echo $subname
        qsub -clear -o ${LOGS} -e ${LOGS} -b y -pe smp 8 -R yes \
        -m a ${script} \
		  ${indir} ${outdir} ${stub} ${index} ${subdir} ${subname}
      fi
    fi
  done
done



#22_8_PC-T_4hLog.progress.out
