#include <iostream>
#include <string>
#include <tuple>


#include "QuaternionYPR.hpp"
#include "get_YPR.hpp"

using namespace std;


string doQuaternionYPR(float p1,float p2,float p3,float p4,float p5,float p6,float p7,float p8,float p9)
{	
	auto YPR = get_ypr_quaternion_conversion(p1,p2,p3,p4,p5,p6,p7,p8,p9);
	string result = to_string(get<0>(YPR)) + ',' + to_string(get<1>(YPR)) + ',' +to_string(get<2>(YPR)); 
	return result;
}




#include <boost/python.hpp>

BOOST_PYTHON_MODULE(libQuaternionYPR)
{
	using namespace boost::python;
    def("doQuaternionYPR", doQuaternionYPR);
}