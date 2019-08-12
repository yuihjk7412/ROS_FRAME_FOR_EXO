// Generated by gencpp from file exosystem/Encoder.msg
// DO NOT EDIT!


#ifndef EXOSYSTEM_MESSAGE_ENCODER_H
#define EXOSYSTEM_MESSAGE_ENCODER_H


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
struct Encoder_
{
  typedef Encoder_<ContainerAllocator> Type;

  Encoder_()
    : encoder1(0)
    , encoder2(0)  {
    }
  Encoder_(const ContainerAllocator& _alloc)
    : encoder1(0)
    , encoder2(0)  {
  (void)_alloc;
    }



   typedef uint16_t _encoder1_type;
  _encoder1_type encoder1;

   typedef uint16_t _encoder2_type;
  _encoder2_type encoder2;





  typedef boost::shared_ptr< ::exosystem::Encoder_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::exosystem::Encoder_<ContainerAllocator> const> ConstPtr;

}; // struct Encoder_

typedef ::exosystem::Encoder_<std::allocator<void> > Encoder;

typedef boost::shared_ptr< ::exosystem::Encoder > EncoderPtr;
typedef boost::shared_ptr< ::exosystem::Encoder const> EncoderConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::exosystem::Encoder_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::exosystem::Encoder_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace exosystem

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsMessage': True, 'IsFixedSize': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'exosystem': ['/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsMessage< ::exosystem::Encoder_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exosystem::Encoder_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exosystem::Encoder_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exosystem::Encoder_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exosystem::Encoder_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exosystem::Encoder_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::exosystem::Encoder_<ContainerAllocator> >
{
  static const char* value()
  {
    return "cd83c38535a6ecc48fe19927ddfdf036";
  }

  static const char* value(const ::exosystem::Encoder_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xcd83c38535a6ecc4ULL;
  static const uint64_t static_value2 = 0x8fe19927ddfdf036ULL;
};

template<class ContainerAllocator>
struct DataType< ::exosystem::Encoder_<ContainerAllocator> >
{
  static const char* value()
  {
    return "exosystem/Encoder";
  }

  static const char* value(const ::exosystem::Encoder_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::exosystem::Encoder_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint16 encoder1\n\
uint16 encoder2\n\
";
  }

  static const char* value(const ::exosystem::Encoder_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::exosystem::Encoder_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.encoder1);
      stream.next(m.encoder2);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Encoder_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::exosystem::Encoder_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::exosystem::Encoder_<ContainerAllocator>& v)
  {
    s << indent << "encoder1: ";
    Printer<uint16_t>::stream(s, indent + "  ", v.encoder1);
    s << indent << "encoder2: ";
    Printer<uint16_t>::stream(s, indent + "  ", v.encoder2);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EXOSYSTEM_MESSAGE_ENCODER_H