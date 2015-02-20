#include "scan_to_cloud_hf_node.h"

namespace capra_lidar {

    ScanToCloudHf::ScanToCloudHf(ros::NodeHandle nh, ros::NodeHandle nh_private):
      nh_(nh),
      nh_private_(nh_private)
    {
      ROS_INFO("Starting ScanToCloudHf");

      std::string cloud_topic;
      nh_private_.param<std::string>("cloud_topic", cloud_topic, "cloud");
      cloud_publisher_ = nh_.advertise<sensor_msgs::PointCloud2>(
        cloud_topic, 1);

      std::string scan_topic;
      nh_private_.param<std::string>("scan_topic", scan_topic, "scan");
      std::cout << scan_topic << std::endl;
      scan_subscriber_ = nh_.subscribe(
       scan_topic, 1, &ScanToCloudHf::scanCallback, this);
    }

    ScanToCloudHf::~ScanToCloudHf()
    {
      ROS_INFO("Destroying ScanToCloudHf");
    }

    void ScanToCloudHf::scanCallback(const sensor_msgs::LaserScan::ConstPtr& scan_in)
    {
        //ROS_INFO("Got scan");
        //From http://wiki.ros.org/laser_geometry
        if(!listener_.waitForTransform(
                scan_in->header.frame_id,
                "/base_link",
                scan_in->header.stamp + ros::Duration().fromSec(scan_in->ranges.size()*scan_in->time_increment),
                ros::Duration(1.0))){
             return;
          }

          sensor_msgs::PointCloud2 cloud;

          projector_.transformLaserScanToPointCloud("laser",*scan_in,
                  cloud,listener_, -1.0, laser_geometry::channel_option::None);

      // Do something with cloud.

      cloud_publisher_.publish(cloud);
    }

} //namespace scan_tools


int main (int argc, char **argv)
{
  ros::init (argc, argv, "ScanToCloudHf");
  ros::NodeHandle nh;
  ros::NodeHandle nh_private("~");
  capra_lidar::ScanToCloudHf ScanToCloud(nh, nh_private);
  ros::spin();
  return 0;
}