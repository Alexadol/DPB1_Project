import os


gene_set = []

with open ('gene_set', 'r') as gs:
	for line in gs:
		gene_set.append(line.strip())

path = []


with open ('list_of_folders', 'r') as lof:
	for line in lof:
		path.append(line.strip())

for rsem in path:
	if os.path.exists(rsem + '/RSEM.genes.results'):
		with open (rsem + '/RSEM.genes.results', 'r') as genes:
			with open (rsem + '_extracted', 'w') as result:
				for line in genes:
					if line.strip().split()[0] in gene_set:
						if rsem[5:8] == 'Ecy':
							result.write('Ecy\t')
						elif rsem[5:8] == 'Eve':
							result.write('Eve\t')
						elif rsem[5:8] == 'Gla':
							result.write('Gla\t')
						else:
							print ('aaaaa')
							result.write('Undefined\t')
						result.write(rsem + '\t' + line)

