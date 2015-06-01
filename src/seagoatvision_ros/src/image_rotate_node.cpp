#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/Image.h"

#include "opencv2/opencv.hpp"
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <tf/transform_listener.h>

#include <sstream>
#include <stdio.h>
#include <math.h>

using namespace cv;

class ImageRotate
{

    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Publisher image_pub_;

    tf::TransformListener listener;

    float cameraHeight;
    float cameraAngle;

public:
    ImageRotate()
        : it_(nh_)
    {
        image_pub_ = it_.advertise("image_rotated", 10);
        image_sub_ = it_.subscribe("/image_raw", 10, &ImageRotate::handleImage, this);


        tf::StampedTransform transform;
        try{
            listener.waitForTransform("/base_footprint", "/camera", ros::Time(), ros::Duration(2.0));
            listener.lookupTransform("/base_footprint", "/camera", ros::Time(0), transform);

            cameraHeight = transform.getOrigin().getZ();

            double roll, pitch, yaw;
            tf::Quaternion cameraRotationQ = transform.getRotation();
            tf::Matrix3x3(cameraRotationQ).getRPY(roll, pitch, yaw);
            cameraAngle = M_PI/2.0f - pitch;

            ROS_INFO("Using camera TF with cameraHeight %f and cameraAngle %f", cameraHeight, cameraAngle);
        }
        catch (tf::TransformException ex){
            ROS_ERROR("%s",ex.what());
            ros::Duration(1.0).sleep();
        }

    }

    cv::Mat transform(cv::Mat image)
    {

        int rotationX_ = -cameraAngle;
        int rotationY_ = 0;

        double dx = 0;
        double dy = 0;//cameraHeight * 1000;
        double dz = 0.8;

        int zoom_ = 100;

        //Load parameters from file
        //std::ifstream infile("test.txt");
        //infile >> rotationX_ >> rotationY_ >> zoom_;

        const double w = image.cols;
        const double h = image.rows;

        // Projection 2D -> 3D matrix
        Mat A1 = (Mat_<double>(4,3) <<
            1, 0, -w/2,
            0, 1, -h/2,
            0, 0,    0,
            0, 0,    1);

        // Rotation matrices around the X axis
        const double alpha = -0.5 / w;
        Mat RX = (Mat_<double>(4, 4) <<
            1,          0,           0, 0,
            0, cos(alpha), -sin(alpha), 0,
            0, sin(alpha),  cos(alpha), 0,
            0,          0,           0, 1);

        // Rotation matrices around the X axis

        const double beta = rotationY_ / 180. * 3.1416 / h;
        Mat RY = (Mat_<double>(4, 4) <<
            cos(beta),  0,           sin(beta), 0,
            0,			1,			 0, 0,
            -sin(beta), 0,			 cos(beta), 0,
            0,          0,           0, 1);

        // Translation matrix on the Z axis
        Mat T = (Mat_<double>(4, 4) <<
            1, 0, 0, dx,
            0, 1, 0, dy,
            0, 0, 1, dz,
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


    void handleImage(const sensor_msgs::Image::ConstPtr& msg)
    {
        //ROS_INFO("got something!");

        cv_bridge::CvImagePtr cv_ptr;
        try
        {
          cv_ptr = cv_bridge::toCvCopy(msg, "");
        }
        catch (cv_bridge::Exception& e)
        {
          ROS_ERROR("cv_bridge exception: %s", e.what());
          return;
        }

        // Draw an example circle on the video stream
        //if (cv_ptr->image.rows > 60 && cv_ptr->image.cols > 60)
        //  cv::circle(cv_ptr->image, cv::Point(50, 50), 10, CV_RGB(255,0,0));

        cv_ptr->image = transform(cv_ptr->image);

        // Output modified video stream
        image_pub_.publish(cv_ptr->toImageMsg());

    }


};


int main(int argc, char **argv)
{

    ros::init(argc, argv, "image_rotate_node");
    ImageRotate rotate;

    ros::spin();

     return 0;
}