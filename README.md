uod_rnaseq
==========

RNASeq read mapping of p capsici infected tomato leaves, clustering and motif identification

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
Follow up in `R` scripts 1,2 and 3. `R Markdown` files can be found at http://www.compbio.dundee.ac.uk/user/rstam/internal/R_markdown/

#####Clustering and Heatmaps
`edgeR` produces a table with differentially expressed genes. These genes can be clustered using `hclust` and a heatmap can be drawn using `heatmap2`. These analyses are described in R script 4. `R Markdown` files are again [here](http://www.compbio.dundee.ac.uk/user/rstam/internal/R_markdown/).
`R` script also extracts lists with DEGs and a table with for each gene indicated in which cluster it sits

#####Extracting upstream sequences and motif finding
Take GFF file with effectors, amend start and stop positions using `amend_gff2.py` (add/subtract 1000)
Manually change the resulting gff to a simplified bed file and run `bedtools` to extract upstream sequences.
```bash
bedtools getfasta -s -name -fi Phyca11_unmasked_genomic_scaffolds.fa -bed 141027_Phyca11_effector_Up.bed -fo stdout | fold -w 60 > Phyca11_effector_up.fasta
```

#####Search for motifs using HOMER
Required: exp-clusters file with cluster indicated for each gene

Run `extract_cluster_sequences.py` to make fasta files for each cluster

Run `create_subset.py` to make a single subset for all DEGs (as BG)

Run `FilterFasta.py` to remove foreground from background sets

Run `Runhomer.sh` to run `HOMER` with default settings on each cluster and background set.

