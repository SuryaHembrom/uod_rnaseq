##The aim of this script is to extract seq from a fasta file and create a new fasta file
##Script is based on a script by Gaetan Thilliez (PS, Uni of Dundee)
##Amended to take gene names and cluster information from a tabulated file and extract each cluster from a large fasta file with upstream sequences
##In this particular case, the table contains all DEGs from RNASeq, with cluster indication and the script writes out a fasta for each cluster

def ExtractFastaSeq (List, Fasta):
    """List must be a path to a list of name ,matching the names in the Fasta
    Fasta is a path to a Fasta file, sequences from fasta will be extracted if they are in the List
    output is a path to an output file that will be created"""
    from Bio import SeqIO 
    FastaFh=open(Fasta)
    Fh = open(List)
    SeqDict = {}
    for cluster, names, nil, four, eight, sixteen, twentyfour in [l.strip().split("\t") for l in Fh.readlines()]:
		SeqDict[names] = cluster
    print SeqDict #gives a dictionary with all names as keys and all clusters as values
    
    # now loop over the dictionary for each value and the write out fasta file with each key
    # in the correct file
    
    
    for i in range(11): #(max(SeqDict.values())
    	FastaFh.seek(0)
    	Towrite=[seq 
    		for seq in SeqIO.parse(FastaFh,'fasta')
    			if seq.name in SeqDict.keys()
    				if str(i) == SeqDict.get(seq.name)]
    	
    	with open('Clusters_%i.txt' %i, 'w') as f:
        
        	SeqIO.write(Towrite, f, 'fasta')
        	print '%s sequences found'%(len(Towrite))
    		print '%s sequences missing'%(len(SeqDict.keys())-len(Towrite))
    
    	

List='exp_clusters.txt'
Fasta='Phyca11_effector_up2.fasta'

ExtractFastaSeq(List, Fasta)
