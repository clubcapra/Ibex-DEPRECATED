// Generated by gencpp from file capra_msgs/EStopStatus.msg
// DO NOT EDIT!


#ifndef CAPRA_MSGS_MESSAGE_ESTOPSTATUS_H
#define CAPRA_MSGS_MESSAGE_ESTOPSTATUS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace capra_msgs
{
template <class ContainerAllocator>
struct EStopStatus_
{
  typedef EStopStatus_<ContainerAllocator> Type;

  EStopStatus_()
    : stopped(false)  {
    }
  EStopStatus_(const ContainerAllocator& _alloc)
    : stopped(false)  {
    }



   typedef uint8_t _stopped_type;
  _stopped_type stopped;




  typedef boost::shared_ptr< ::capra_msgs::EStopStatus_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::capra_msgs::EStopStatus_<ContainerAllocator> const> ConstPtr;

}; // struct EStopStatus_

typedef ::capra_msgs::EStopStatus_<std::allocator<void> > EStopStatus;

typedef boost::shared_ptr< ::capra_msgs::EStopStatus > EStopStatusPtr;
typedef boost::shared_ptr< ::capra_msgs::EStopStatus const> EStopStatusConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::capra_msgs::EStopStatus_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::capra_msgs::EStopStatus_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace capra_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'geometry_msgs': ['/opt/ros/indigo/share/geometry_msgs/cmake/../msg'], 'capra_msgs': ['/home/capra/Ibex/src/capra_msgs/msg'], 'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::capra_msgs::EStopStatus_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::capra_msgs::EStopStatus_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::capra_msgs::EStopStatus_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::capra_msgs::EStopStatus_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::capra_msgs::EStopStatus_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::capra_msgs::EStopStatus_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::capra_msgs::EStopStatus_<ContainerAllocator> >
{
  static const char* value()
  {
    return "caab21a24341159709db962b47b01ad1";
  }

  static const char* value(const ::capra_msgs::EStopStatus_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xcaab21a243411597ULL;
  static const uint64_t static_value2 = 0x09db962b47b01ad1ULL;
};

template<class ContainerAllocator>
struct DataType< ::capra_msgs::EStopStatus_<ContainerAllocator> >
{
  static const char* value()
  {
    return "capra_msgs/EStopStatus";
  }

  static const char* value(const ::capra_msgs::EStopStatus_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::capra_msgs::EStopStatus_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool stopped\n\
";
  }

  static const char* value(const ::capra_msgs::EStopStatus_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::capra_msgs::EStopStatus_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.stopped);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct EStopStatus_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::capra_msgs::EStopStatus_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::capra_msgs::EStopStatus_<ContainerAllocator>& v)
  {
    s << indent << "stopped: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.stopped);
  }
};

} // namespace message_operations
} // namespace ros

#endif // CAPRA_MSGS_MESSAGE_ESTOPSTATUS_H