#!/bin/bash
m=$(pwd)
NPROC=$(nproc)

make clean
make all -j$NPROC

if [[ -z $PYTHONPATH ]]; 
then 
echo 'export PYTHONPATH='"$m"'/python:$PYTHONPATH'>> ~/.bashrc
else
echo "No need to export PYTHONPATH.."
fi
source ~/.bashrc

make pycaffe -j$NPROC

cd "$m"/densecrf
make clean
make -j$NPROC

cd "$m"/python
echo 'Current directory : '
pwd
python -c 'import caffe'
if [ $? -ne 0 ]
    then echo "Error building Caffe !"
else
    echo "Caffe is installed !"
fi
