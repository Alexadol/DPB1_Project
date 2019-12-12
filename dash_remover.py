import sys
import re

path = sys.argv[1]
with open(path,'r') as f:
    new_list = []
    lines = f.readlines()
    for line in lines:
        if not line.startswith('-'):
            new_list.append(line)
    with open(path, "w") as f:
        for line in new_list:
            f.write(line)

