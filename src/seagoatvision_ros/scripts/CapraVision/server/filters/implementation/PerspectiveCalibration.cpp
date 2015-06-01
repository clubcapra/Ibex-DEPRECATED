#include "opencv2/opencv.hpp"
//#include "opencv2/gpu/gpu.hpp"
#include <fstream>
#include <stdio.h>

#define DOCSTRING "C++ Perspective Calibration"

using namespace cv;


int topLeftX = 0;
int topLeftY = 0;
int bottomLeftX = 0;
int bottomLeftY = 0;
int topRightX = 0;
int topRightY = 0;
int bottomRightX = 0;
int bottomRightY = 0;

int translationX = 0;
int translationY = 0;
int zoom = 100;

void init() {
	//rotationX = ParameterAsInt("rotationX", -360, 360, -160);
	//rotationY = ParameterAsInt("rotationY", -360, 360, 0);

    topLeftX = ParameterAsInt("topLeftX",-1500,1500,0);
    topLeftY = ParameterAsInt("topLeftY",-1500,1500,0);
    bottomLeftX = ParameterAsInt("bottomLeftX",0,1500,202);
    bottomLeftY = ParameterAsInt("bottomLeftY",0,1500,734);
    topRightX = ParameterAsInt("topRightX",0,1500,1292);
    topRightY = ParameterAsInt("topRightY",0,1500,0);
    bottomRightX = ParameterAsInt("bottomRightX",0,1500,1090);
    bottomRightY = ParameterAsInt("bottomRightY",0,1500,734);

	translationX = ParameterAsInt("translationX", -1000, 1000, 0);
	translationY = ParameterAsInt("translationY", -1000, 1000, 0);
	zoom = ParameterAsInt("zoom", 0, 500, 100);
}

void configure() {
	init();
}

cv::Mat perspective(cv::Mat image){

	    const double w = image.cols;
	    const double h = image.rows;

        cv::Point2f src_vertices[4];
        src_vertices[0] = cv::Point(0,0);
        src_vertices[1] = cv::Point(0,h);
        src_vertices[2] = cv::Point(w,0);
        src_vertices[3] = cv::Point(w,h);

        cv::Point2f dst_vertices[4];
        dst_vertices[0] = cv::Point(topLeftX, topLeftY);
        dst_vertices[1] = cv::Point(bottomLeftX, bottomLeftY);
        dst_vertices[2] = cv::Point(topRightX, topRightY);
        dst_vertices[3] = cv::Point(bottomRightX, bottomRightY);

        cv::Mat warpMatrix = cv::getPerspectiveTransform(src_vertices, dst_vertices);

        cv::Mat imageWarped;
        cv::warpPerspective(image, imageWarped, warpMatrix, imageWarped.size());

        return imageWarped;
}

cv::Mat transform(cv::Mat image){

	const double w = image.cols;
	const double h = image.rows;

	// Projection 2D -> 3D matrix
	Mat A1 = (Mat_<double>(4,3) <<
		1, 0, -w/2,
		0, 1, -h/2,
		0, 0,    0,
		0, 0,    1);

    // The rotation matrices are not used by this filter but are left there if
    // someone wants to use them at some point

	// Rotation matrices around the X axis
	int rotationX = 0;
	const double alpha = rotationX / 180. * 3.1416 / w;
	Mat RX = (Mat_<double>(4, 4) <<
		1,          0,           0, 0,
		0, cos(alpha), -sin(alpha), 0,
		0, sin(alpha),  cos(alpha), 0,
		0,          0,           0, 1);

	// Rotation matrices around the X axis
    int rotationY = 0;
	const double beta = rotationY / 180. * 3.1416 / h;
	Mat RY = (Mat_<double>(4, 4) <<
		cos(beta),  0,           sin(beta), 0,
		0,			1,			 0, 0,
		-sin(beta), 0,			 cos(beta), 0,
		0,          0,           0, 1);

	// Translation matrix on the Z axis
	Mat T = (Mat_<double>(4, 4) <<
		1, 0, 0, translationX,
		0, 1, 0, translationY,
		0, 0, 1, zoom/100.0f,
		0, 0, 0, 1);

	const double f = 1;
	// Camera Intrisecs matrix 3D -> 2D
	Mat A2 = (Mat_<double>(3,4) <<
		f, 0, w/2, 0,
		0, f, h/2, 0,
		0, 0,   1, 0);

	Mat transfo = A2 * (T * (RX * RY * A1));

	Mat destination;

	warpPerspective(image, destination, transfo, image.size(), INTER_CUBIC | WARP_INVERSE_MAP);

	return destination;
}

cv::Mat execute(cv::Mat image)
{
    // Change perspective with the 4 corners
    Mat m = perspective(image);

    // Transform with the zoom and translation
    return transform(m);

}