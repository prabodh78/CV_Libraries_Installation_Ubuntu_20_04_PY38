cmake_minimum_required(VERSION 2.8.3)
project(YPRConversion)

set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH})
add_definitions(-std=c++11)
set( BOOST_PYTHONLIB python3)

# add_library(eyewear SHARED src/get_YPR.cpp)

find_package( PythonLibs 3.5 REQUIRED )
include_directories( ${PYTHON_INCLUDE_DIRS} )

find_package(PythonInterp REQUIRED)
find_package( Boost COMPONENTS python REQUIRED )


if( Boost_FOUND )
        MESSAGE("********************************FOUND BOOST***********************")
endif( Boost_FOUND )           
include_directories( ${Boost_INCLUDE_DIR} )
link_directories( ${Boost_LIBRARIES} )
 
add_library(QuaternionYPR SHARED src/QuaternionYPR.cpp src/get_YPR.cpp )
target_link_libraries(QuaternionYPR ${Boost_LIBRARIES} ${PYTHON_LIBRARIES})
