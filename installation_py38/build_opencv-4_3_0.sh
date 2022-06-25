#!/bin/bash

workon cv2
echo 'Installing Opencv-4.3.0 on cv2 virtual envirnoment..'

m=$(pwd)

mkdir -p Downloads
cd Downloads
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.3.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.3.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

# Build Opencv 
cd opencv-4.3.0
rm -rf build 
mkdir build 
cd build

cmake -D OPENCV_DIR="$m"/Downloads/opencv-4.3.0 -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D BUILD_EXAMPLES=OFF -D WITH_OPENGL=ON -D WITH_VTK=ON -D OPENCV_EXTRA_MODULES_PATH="$m"/Downloads/opencv_contrib-4.3.0/modules -D WITH_CUDA=OFF  -D WITH_GSTREAMER=OFF  -D BUILD_opencv_dnn_modern=ON -D BUILD_opencv_cnn_3dobj=ON .. 

NPROC=$(nproc)
make -j$NPROC
sudo make install
sudo ldconfig

cd /usr/local/lib/python3.8/site-packages/cv2/python-3.8
sudo mv cv2.cpython-38-x86_64-linux-gnu.so cv2.so

cd ~/.virtualenvs/cv2/lib/python3.8/site-packages/
sudo ln -s /usr/local/lib/python3.8/site-packages/cv2/python-3.8/cv2.so cv2.so

cd "$m"
python -c 'import cv2; print(cv2.__version__)'
if [ $? -ne 0 ]
    then echo "Error building Opencv !"
else
    echo "Opencv is installed !"
fi
