#!/bin/bash

cdir=$(pwd)


# System packages
source installation_py38/prerequisite_system_packages.sh

# Pip installations
pip install -r cv_requirements_py38.in

# Install Opencv
source installation_py38/build_opencv-4_3_0.sh

# Install Caffe
source build_caffe.sh

# Install Pyboostconverter and LibQuaternion.
source vision_tasks.sh

