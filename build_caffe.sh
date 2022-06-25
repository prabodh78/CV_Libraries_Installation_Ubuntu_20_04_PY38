#!/bin/bash

cdir=$(pwd)

# Active Envirnoment
source ~/.virtualenvs/cv2/bin/activate

# Install Caffe
python -c 'import sys;print(sys.version_info.minor)' | grep 8
if [ $? == 0 ];
then

cd "$cdir"/installation_py38/DeepLab_V1/code
source install_caffe.sh

else

cd "$cdir"/DeepLab_V1/code
source install_caffe.sh
fi



