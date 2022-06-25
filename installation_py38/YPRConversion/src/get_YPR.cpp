// #include <opencv2/opencv.hpp>

#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>
#include <fstream>
#include <numeric>
#include <tuple>

//#include <boost/program_options.hpp>
#include "LinearMath/Matrix3x3.h"
#include "get_YPR.hpp"

using namespace std;


inline double todeg(double rad) {
    return rad * 180 / M_PI;
}

tuple<double,double,double> get_ypr_quaternion_conversion(float p1,float p2,float p3,float p4,float p5,float p6,float p7,float p8,float p9)
{
double raw_yaw, raw_pitch, raw_roll;
double yaw, pitch, roll;
tf::Matrix3x3 mrot(
            p1,p2,p3,
            p4,p5,p6,
            p7,p8,p9);
mrot.getRPY(raw_roll, raw_pitch, raw_yaw);

raw_roll = raw_roll - M_PI/2;
raw_yaw = raw_yaw + M_PI/2;
roll = todeg(raw_pitch);
yaw = todeg(raw_yaw);//-180;
pitch = todeg(-raw_roll);//-180;
return make_tuple(yaw,pitch,roll);
// return yaw;
}
