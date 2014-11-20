##The aim of this script is to extract seq from a fasta file and create a new fasta file
##Script is based on a script by Gaetan Thilliez (PS, Uni of Dundee)
##Amended to take all gene names from a tabulated file and extract all these names from a large fasta file with upstream sequences
##In this particular case, the table contains all DEGs from RNASeq and the script writes out a fasta with these DEG.



def ExtractFastaSeq (List, Fasta):
    """List must be a path to a list of name ,matching the names in the Fasta
    Fasta is a path to a Fasta file, sequences from fasta will be extracted if they are in the List
    output is a path to an output file that will be created"""
    from Bio import SeqIO 
    FastaFh=open(Fasta)
    Fh = open(List)
    SeqList = []
    for cluster, names, nil, four, eight, sixteen, twentyfour in [l.strip().split("\t") for l in Fh.readlines()]:
		SeqList.append(names)
    print SeqList #gives a dictionary with all names as keys and all clusters as values
    
    
    # now loop write out the sequence for each fasta
    Towrite=[seq for seq in SeqIO.parse(FastaFh,'fasta')
    			if seq.name in SeqList]
    with open('RNASeq_DEG_Upstream.fasta', 'w') as f:
        SeqIO.write(Towrite, f, 'fasta')
        print '%s sequences added to fasta'%(len(Towrite))
    	print '%s sequences missing'%(len(SeqList)-len(Towrite))
    
    	

List='exp_clusters.txt'
Fasta='Phyca11_effector_up2.fasta'

ExtractFastaSeq(List, Fasta)
