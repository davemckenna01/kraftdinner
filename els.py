import os

# get current working directory
cwd = os.getcwd()

labelled_dirs = {}
dir_content = os.listdir(cwd)
prefix_dir = "/"
prefix_other = ""

for i in range(0, len(dir_content)):
    if os.path.isdir(dir_content[i]): 
        labelled_dirs[i + 1] = prefix_dir + dir_content[i]
    else:
        labelled_dirs[i + 1] = prefix_other + dir_content[i]

for i in labelled_dirs:
    print str(i) + " -- " + labelled_dirs[i] 

selection = raw_input(":")

target_dir = labelled_dirs[int(selection)]

os.chdir(cwd + "/" + target_dir)

#when I do this in C, we need to use the C chdir() to change dirs.
#That's all bash "cd" is ... it just checks the error cods of "chdir()" I believe...
#Best to look at the source code for "cd"
