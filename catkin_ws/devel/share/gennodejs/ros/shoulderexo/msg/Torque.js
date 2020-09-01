// Auto-generated. Do not edit!

// (in-package shoulderexo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Torque {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.torque1 = null;
      this.torque2 = null;
      this.port_num = null;
    }
    else {
      if (initObj.hasOwnProperty('torque1')) {
        this.torque1 = initObj.torque1
      }
      else {
        this.torque1 = 0.0;
      }
      if (initObj.hasOwnProperty('torque2')) {
        this.torque2 = initObj.torque2
      }
      else {
        this.torque2 = 0.0;
      }
      if (initObj.hasOwnProperty('port_num')) {
        this.port_num = initObj.port_num
      }
      else {
        this.port_num = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Torque
    // Serialize message field [torque1]
    bufferOffset = _serializer.float32(obj.torque1, buffer, bufferOffset);
    // Serialize message field [torque2]
    bufferOffset = _serializer.float32(obj.torque2, buffer, bufferOffset);
    // Serialize message field [port_num]
    bufferOffset = _serializer.int32(obj.port_num, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Torque
    let len;
    let data = new Torque(null);
    // Deserialize message field [torque1]
    data.torque1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque2]
    data.torque2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [port_num]
    data.port_num = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'shoulderexo/Torque';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '67e3a742abd7e4b159e23cb00d1df783';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 torque1
    float32 torque2
    int32 port_num
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Torque(null);
    if (msg.torque1 !== undefined) {
      resolved.torque1 = msg.torque1;
    }
    else {
      resolved.torque1 = 0.0
    }

    if (msg.torque2 !== undefined) {
      resolved.torque2 = msg.torque2;
    }
    else {
      resolved.torque2 = 0.0
    }

    if (msg.port_num !== undefined) {
      resolved.port_num = msg.port_num;
    }
    else {
      resolved.port_num = 0
    }

    return resolved;
    }
};

module.exports = Torque;
