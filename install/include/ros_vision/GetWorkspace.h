// Generated by gencpp from file ros_vision/GetWorkspace.msg
// DO NOT EDIT!


#ifndef ROS_VISION_MESSAGE_GETWORKSPACE_H
#define ROS_VISION_MESSAGE_GETWORKSPACE_H

#include <ros/service_traits.h>


#include <ros_vision/GetWorkspaceRequest.h>
#include <ros_vision/GetWorkspaceResponse.h>


namespace ros_vision
{

struct GetWorkspace
{

typedef GetWorkspaceRequest Request;
typedef GetWorkspaceResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct GetWorkspace
} // namespace ros_vision


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::ros_vision::GetWorkspace > {
  static const char* value()
  {
    return "4fe033c7c690050d20ac47435e8e465c";
  }

  static const char* value(const ::ros_vision::GetWorkspace&) { return value(); }
};

template<>
struct DataType< ::ros_vision::GetWorkspace > {
  static const char* value()
  {
    return "ros_vision/GetWorkspace";
  }

  static const char* value(const ::ros_vision::GetWorkspace&) { return value(); }
};


// service_traits::MD5Sum< ::ros_vision::GetWorkspaceRequest> should match 
// service_traits::MD5Sum< ::ros_vision::GetWorkspace > 
template<>
struct MD5Sum< ::ros_vision::GetWorkspaceRequest>
{
  static const char* value()
  {
    return MD5Sum< ::ros_vision::GetWorkspace >::value();
  }
  static const char* value(const ::ros_vision::GetWorkspaceRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::ros_vision::GetWorkspaceRequest> should match 
// service_traits::DataType< ::ros_vision::GetWorkspace > 
template<>
struct DataType< ::ros_vision::GetWorkspaceRequest>
{
  static const char* value()
  {
    return DataType< ::ros_vision::GetWorkspace >::value();
  }
  static const char* value(const ::ros_vision::GetWorkspaceRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::ros_vision::GetWorkspaceResponse> should match 
// service_traits::MD5Sum< ::ros_vision::GetWorkspace > 
template<>
struct MD5Sum< ::ros_vision::GetWorkspaceResponse>
{
  static const char* value()
  {
    return MD5Sum< ::ros_vision::GetWorkspace >::value();
  }
  static const char* value(const ::ros_vision::GetWorkspaceResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::ros_vision::GetWorkspaceResponse> should match 
// service_traits::DataType< ::ros_vision::GetWorkspace > 
template<>
struct DataType< ::ros_vision::GetWorkspaceResponse>
{
  static const char* value()
  {
    return DataType< ::ros_vision::GetWorkspace >::value();
  }
  static const char* value(const ::ros_vision::GetWorkspaceResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROS_VISION_MESSAGE_GETWORKSPACE_H