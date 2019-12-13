#!/bin/bash

#paths to the three main elemets for script launch : folder with transcriptome assemblies(tsa),folser with results of RSEM script(rsem_results), file with data base protein sequences(result.fasta)

PATH_TO_PROT=./result.fasta
PATH_TO_REF="./tsa/*"
PATH_TO_EXPRESS="./rsem_results/*"

#These programs should be added to PATH for successful running 
while (( "$#" )); do
  case "$1" in
    -e|--export-paths)
      shift 1
      PATH=$PATH:/media/secondary/apps/TransDecoder-TransDecoder-v5.5.0/
      export PATH
      PATH=$PATH:/media/secondary/apps/RSEM-1.3.0
      export PATH
      PATH=$PATH:/media/secondary/apps/trinityrnaseq-Trinity-v2.4.0/util
      export PATH
      PATH=$PATH:/media/secondary/apps/trimal/source/
      export PATH
      PATH=$PATH:/media/secondary/apps/iqtree-1.6.10-Linux/bin/
      export PATH
      PATH=$PATH:/media/secondary/apps/express-1.5.1-linux_x86_64
      export PATH
      ;;
    -c|--choose-proteins)
      shift 1
      python3 choise.py
      ;;
    -p|--protein_fasta)
      FARG=$2
      shift 2
      PATH_TO_PROT=$FARG
      ;;
    -r|--reference)
      FARG=$2
      shift 2
      PATH_TO_REF=$FARG
      ;;
    -x|--express)
      FARG=$2
      shift 2
      PATH_TO_EXPRESS=$FARG
    ;;
    -h|--help)
      shift 1
      cat README.md
      exit 0
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

#extracting ORFs from transcriptome assemblies and blastp for all of these peptides against data base
makeblastdb -in $PATH_TO_PROT -dbtype prot

for REF in $PATH_TO_REF; do
  echo $REF
  TransDecoder.LongOrfs -t $REF -m 50
  blastp -query ${REF##*/}.transdecoder_dir/longest_orfs.pep -db $PATH_TO_PROT -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 10 > ${REF##*/}.blastp.outfmt6
  echo ok
done

#Extracting id-s after blastp for further peptide sequences extracting from longest_orf.pep files (corresponding to three species)
for REF in $PATH_TO_REF; do
  cat ${REF##*/}.blastp.outfmt6 | cut -f 1 > ${REF##*/}.pep_id
  grep -A1 -f ${REF##*/}.pep_id ${REF##*/}.transdecoder_dir/longest_orfs.pep > ${REF##*/}.pep_seq
  echo ok
done

#Script Substring_1.py was created for checking the presence of sequences which are the part of another one
#Names of sequences  return when such problem has taken place
#Script dash_remover.py is exploited for removing lines '--' which separate sequences in longest_orf.pep files 
for REF in $PATH_TO_REF; do
  python3 Substrings_1.py ${REF##*/}.pep_seq
  python3 dash_remover.py ${REF##*/}.pep_seq
  echo OK
done

/media/secondary/apps/proteinortho_v5.16b/proteinortho5.pl *.pep_seq
#concatenation of peptide sequences from three species in one file peps_with_db.fasta and data base proteins adding
cat *.pep_seq $PATH_TO_PROT > peps_with_db.fasta

#Adding fasta file with sequnces for outgroup
#It can be missing if you don't need this step 
cat for_outgroup.fasta peps_with_db.fasta > peps_with_db_with_out.fasta

#Prank software is used for alignment
prank peps_with_db_with_out.fasta

#trimal tool is exploited for the automated removal of poorly aligned regions
trimal -in output.best.fas -out trimmed_after_prank -noallgaps

#Script change_name.py  was created for transcripts' names correction for future tree
python3  change_name.py trimmed_after_prank

#iqtree tool is used for tree building. Built-in tool ModelFinder is used for choosing the best model
iqtree -s trimmed_after_prank_modified -abayes

cat ./*.outfmt6 | cut -f 1 | rev | cut -c4- | rev | sort -u > gene_set

for EXP in $PATH_TO_EXPRESS; do
  python3 inner_extract.py $EXP
done

cat ./*_extracted > data.tsv

