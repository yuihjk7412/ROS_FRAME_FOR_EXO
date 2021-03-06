# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from exosystem/Motor_Force.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class Motor_Force(genpy.Message):
  _md5sum = "c76d4ea67ee1d454970fb9cd2fed9654"
  _type = "exosystem/Motor_Force"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """float32 motor1_force
float32 motor2_force
float32 xtheta
float32 ytheta
float32 ztheta"""
  __slots__ = ['motor1_force','motor2_force','xtheta','ytheta','ztheta']
  _slot_types = ['float32','float32','float32','float32','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       motor1_force,motor2_force,xtheta,ytheta,ztheta

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(Motor_Force, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.motor1_force is None:
        self.motor1_force = 0.
      if self.motor2_force is None:
        self.motor2_force = 0.
      if self.xtheta is None:
        self.xtheta = 0.
      if self.ytheta is None:
        self.ytheta = 0.
      if self.ztheta is None:
        self.ztheta = 0.
    else:
      self.motor1_force = 0.
      self.motor2_force = 0.
      self.xtheta = 0.
      self.ytheta = 0.
      self.ztheta = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_5f().pack(_x.motor1_force, _x.motor2_force, _x.xtheta, _x.ytheta, _x.ztheta))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      end = 0
      _x = self
      start = end
      end += 20
      (_x.motor1_force, _x.motor2_force, _x.xtheta, _x.ytheta, _x.ztheta,) = _get_struct_5f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_5f().pack(_x.motor1_force, _x.motor2_force, _x.xtheta, _x.ytheta, _x.ztheta))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      end = 0
      _x = self
      start = end
      end += 20
      (_x.motor1_force, _x.motor2_force, _x.xtheta, _x.ytheta, _x.ztheta,) = _get_struct_5f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_5f = None
def _get_struct_5f():
    global _struct_5f
    if _struct_5f is None:
        _struct_5f = struct.Struct("<5f")
    return _struct_5f
