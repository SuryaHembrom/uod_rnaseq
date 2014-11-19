uod_rnaseq
==========

RNASeq read mapping of p capsici infected tomato leaves

These analyses were done using STAR2.4. 
Genomic databases are ITAG2.4 and Phyca11. Both were donwloaded from their original source and deposited in a single directory.

The following commands were executed to create the genomic index file and run the analysis. The shell scripts that were called are included in the supplementary data. 
Path names need to be customised to the correct path

#####Create index
```bash
./STAR --runMode genomeGenerate --genomeDir ~/star_indices --genomeFastaFiles /path/to/genome/databases/ITAG2.4_genomic.fasta /path/to/genome/databases/Phyca11_unmasked_scaffold.fasta --runThreadN 32
```
#####Run STAR 
```bash
./dirSTAR.sh -f /part/to/raw_reads/GSU_JP_TomatoPcapsici -i ~/star_indices/ -o ~/OUTPUT_STAR/
```

#####Run featureCounts
```bash
./dirFeatureCountsEff.sh -i ~/OUTPUT_STAR/ -o ~/OUTPUT_FC/ -a /path/to/genome/databases/PhycaEff_manual.gtf
```

#####Differential gene expression analysis
featureCounts generates read count tables and summary statistics that can be analysed in R, using `edgeR`.
Follow up in `R` scripts. `R Markdown` files can be found at http://www.compbio.dundee.ac.uk/user/rstam/internal/

#####Clustering and Heatmaps
`edgeR` produces a table with differentially expressed genes. These genes can be clustered using `hclust` and a heatmap can be drawn using `heatmap2`. These analyses are described in scripts XXXXXX. `R Markdown` files are again [here](http://www.compbio.dundee.ac.uk/user/rstam/internal/).



