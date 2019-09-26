// Auto-generated. Do not edit!

// (in-package exosystem.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Sysstatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.record_flag = null;
      this.theta_m1 = null;
      this.theta_l1 = null;
      this.delta_theta_r1 = null;
      this.Trr_ad = null;
      this.theta_m2 = null;
      this.theta_l2 = null;
      this.delta_theta_r2 = null;
      this.Trr_cf = null;
    }
    else {
      if (initObj.hasOwnProperty('record_flag')) {
        this.record_flag = initObj.record_flag
      }
      else {
        this.record_flag = 0;
      }
      if (initObj.hasOwnProperty('theta_m1')) {
        this.theta_m1 = initObj.theta_m1
      }
      else {
        this.theta_m1 = 0.0;
      }
      if (initObj.hasOwnProperty('theta_l1')) {
        this.theta_l1 = initObj.theta_l1
      }
      else {
        this.theta_l1 = 0.0;
      }
      if (initObj.hasOwnProperty('delta_theta_r1')) {
        this.delta_theta_r1 = initObj.delta_theta_r1
      }
      else {
        this.delta_theta_r1 = 0.0;
      }
      if (initObj.hasOwnProperty('Trr_ad')) {
        this.Trr_ad = initObj.Trr_ad
      }
      else {
        this.Trr_ad = 0.0;
      }
      if (initObj.hasOwnProperty('theta_m2')) {
        this.theta_m2 = initObj.theta_m2
      }
      else {
        this.theta_m2 = 0.0;
      }
      if (initObj.hasOwnProperty('theta_l2')) {
        this.theta_l2 = initObj.theta_l2
      }
      else {
        this.theta_l2 = 0.0;
      }
      if (initObj.hasOwnProperty('delta_theta_r2')) {
        this.delta_theta_r2 = initObj.delta_theta_r2
      }
      else {
        this.delta_theta_r2 = 0.0;
      }
      if (initObj.hasOwnProperty('Trr_cf')) {
        this.Trr_cf = initObj.Trr_cf
      }
      else {
        this.Trr_cf = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Sysstatus
    // Serialize message field [record_flag]
    bufferOffset = _serializer.int16(obj.record_flag, buffer, bufferOffset);
    // Serialize message field [theta_m1]
    bufferOffset = _serializer.float32(obj.theta_m1, buffer, bufferOffset);
    // Serialize message field [theta_l1]
    bufferOffset = _serializer.float32(obj.theta_l1, buffer, bufferOffset);
    // Serialize message field [delta_theta_r1]
    bufferOffset = _serializer.float32(obj.delta_theta_r1, buffer, bufferOffset);
    // Serialize message field [Trr_ad]
    bufferOffset = _serializer.float32(obj.Trr_ad, buffer, bufferOffset);
    // Serialize message field [theta_m2]
    bufferOffset = _serializer.float32(obj.theta_m2, buffer, bufferOffset);
    // Serialize message field [theta_l2]
    bufferOffset = _serializer.float32(obj.theta_l2, buffer, bufferOffset);
    // Serialize message field [delta_theta_r2]
    bufferOffset = _serializer.float32(obj.delta_theta_r2, buffer, bufferOffset);
    // Serialize message field [Trr_cf]
    bufferOffset = _serializer.float32(obj.Trr_cf, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Sysstatus
    let len;
    let data = new Sysstatus(null);
    // Deserialize message field [record_flag]
    data.record_flag = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [theta_m1]
    data.theta_m1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [theta_l1]
    data.theta_l1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta_theta_r1]
    data.delta_theta_r1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Trr_ad]
    data.Trr_ad = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [theta_m2]
    data.theta_m2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [theta_l2]
    data.theta_l2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta_theta_r2]
    data.delta_theta_r2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Trr_cf]
    data.Trr_cf = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 34;
  }

  static datatype() {
    // Returns string type for a message object
    return 'exosystem/Sysstatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a24a13feba27c82997977933cd4b8af4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16 record_flag
    float32 theta_m1
    float32 theta_l1
    float32 delta_theta_r1
    float32 Trr_ad
    float32 theta_m2
    float32 theta_l2
    float32 delta_theta_r2
    float32 Trr_cf
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Sysstatus(null);
    if (msg.record_flag !== undefined) {
      resolved.record_flag = msg.record_flag;
    }
    else {
      resolved.record_flag = 0
    }

    if (msg.theta_m1 !== undefined) {
      resolved.theta_m1 = msg.theta_m1;
    }
    else {
      resolved.theta_m1 = 0.0
    }

    if (msg.theta_l1 !== undefined) {
      resolved.theta_l1 = msg.theta_l1;
    }
    else {
      resolved.theta_l1 = 0.0
    }

    if (msg.delta_theta_r1 !== undefined) {
      resolved.delta_theta_r1 = msg.delta_theta_r1;
    }
    else {
      resolved.delta_theta_r1 = 0.0
    }

    if (msg.Trr_ad !== undefined) {
      resolved.Trr_ad = msg.Trr_ad;
    }
    else {
      resolved.Trr_ad = 0.0
    }

    if (msg.theta_m2 !== undefined) {
      resolved.theta_m2 = msg.theta_m2;
    }
    else {
      resolved.theta_m2 = 0.0
    }

    if (msg.theta_l2 !== undefined) {
      resolved.theta_l2 = msg.theta_l2;
    }
    else {
      resolved.theta_l2 = 0.0
    }

    if (msg.delta_theta_r2 !== undefined) {
      resolved.delta_theta_r2 = msg.delta_theta_r2;
    }
    else {
      resolved.delta_theta_r2 = 0.0
    }

    if (msg.Trr_cf !== undefined) {
      resolved.Trr_cf = msg.Trr_cf;
    }
    else {
      resolved.Trr_cf = 0.0
    }

    return resolved;
    }
};

module.exports = Sysstatus;
