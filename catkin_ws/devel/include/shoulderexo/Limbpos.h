// Generated by gencpp from file shoulderexo/Limbpos.msg
// DO NOT EDIT!


#ifndef SHOULDEREXO_MESSAGE_LIMBPOS_H
#define SHOULDEREXO_MESSAGE_LIMBPOS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace shoulderexo
{
template <class ContainerAllocator>
struct Limbpos_
{
  typedef Limbpos_<ContainerAllocator> Type;

  Limbpos_()
    : xtheta(0.0)
    , ytheta(0.0)
    , ztheta(0.0)  {
    }
  Limbpos_(const ContainerAllocator& _alloc)
    : xtheta(0.0)
    , ytheta(0.0)
    , ztheta(0.0)  {
  (void)_alloc;
    }



   typedef float _xtheta_type;
  _xtheta_type xtheta;

   typedef float _ytheta_type;
  _ytheta_type ytheta;

   typedef float _ztheta_type;
  _ztheta_type ztheta;





  typedef boost::shared_ptr< ::shoulderexo::Limbpos_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::shoulderexo::Limbpos_<ContainerAllocator> const> ConstPtr;

}; // struct Limbpos_

typedef ::shoulderexo::Limbpos_<std::allocator<void> > Limbpos;

typedef boost::shared_ptr< ::shoulderexo::Limbpos > LimbposPtr;
typedef boost::shared_ptr< ::shoulderexo::Limbpos const> LimbposConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::shoulderexo::Limbpos_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::shoulderexo::Limbpos_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace shoulderexo

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsMessage': True, 'IsFixedSize': True, 'HasHeader': False}
// {'shoulderexo': ['/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsMessage< ::shoulderexo::Limbpos_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::shoulderexo::Limbpos_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::shoulderexo::Limbpos_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::shoulderexo::Limbpos_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::shoulderexo::Limbpos_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::shoulderexo::Limbpos_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::shoulderexo::Limbpos_<ContainerAllocator> >
{
  static const char* value()
  {
    return "397010c589a871e910a38f804cb36983";
  }

  static const char* value(const ::shoulderexo::Limbpos_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x397010c589a871e9ULL;
  static const uint64_t static_value2 = 0x10a38f804cb36983ULL;
};

template<class ContainerAllocator>
struct DataType< ::shoulderexo::Limbpos_<ContainerAllocator> >
{
  static const char* value()
  {
    return "shoulderexo/Limbpos";
  }

  static const char* value(const ::shoulderexo::Limbpos_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::shoulderexo::Limbpos_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 xtheta\n\
float32 ytheta\n\
float32 ztheta\n\
";
  }

  static const char* value(const ::shoulderexo::Limbpos_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::shoulderexo::Limbpos_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.xtheta);
      stream.next(m.ytheta);
      stream.next(m.ztheta);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Limbpos_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::shoulderexo::Limbpos_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::shoulderexo::Limbpos_<ContainerAllocator>& v)
  {
    s << indent << "xtheta: ";
    Printer<float>::stream(s, indent + "  ", v.xtheta);
    s << indent << "ytheta: ";
    Printer<float>::stream(s, indent + "  ", v.ytheta);
    s << indent << "ztheta: ";
    Printer<float>::stream(s, indent + "  ", v.ztheta);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SHOULDEREXO_MESSAGE_LIMBPOS_H
