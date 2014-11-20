#!/bin/bash
FILES=Clusters_*.txt


for file in $FILES; do
#	dir="${file##/}"
#	dir="${dir%.$ext}" 
	dname="$(basename "$file" .txt)"
	echo "Doing homer for $file in directory [$dname]"
	echo "RNASeq_DEG_Up_minus_$dname.txt"
	perl /Users/rstam/homer/bin/findMotifs.pl $file fasta $dname -fasta RNASeq_DEG_Up_minus_$dname.txt -len 8,10
	
done
	
	