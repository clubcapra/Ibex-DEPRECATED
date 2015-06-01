#include <iostream>
#include "opencv2/opencv.hpp"
// #include "opencv2/gpu/gpu.hpp"

#define DOCSTRING "C++ Undistort"

cv::Mat cameraMatrix = (cv::Mat_<double>(3, 3) << 
			630.79035702238025/2, 0, 645.50000000000000/2, 
			0, 630.79035702238025/2, 366.50000000000000/2, 
			0, 0, 1);

cv::Mat distCoeffs = (cv::Mat_<double>(1, 5) << -0.34, 0.085, 0, 0, -0.007);

cv::Size_<int> size(1292 / 2, 734 / 2);

cv::Mat largeCameraMatrix = (cv::Mat_<double>(3, 3) << 
			     630.79035702238025/2, 0, 645.50000000000000/2,
			     0, 630.79035702238025/2, 366.50000000000000/2,
			     0, 0, 1);

// cv::Mat optimalMat = cv::getOptimalNewCameraMatrix(largeCameraMatrix, distCoeffs, size, 1);

void init() {

}

void configure() {
}

cv::Mat execute(cv::Mat image) {
  cv::Mat output;

  cv::undistort(image, output, cameraMatrix, distCoeffs, cameraMatrix);

  return output;
}
