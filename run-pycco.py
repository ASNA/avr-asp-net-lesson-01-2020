# Generate AVR annotated code.

# The modified Pycco Python file is here:
# C:\Users\roger\AppData\Local\Programs\Python\Python38\Lib\site-packages\pycco\main.py

import glob, os, shutil, re

def create_index_file(template_filename, files):
    template_contents = read_file(template_filename)
    index_list = create_index_list(files)
    template_contents = template_contents.replace('{{directory}}', index_list)
    write_file('./docs/index.html', template_contents)

def write_file(filename, contents):
    with open(filename, 'w', encoding="utf-8") as f:
        f.write(contents)

def read_file(filename):
    with open(filename, 'r', encoding="utf-8") as f:
        return f.read()

def delete_folder_contents(folder):
    #  Save template file contents.
    directory_template_contents = read_file('./docs/index.template.html')

    for root, dirs, files in os.walk(folder):
        for f in files:
            os.unlink(os.path.join(root, f))
        for d in dirs:
            shutil.rmtree(os.path.join(root, d))
    # Restore template file contents.
    write_file('./docs/index.template.html', directory_template_contents)            

def create_index_list(files):
    index_list = ''
    anchor_tags = []
    template = '{filename}|<li><a href="{url}">{filename}</a></li>'
    root_name = ''
    for file in files:
        if '\\' in file:
            root_name = ''
        else:            
            root_name = '_ROOT_/'
        filename_to_show = root_name + file.replace('\\', '/').lower()
        tag = template.format(url=file + '.html', filename=filename_to_show)
        anchor_tags.append(tag)
    anchor_tags.sort()

    for anchor_tag in anchor_tags:
        anchor_tag = anchor_tag.replace('_ROOT_/', '')
        index_list += re.sub(r'^.*\|', '', anchor_tag)

    return index_list
    
if __name__ == '__main__':  
    searches = ('global.asax', 'web.config', '*.aspx', '**/*.aspx', '**/*.vr' )

    files = []
    for search in searches:
        files.extend(glob.glob(search, recursive=True)) 

    delete_folder_contents('./docs')

    create_index_file(template_filename='./docs/index.template.html', files=files)

    for file in files:
        cmd = f'pycco {file} -d ./docs -l javascript -p'
        os.system(cmd)

    shutil.copy("pycco.css", './docs/')    
