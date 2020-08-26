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

class Motor_Force {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.motor1_force = null;
      this.motor2_force = null;
      this.xtheta = null;
      this.ytheta = null;
      this.ztheta = null;
    }
    else {
      if (initObj.hasOwnProperty('motor1_force')) {
        this.motor1_force = initObj.motor1_force
      }
      else {
        this.motor1_force = 0.0;
      }
      if (initObj.hasOwnProperty('motor2_force')) {
        this.motor2_force = initObj.motor2_force
      }
      else {
        this.motor2_force = 0.0;
      }
      if (initObj.hasOwnProperty('xtheta')) {
        this.xtheta = initObj.xtheta
      }
      else {
        this.xtheta = 0.0;
      }
      if (initObj.hasOwnProperty('ytheta')) {
        this.ytheta = initObj.ytheta
      }
      else {
        this.ytheta = 0.0;
      }
      if (initObj.hasOwnProperty('ztheta')) {
        this.ztheta = initObj.ztheta
      }
      else {
        this.ztheta = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Motor_Force
    // Serialize message field [motor1_force]
    bufferOffset = _serializer.float32(obj.motor1_force, buffer, bufferOffset);
    // Serialize message field [motor2_force]
    bufferOffset = _serializer.float32(obj.motor2_force, buffer, bufferOffset);
    // Serialize message field [xtheta]
    bufferOffset = _serializer.float32(obj.xtheta, buffer, bufferOffset);
    // Serialize message field [ytheta]
    bufferOffset = _serializer.float32(obj.ytheta, buffer, bufferOffset);
    // Serialize message field [ztheta]
    bufferOffset = _serializer.float32(obj.ztheta, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Motor_Force
    let len;
    let data = new Motor_Force(null);
    // Deserialize message field [motor1_force]
    data.motor1_force = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [motor2_force]
    data.motor2_force = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [xtheta]
    data.xtheta = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ytheta]
    data.ytheta = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ztheta]
    data.ztheta = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'shoulderexo/Motor_Force';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c76d4ea67ee1d454970fb9cd2fed9654';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 motor1_force
    float32 motor2_force
    float32 xtheta
    float32 ytheta
    float32 ztheta
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Motor_Force(null);
    if (msg.motor1_force !== undefined) {
      resolved.motor1_force = msg.motor1_force;
    }
    else {
      resolved.motor1_force = 0.0
    }

    if (msg.motor2_force !== undefined) {
      resolved.motor2_force = msg.motor2_force;
    }
    else {
      resolved.motor2_force = 0.0
    }

    if (msg.xtheta !== undefined) {
      resolved.xtheta = msg.xtheta;
    }
    else {
      resolved.xtheta = 0.0
    }

    if (msg.ytheta !== undefined) {
      resolved.ytheta = msg.ytheta;
    }
    else {
      resolved.ytheta = 0.0
    }

    if (msg.ztheta !== undefined) {
      resolved.ztheta = msg.ztheta;
    }
    else {
      resolved.ztheta = 0.0
    }

    return resolved;
    }
};

module.exports = Motor_Force;
