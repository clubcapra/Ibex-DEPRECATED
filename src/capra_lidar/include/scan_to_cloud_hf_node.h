

#ifndef SCAN_TO_CLOUD_HF_H
#define SCAN_TO_CLOUD_HF_H

#include <limits>
#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/PointCloud2.h>

#include <laser_geometry/laser_geometry.h>
#include <tf/tf.h>
#include <tf/transform_listener.h>

namespace capra_lidar {

    class ScanToCloudHf
    {
      private:

        ros::NodeHandle nh_;
        ros::NodeHandle nh_private_;

        ros::Publisher cloud_publisher_;
        ros::Subscriber scan_subscriber_;
        tf::TransformListener listener_;

        laser_geometry::LaserProjection projector_;

        void scanCallback(const sensor_msgs::LaserScan::ConstPtr& scan_msg);

      public:

        ScanToCloudHf(ros::NodeHandle nh, ros::NodeHandle nh_private);
        ~ScanToCloudHf();
    };

} // namespace capra_lidar

#endif // SCAN_TO_CLOUD_HF_H
