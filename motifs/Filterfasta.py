##The aim of this script is to extract seq from a fasta file and create a new fasta file
##Script is based on a script by Gaetan Thilliez (PS, Uni of Dundee)
##Amended to gene names for each cluster from a tabulated file and subtract these names from a large fasta file with upstream sequences
##In this particular case, the table contains cluster information for all DEGs from RNASeq and the script writes out a fasta all DEGs minus cluster n

def FilterFastaSeq (List, Fasta):
    """Start with a file that lists all the gene names per cluster and other attributes
    and a file that contains all the DEG upstream regions. 
    Read the gene names from the list and remove these genes from the fasta file"""
    
    from Bio import SeqIO 
    FastaFh=open(Fasta)
    Fh = open(List)
    SeqDict = {}
    for cluster, names, nil, four, eight, sixteen, twentyfour in [l.strip().split("\t") for l in Fh.readlines()]:
		SeqDict[names] = cluster
    print SeqDict #gives a dictionary with all names as keys and all clusters as values
    print "There are this many genes in the upstream file: "+str(len(SeqDict))
  
    # now loop over the dictionary for each value and the write out fasta file with each key
    # in the correct file
    
    
    for i in range(11): #(max(SeqDict.values())
    	FastaFh.seek(0)
    	Towrite=[seq 
    		for seq in SeqIO.parse(FastaFh,'fasta')
    			if seq.name in SeqDict.keys()    					
    				if str(i) != SeqDict.get(seq.name)]
    
    	
    	with open('RNASeq_DEG_Up_minus_Clusters_%i.txt' %i, 'w') as f:
        	SeqIO.write(Towrite, f, 'fasta')
    		print '%s Is also the number that is in the dictionary'%(len(SeqDict.keys()))
    		print '%s sequences will be written out if the cluster is subtracted'%(len(Towrite))
 
 
List='exp_clusters.txt' #file with cluster numbers and names
Fasta='RNASeq_DEG_Upstream.fasta'#file with all DEG upstream regions
   	

	
FilterFastaSeq(List, Fasta)
