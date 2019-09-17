// Generated by gencpp from file exosystem/Torque.msg
// DO NOT EDIT!


#ifndef EXOSYSTEM_MESSAGE_TORQUE_H
#define EXOSYSTEM_MESSAGE_TORQUE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace exosystem
{
template <class ContainerAllocator>
struct Torque_
{
  typedef Torque_<ContainerAllocator> Type;

  Torque_()
    : torque1(0.0)
    , torque2(0.0)  {
    }
  Torque_(const ContainerAllocator& _alloc)
    : torque1(0.0)
    , torque2(0.0)  {
  (void)_alloc;
    }



   typedef float _torque1_type;
  _torque1_type torque1;

   typedef float _torque2_type;
  _torque2_type torque2;





  typedef boost::shared_ptr< ::exosystem::Torque_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::exosystem::Torque_<ContainerAllocator> const> ConstPtr;

}; // struct Torque_

typedef ::exosystem::Torque_<std::allocator<void> > Torque;

typedef boost::shared_ptr< ::exosystem::Torque > TorquePtr;
typedef boost::shared_ptr< ::exosystem::Torque const> TorqueConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::exosystem::Torque_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::exosystem::Torque_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace exosystem

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'exosystem': ['/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::exosystem::Torque_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exosystem::Torque_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exosystem::Torque_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exosystem::Torque_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exosystem::Torque_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exosystem::Torque_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::exosystem::Torque_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4352967d78fc540447ece6189f8160cf";
  }

  static const char* value(const ::exosystem::Torque_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4352967d78fc5404ULL;
  static const uint64_t static_value2 = 0x47ece6189f8160cfULL;
};

template<class ContainerAllocator>
struct DataType< ::exosystem::Torque_<ContainerAllocator> >
{
  static const char* value()
  {
    return "exosystem/Torque";
  }

  static const char* value(const ::exosystem::Torque_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::exosystem::Torque_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 torque1\n\
float32 torque2\n\
";
  }

  static const char* value(const ::exosystem::Torque_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::exosystem::Torque_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.torque1);
      stream.next(m.torque2);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Torque_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::exosystem::Torque_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::exosystem::Torque_<ContainerAllocator>& v)
  {
    s << indent << "torque1: ";
    Printer<float>::stream(s, indent + "  ", v.torque1);
    s << indent << "torque2: ";
    Printer<float>::stream(s, indent + "  ", v.torque2);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EXOSYSTEM_MESSAGE_TORQUE_H