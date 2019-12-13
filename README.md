The main scripts in this repository is "Oxygen.sh"


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



