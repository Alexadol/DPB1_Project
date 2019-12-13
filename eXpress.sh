#!/bin/bash

mkdir result

estimate_abundance.sh --export_paths --path_to_reads "/media/tertiary/transcriptome_raw/Eulimnogammarus_verrucosus/Sample_EveB*" --path_to_ref "../tsa/GHHK01.1.fsa_nt" --method eXpress
estimate_abundance.sh --export_paths --path_to_reads "/media/tertiary/transcriptome_raw/Gammarus_lacustris/Sample_GlaB*" --path_to_ref "../tsa/GHHU01.1.fsa_nt" --method eXpress
estimate_abundance.sh --export_paths --path_to_reads "/media/tertiary/transcriptome_raw/Eulimnogammarus_cyaneus/Sample_Ecyb*" --path_to_ref "../tsa/GHHW01.1.fsa_nt" --method eXpress

echo ok