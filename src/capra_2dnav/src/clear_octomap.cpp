#include <nav_core/recovery_behavior.h>
#include <costmap_2d/costmap_2d_ros.h>
#include <tf/transform_listener.h>
#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Point.h>
#include <angles/angles.h>
#include <pluginlib/class_list_macros.h>
#include <std_srvs/Empty.h>


namespace capra_2dnav {
  class ClearOctomap : public nav_core::RecoveryBehavior {
  public:
    ClearOctomap() {}

    void initialize(std::string name, tf::TransformListener* tf, costmap_2d::Costmap2DROS* global_costmap, costmap_2d::Costmap2DROS* local_costmap) {
      tf_ = tf;
    }

    void runBehavior() {
      ros::NodeHandle n;
      auto client = n.serviceClient<std_srvs::Empty>("/capra_2dnav/clear_octomap");
      auto srv = std_srvs::Empty();

      if(client.call(srv)) {
        ROS_INFO("Octomap cleared");
      } else {
        ROS_ERROR("Could not clear Octomap");
      }
    }

  private:
    tf::TransformListener* tf_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_2dnav::ClearOctomap, nav_core::RecoveryBehavior)
}
