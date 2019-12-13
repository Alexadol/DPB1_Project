import sys


gene_set = []
rsem = sys.argv[1]
rsem_name = rsem.split('/')[-1]
if not rsem_name:
    rsem_name = rsem.split('/')[-2]
else:
    rsem += '/'

with open('gene_set', 'r') as gs:
    for line in gs:
        gene_set.append(line.strip())


with open(rsem + 'RSEM.genes.results', 'r') as genes:
    with open(rsem_name + '_extracted', 'w') as result:
        for line in genes:
            if line.strip().split()[0] in gene_set:
                if rsem_name[5:8] == 'Ecy':
                    result.write('Ecy\t')
                elif rsem_name[5:8] == 'Eve':
                    result.write('Eve\t')
                elif rsem_name[5:8] == 'Gla':
                    result.write('Gla\t')
                else:
                    print('Species error')
                    result.write('Undefined\t')
                result.write(rsem_name + '\t' + line)
