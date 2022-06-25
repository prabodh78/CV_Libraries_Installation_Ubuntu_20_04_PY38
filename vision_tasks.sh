#!/bin/bash
m=$(pwd)


vision_tasks()
{
python -c 'import sys;print(sys.version_info.minor)' | grep 8
if [ $? == 0 ];
then
cd "$m"/installation_py38/pyboostcvconverter/
else
cd "$m"/pyboostcvconverter/
fi

rm -rf build
mkdir build
cd build
touch __init__.py
cmake ..
make

python -c 'import sys;print(sys.version_info.minor)' | grep 8
if [ $? == 0 ];
then
cd "$m"/installation_py38/YPRConversion/
else
cd "$m"/dlib_folder/python_examples/YPRConversion
fi

rm -rf build
mkdir build
touch __init__.py
cd build

cmake ..
make
if [ $? -ne 0 ]
    then echo "Error building LibQuaternion !"
fi

}

vision_tasks

