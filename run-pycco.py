# Generate AVR annotated code.

# The modified Pycco Python file is here:
# C:\Users\roger\AppData\Local\Programs\Python\Python38\Lib\site-packages\pycco\main.py

import glob, os, shutil

def delete_folder_contents(folder):
    for root, dirs, files in os.walk(folder):
        for f in files:
            os.unlink(os.path.join(root, f))
        for d in dirs:
            shutil.rmtree(os.path.join(root, d))
           
searches = ('**/*.vr', 'global.asax', '**/*.aspx', '*.aspx', 'web.config')

files = []
for search in searches:
    files.extend(glob.glob(search, recursive=True)) 

delete_folder_contents('./annotated-code')

for file in files:
    cmd = f'pycco {file} -d ./annotated-code -l javascript -p'
    os.system(cmd)

shutil.copy("pycco.css", './annotated-code/')    