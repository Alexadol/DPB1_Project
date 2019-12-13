#!/bin/bash

PATH_TO_REF="../tsa/GHHK01.1.fsa_nt"
PATH_TO_READS="/media/tertiary/transcriptome_raw/Eulimnogammarus_verrucosus"
METHOD=eXpress

while (( "$#" )); do
  case "$1" in
    -e|--export_paths)
      shift 1
      PATH=$PATH:/media/secondary/apps/TransDecoder-TransDecoder-v5.5.0
      export PATH
      PATH=$PATH:/media/secondary/apps/RSEM-1.3.0
      export PATH
      PATH=$PATH:/media/secondary/apps/trinityrnaseq-Trinity-v2.4.0/util
      export PATH
      PATH=$PATH:/media/secondary/apps/express-1.5.1-linux_x86_64
      export PATH
      ;;
    -r|--path_to_reads)
      FARG=$2
      shift 2
      PATH_TO_READS=$FARG
      ;;
    -p|--path_to_ref)
      FARG=$2
      shift 2
      PATH_TO_REF=$FARG
      ;;
    -m|--method)
      FARG=$2
      shift 2
      METHOD=$FARG
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

for sample in $PATH_TO_READS; do
  align_and_estimate_abundance.pl --transcripts $PATH_TO_REF --seqType fq --left $sample/${sample##*/}._R1.fastq.gz --right $sample/${sample##*/}._R2.fastq.gz --est_method $METHOD --aln_method bowtie --prep_reference --output_dir result/${sample##*/}
done
