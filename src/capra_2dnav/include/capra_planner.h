#ifndef CAPRA_PLANNER_H
#define CAPRA_PLANNER_H

#include <ros/ros.h>
#include <costmap_2d/costmap_2d.h>

#include <nav_core/base_local_planner.h>
#include <dynamic_reconfigure/server.h>
#include <base_local_planner/BaseLocalPlannerConfig.h>

#include <base_local_planner/odometry_helper_ros.h>


class CapraPlanner : public nav_core::BaseLocalPlanner
{
 public:
  CapraPlanner();

  bool computeVelocityCommands(geometry_msgs::Twist& cmd_vel);

  bool isGoalReached();


  bool setPlan(const std::vector<geometry_msgs::PoseStamped>& plan);


  void initialize(std::string name, tf::TransformListener* tf, costmap_2d::Costmap2DROS* costmap_ros);

 private:

};

#endif
