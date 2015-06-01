#include "opencv2/opencv.hpp"
#include "opencv2/gpu/gpu.hpp"
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

void perspective(const gpu::GpuMat& image, gpu::GpuMat& imageWarped){

  const double w = image.cols;
  const double h = image.rows;

  Point2f src_vertices[4];
  src_vertices[0] = Point(0,0);
  src_vertices[1] = Point(0,h);
  src_vertices[2] = Point(w,0);
  src_vertices[3] = Point(w,h);

  Point2f dst_vertices[4];
  dst_vertices[0] = Point(topLeftX, topLeftY);
  dst_vertices[1] = Point(bottomLeftX, bottomLeftY);
  dst_vertices[2] = Point(topRightX, topRightY);
  dst_vertices[3] = Point(bottomRightX, bottomRightY);

  Mat warpMatrix = getPerspectiveTransform(src_vertices, dst_vertices);

  gpu::warpPerspective(image, imageWarped, warpMatrix, imageWarped.size());
}

void transform(const gpu::GpuMat& image, gpu::GpuMat& destination) {

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
	    cos(beta),  0, sin(beta), 0,
	    0,          1, 0,         0,
	    -sin(beta), 0, cos(beta), 0,
	    0,          0, 0,         1);

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

  gpu::warpPerspective(image, destination, transfo, image.size(), INTER_CUBIC | WARP_INVERSE_MAP);
}

Mat execute(Mat image)
{
  gpu::GpuMat gmat(image), transformed(image), persp(image);

  // Change perspective with the 4 corners
  transform(gmat, transformed);

  // Transform with the zoom and translation
  perspective(transformed, persp);

  persp.download(image);

  return image;
}
