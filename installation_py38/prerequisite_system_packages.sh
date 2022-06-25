#!/bin/bash
# Prerequisites System Packages

# 1. Opencv 
sudo apt-get update
sudo apt-get upgrade

# Install upgraded version of cmake -> Caffe's dependency. 
# Obtain a copy of kitware's signing key.
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt update
sudo apt -y install cmake

sudo apt-get -y install build-essential unzip pkg-config

sudo apt-get -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev

sudo apt-get -y install libgtk-3-dev

sudo apt-get -y install libatlas-base-dev gfortran

# One of dlib dependency
sudo apt-get -y install python3.8-dev

sudo apt-get -y install python3.8-distutils

wget https://bootstrap.pypa.io/get-pip.py
sudo python3.8 get-pip.py

# Create and activate virtualenv
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip

if [[ -z $WORKON_HOME ]]; then 
echo "need to export "
echo 'export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc
echo "For workon.." 
else
echo "No need to export WORKON_HOME"
fi
source `which virtualenvwrapper.sh`
source ~/.bashrc

mkvirtualenv cv2 -p python3.8
workon cv2
################## End Opencv ########################

# Caffe 
sudo apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libhdf5-dev 
sudo apt-get -y install --no-install-recommends libboost-all-dev libmatio-dev
sudo apt-get -y install -y gfortran libjpeg62 libfreeimage-dev git python3-pip libbz2-dev libxml2-dev libxslt-dev libffi-dev libssl-dev  python3-yaml python3-numpy libopencv-dev
sudo apt-get -y install libatlas-base-dev
sudo apt-get -y install libopenblas-dev
sudo apt-get -y install the python3-skimage

sudo apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev

sudo pip3 install pydot
sudo apt-get -y install graphviz

################## End Caffe ########################

# Cuda 
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-6-local_11.6.2-510.47.03-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-6-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
################## End Cuda ########################


# OCR and Video Editor Tool 
sudo apt-get -y install ffmpeg 
sudo apt -y install tesseract-ocr 
sudo apt -y install libtesseract-dev



