This project has focused on searching for adaptations to increased level of dissolved oxygen in Baikal Amphipods using genea expression data.

Under the project the following tasks were resolved :
* Search for sequences of antioxidant enzymes of Crustacean in data bases (Uniprot[1],NCBI[2])
* Search for transcripts with homology to these enzymes in transcriptome assemblies of three Amphipodes.Two of these species, Eulimnogammarus verrucosus and E. cyaneus, are endemic to Lake Baikal, while Gammarus lacustris is a potential invader.
* Alignment of raw transcriptome reads on the reference transcriptome assemblies for three species and further transcript quantification.
* Establishment of phylogenetic links between selected transcripts and protein base of antioxidant enzymes.

In the beginning ORFs extraction from transcripts has implemented with help of TransDecoderv5.0[3] and then we have undertaken Blastp[4] search for this ORFs using previously found protein sequences from Uniprot and NCBI as a base. After that, Trinity scripts[5]were used for raw transcriptome reads alignment and quantification. Bowtie 2[6] aligner was used for alignment and RSEM[7] tool was used for transcript quantification inside of trinity script. To determine orthologs for selected transcripts in other species Proteinortho[8] tool was used and pipeline which has included PRANK[9] tool for alighnment, TrimAL[10] for gap trimming and IQtree[11] for tree building.



1. https://www.uniprot.org/
2. https://www.ncbi.nlm.nih.gov/protein/
3. Haas & Papanicolaou et al., manuscript in prep.  http://transdecoder.github.io
4. Gish, W. & States, D.J. (1993) "Identification of protein coding regions by database similarity search." Nature Genet. 3:266-272. PubMed
5. https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Transcript-Quantification
6. Langmead B, Salzberg SL. Fast gapped-read alignment with Bowtie 2. Nat Methods. 2012;9(4):357–359. Published 2012 Mar 4. doi:10.1038/nmeth.1923
7. Li, B., Dewey, C.N. RSEM: accurate transcript quantification from RNA-Seq data with or without a reference genome. BMC Bioinformatics 12, 323 (2011). https://doi.org/10.1186/1471-2105-12-323
8. Lechner et al (2011). Proteinortho: Detection of (Co-)Orthologs in Large-Scale Analysis. BMC Bioinformatics 2011 Apr 28;12(1):124.
9. Löytynoja, Ari. (2014). Phylogeny-aware alignment with PRANK. Methods in molecular biology (Clifton, N.J.). 1079. 155-70. 10.1007/978-1-62703-646-7_10. 
10. trimAl: a tool for automated alignment trimming in large-scale phylogenetic analyses.
Salvador Capella-Gutierrez; Jose M. Silla-Martinez; Toni Gabaldon. Bioinformatics 2009 25: 1972-1973.
11. Nguyen LT, Schmidt HA, von Haeseler A, Minh BQ. IQ-TREE: a fast and effective stochastic algorithm for estimating maximum-likelihood phylogenies. Mol Biol Evol. 2015;32(1):268–274. doi:10.1093/molbev/msu300



The main scripts in this repository is "Oxygen.sh"

For launching this script you need to have pre-installed further software:
* Python3
* TrimAl v
* RSEM v
* IQtree v
* TransDecoder v
* Blast v
* Bowtie v

You should also have folders that contain the following scripts:
* 
*




Three main elements must be placed in the folder where you want to launch script : 
1) Folder with transcriptome assemblies ( in our case - assemblies for G.lacustris, E.verrucosus and E.cyaneus)
2) File 'result.fasta' where protein sequences of related species for protein family of interest are placed
3) Folder rsem_results where you should place results of estimate_abundance.sh script work

You also should place in your folder next files: 
Substrings_1.py
dash_remover.py
inner_extract.py
choise.py
change_name.py

They are necessary for the proper work of the script.

---optional---

You can also add file for_outgroup.fasta if you want to make outgroup in your tree. This file should contain one or several protein sequences from the same protein family
In this script we use such tools like TransDecoder, trimal, iqtree, prank, RSEM and express. If they are NOT in your PATH please use parameter "-e"  


---Results---

As a result of the script's launch you will have 4 main files:
1)data.tsv - table with expression estimation for all transcripts which was chosen like probably coding homologues of protein family of interest
2)trimmed_after_prank_modified.iqtree - file where you can see ypur tree right in the terminal
3)trimmed_after_prank_modified.treefile - tree in Newick format. This file can be visualised with the help of
ggtree package in RStudio. Example code is placed in script_for_tree.R file
4)myproject.proteinortho-graph - file with pairs of ortologues in the selected transcripts



