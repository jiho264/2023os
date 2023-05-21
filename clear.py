import os
import glob

files = glob.glob('**', recursive=True)
isEmpty = True
for file in files:
    if '.' not in file:
        if os.path.isdir(file):
            continue
        print(file, 'is deleted')
        isEmpty = False
        #os.remove(file)
    if '_' in file:
        if '.OBJ' in file or '.EXE' in file:
            print(file, "i pound it")
            os.remove(file)
        
if isEmpty:
    print('there is nothing to erase')
# https: // velog.io/@d2h10s/vscode-바이너리-파일-지우는-코드