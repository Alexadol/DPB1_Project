import sys
import re

path = sys.argv[1]
with open(path,'r') as f:
    new_list = []
    lines = f.readlines()
    for line in lines:
        if line.startswith('\n>G') or line.startswith('>G'):
            line1 = re.sub(r'.(p\d+).*',r'.\1',line)
            print('{} was changed to {}'.format(line.strip(),line1.strip()))
            new_list.append(line1)
        else:
            new_list.append(line)
    with open("trimmed_after_prank_modified", "w") as f:
        for line in new_list:
            f.write(line)
