import re
import json
from Bio import SeqIO

with open('config.json', 'r') as conf:
    config = json.load(conf)

path_to_fasta = config['config']['choise']['path_to_protein_file']

species_pattern = r'OS=.*OX'
type_pattern = r' .*OS='

species_d = {}
type_d = {}
for record in SeqIO.parse(path_to_fasta, "fasta"):
    if 'Fragment' not in record.description:
        if re.search(species_pattern, record.description).group(0)[3:-3] not in species_d:
            species_d[re.search(species_pattern, record.description).group(0)[3:-3]] = []
        species_d[re.search(species_pattern, record.description).group(0)[3:-3]].append(record)
        if re.search(type_pattern, record.description).group(0)[:-3] not in type_d:
            type_d[re.search(type_pattern, record.description).group(0)[:-3]] = []
        type_d[re.search(type_pattern, record.description).group(0)[:-3]].append(record)

with open('protein_by_species.tsv', 'w') as sbs:
    sbs.write('species\tnumber_of_proteins\tprotein_with_max_len\tmax_length\n')
    for key in species_d:
        sbs.write(key + '\t' + str(len(species_d[key])) + '\t')
        sbs.write(max(species_d[key], key=lambda x: len(x.seq)).id + '\t' + str(
            len(max(species_d[key], key=lambda x: len(x.seq)).seq)) + '\n')

with open('protein_by_type.tsv', 'w') as sbm:
    sbm.write('type\tnumber_of_proteins\tprotein_with_max_len\tmax_length\n')
    for key in type_d:
        sbm.write(key + '\t' + str(len(type_d[key])) + '\t')
        sbm.write(max(type_d[key], key=lambda x: len(x.seq)).id + '\t' + str(
            len(max(type_d[key], key=lambda x: len(x.seq)).seq)) + '\n')

write_type = config['config']['choise']['write_out_selected']

ok = []
if write_type == 'species':
    for key in species_d:
        one = max(species_d[key], key=lambda x: len(x.seq)).id
        ok.append(one.split('|')[1])
elif write_type == 'type':
    for key in type_d:
        one = max(type_d[key], key=lambda x: len(x.seq)).id
        ok.append(one.split('|')[1])
elif write_type == 'custom':
    ok = config['config']['choise']['custom_list']

sequences = []

for i in ok:
    for record in SeqIO.parse("uniprot-superoxide+dismutase+crustacea.fasta", "fasta"):
        if i in record.id:
            sequences.append(record)

with open('selected_prot.fasta', 'w') as sf:
    SeqIO.write(sequences, sf, "fasta")
