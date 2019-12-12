import sys
path = sys.argv[1]

with open(path, 'r') as f:
    pept_seq_id = []
    result = True
    for line in f:
        if not line.startswith('--'):
            line = line.rstrip()
            pept_seq_id.append(line)
    for id, item in enumerate(pept_seq_id):
        if not item.startswith('>'):
            pattern = item
            pat_id = id
            for id, item in enumerate(pept_seq_id):
                if pattern in item and pat_id != id or pattern == item and pat_id != id:
                    print('Attention! One of peptides is the part of another!')
                    print('{} it is the part of {}'.format(pept_seq_id[pat_id - 1], pept_seq_id[id-1]))
                    result = False

    if result:
        print('Everything is ok! All peptides are unique')
